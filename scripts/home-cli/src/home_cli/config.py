from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path


CONFIG_DIR = Path.home() / ".config" / "home-cli"
CONFIG_PATH = CONFIG_DIR / "config.json"
DEFAULT_QUERY_ALLON = "turn on dining room and couch lights"
DEFAULT_QUERY_ALLOFF = "turn off all lights"
LEGACY_QUERY_ALLON = "turn on all lights"


@dataclass
class Config:
    backend: str = "assistant"
    assistant_client_secret_file: str = ""
    assistant_credentials_path: str = str(CONFIG_DIR / "google-oauth-credentials.json")
    assistant_project_id: str = ""
    assistant_device_model_id: str = ""
    assistant_device_id: str = ""
    assistant_language: str = "en-US"
    query_allon: str = DEFAULT_QUERY_ALLON
    query_alloff: str = DEFAULT_QUERY_ALLOFF
    base_url: str = ""
    token: str = ""
    entity_ids: list[str] | None = None


def load_config() -> Config:
    if not CONFIG_PATH.exists():
        return Config()

    data = json.loads(CONFIG_PATH.read_text(encoding="utf-8"))
    entity_ids = data.get("entity_ids")
    if not isinstance(entity_ids, list):
        entity_ids = None

    query_allon = str(data.get("query_allon", DEFAULT_QUERY_ALLON))
    if query_allon.strip().lower() == LEGACY_QUERY_ALLON:
        query_allon = DEFAULT_QUERY_ALLON

    return Config(
        backend=str(data.get("backend", "assistant")),
        assistant_client_secret_file=str(data.get("assistant_client_secret_file", "")),
        assistant_credentials_path=str(
            data.get(
                "assistant_credentials_path",
                CONFIG_DIR / "google-oauth-credentials.json",
            )
        ),
        assistant_project_id=str(data.get("assistant_project_id", "")),
        assistant_device_model_id=str(data.get("assistant_device_model_id", "")),
        assistant_device_id=str(data.get("assistant_device_id", "")),
        assistant_language=str(data.get("assistant_language", "en-US")),
        query_allon=query_allon,
        query_alloff=str(data.get("query_alloff", DEFAULT_QUERY_ALLOFF)),
        base_url=str(data.get("base_url", "")),
        token=str(data.get("token", "")),
        entity_ids=entity_ids,
    )


def save_config(config: Config) -> Path:
    CONFIG_DIR.mkdir(parents=True, exist_ok=True)
    payload = {
        "backend": config.backend,
        "assistant_client_secret_file": config.assistant_client_secret_file,
        "assistant_credentials_path": config.assistant_credentials_path,
        "assistant_project_id": config.assistant_project_id,
        "assistant_device_model_id": config.assistant_device_model_id,
        "assistant_device_id": config.assistant_device_id,
        "assistant_language": config.assistant_language,
        "query_allon": config.query_allon,
        "query_alloff": config.query_alloff,
        "base_url": config.base_url,
        "token": config.token,
        "entity_ids": config.entity_ids or [],
    }
    CONFIG_PATH.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    CONFIG_PATH.chmod(0o600)
    return CONFIG_PATH
