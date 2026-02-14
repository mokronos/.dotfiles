from __future__ import annotations

import json
from pathlib import Path

import grpc
import requests
from google.assistant.embedded.v1alpha2 import embedded_assistant_pb2
from google.assistant.embedded.v1alpha2 import embedded_assistant_pb2_grpc
from google.auth.transport.grpc import secure_authorized_channel
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow


ASSISTANT_SCOPE = "https://www.googleapis.com/auth/assistant-sdk-prototype"
ASSISTANT_ENDPOINT = "embeddedassistant.googleapis.com:443"
DEVICE_API_BASE = "https://embeddedassistant.googleapis.com/v1alpha2/projects"


def run_oauth_flow(client_secret_file: Path) -> Credentials:
    flow = InstalledAppFlow.from_client_secrets_file(
        str(client_secret_file),
        scopes=[ASSISTANT_SCOPE],
    )
    return flow.run_local_server(host="127.0.0.1", port=0, open_browser=True)


def save_credentials(credentials: Credentials, credentials_path: Path) -> Path:
    credentials_path.parent.mkdir(parents=True, exist_ok=True)
    credentials_path.write_text(credentials.to_json() + "\n", encoding="utf-8")
    credentials_path.chmod(0o600)
    return credentials_path


def load_credentials(credentials_path: Path) -> Credentials:
    data = json.loads(credentials_path.read_text(encoding="utf-8"))
    return Credentials.from_authorized_user_info(data, scopes=[ASSISTANT_SCOPE])


def ensure_device_registration(
    credentials: Credentials,
    project_id: str,
    device_model_id: str,
    device_id: str,
) -> None:
    credentials.refresh(Request())
    headers = {
        "Authorization": f"Bearer {credentials.token}",
        "Content-Type": "application/json",
    }

    model_payload = {
        "project_id": project_id,
        "device_model_id": device_model_id,
        "manifest": {
            "manufacturer": "home-cli",
            "product_name": "home-cli light",
            "device_description": "Terminal client for Assistant light commands",
        },
        "device_type": "action.devices.types.LIGHT",
        "traits": ["action.devices.traits.OnOff"],
    }
    model_response = requests.post(
        f"{DEVICE_API_BASE}/{project_id}/deviceModels/",
        headers=headers,
        json=model_payload,
        timeout=30,
    )
    if model_response.status_code not in (200, 409):
        raise RuntimeError(
            "Assistant device model registration failed: "
            f"{model_response.status_code} {model_response.text}"
        )

    device_payload = {
        "id": device_id,
        "model_id": device_model_id,
        "nickname": "Home CLI Light",
        "client_type": "SDK_LIBRARY",
    }
    device_response = requests.post(
        f"{DEVICE_API_BASE}/{project_id}/devices/",
        headers=headers,
        json=device_payload,
        timeout=30,
    )
    if device_response.status_code not in (200, 409):
        raise RuntimeError(
            "Assistant device registration failed: "
            f"{device_response.status_code} {device_response.text}"
        )


class AssistantClient:
    def __init__(
        self,
        credentials: Credentials,
        device_model_id: str,
        device_id: str,
        language_code: str,
    ) -> None:
        self.credentials = credentials
        self.device_model_id = device_model_id
        self.device_id = device_id
        self.language_code = language_code

    def query(self, text_query: str) -> str:
        channel = secure_authorized_channel(
            self.credentials,
            Request(),
            ASSISTANT_ENDPOINT,
        )
        stub = embedded_assistant_pb2_grpc.EmbeddedAssistantStub(channel)

        config = embedded_assistant_pb2.AssistConfig(
            text_query=text_query,
            audio_out_config=embedded_assistant_pb2.AudioOutConfig(
                encoding=embedded_assistant_pb2.AudioOutConfig.LINEAR16,
                sample_rate_hertz=16000,
                volume_percentage=50,
            ),
            dialog_state_in=embedded_assistant_pb2.DialogStateIn(
                language_code=self.language_code,
            ),
        )
        config.device_config.device_id = self.device_id
        config.device_config.device_model_id = self.device_model_id

        request = embedded_assistant_pb2.AssistRequest(config=config)
        response_text: str | None = None

        try:
            for response in stub.Assist(iter([request])):
                if response.dialog_state_out.supplemental_display_text:
                    response_text = response.dialog_state_out.supplemental_display_text
                elif response.speech_results:
                    response_text = response.speech_results[-1].transcript
        except grpc.RpcError as exc:
            details = exc.details() if hasattr(exc, "details") else str(exc)
            raise RuntimeError(f"Assistant API error: {details}") from exc

        if response_text:
            return response_text

        return "Command sent."
