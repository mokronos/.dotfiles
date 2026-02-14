from __future__ import annotations

import json
from pathlib import Path

import typer

from home_cli.backends.assistant import AssistantClient
from home_cli.backends.assistant import ensure_device_registration
from home_cli.backends.assistant import load_credentials
from home_cli.backends.assistant import run_oauth_flow
from home_cli.backends.assistant import save_credentials
from home_cli.config import Config, load_config, save_config

app = typer.Typer(add_completion=False, no_args_is_help=True)
DEFAULT_CLIENT_SECRET_FILE = Path(__file__).resolve().parents[2] / "client_secret.json"


def _assistant_client(config: Config) -> AssistantClient:
    credentials_path = Path(config.assistant_credentials_path).expanduser()
    if not credentials_path.exists():
        raise typer.BadParameter(
            "OAuth credentials missing. Run `home auth --client-secret-file ...` first."
        )

    credentials = load_credentials(credentials_path)
    if not config.assistant_device_model_id or not config.assistant_device_id:
        raise typer.BadParameter(
            "Assistant device registration missing. Run `home auth` again."
        )
    return AssistantClient(
        credentials=credentials,
        device_model_id=config.assistant_device_model_id,
        device_id=config.assistant_device_id,
        language_code=config.assistant_language,
    )


def _run_query(text_query: str) -> None:
    config = load_config()
    client = _assistant_client(config)
    response = client.query(text_query)
    typer.echo(response)


@app.command()
def auth(
    client_secret_file: Path = typer.Option(
        DEFAULT_CLIENT_SECRET_FILE,
        dir_okay=False,
        file_okay=True,
        help="Google OAuth Desktop client secret JSON file.",
    ),
    project_id: str = typer.Option(
        "",
        help="Assistant SDK project id. Optional; defaults to client secret project_id.",
    ),
    language: str = typer.Option("en-US", help="Assistant language code."),
    query_allon: str = typer.Option(
        "turn on all lights", help="Text query used by `home allon`."
    ),
    query_alloff: str = typer.Option(
        "turn off all lights", help="Text query used by `home alloff`."
    ),
) -> None:
    client_secret_file = client_secret_file.expanduser()
    if not client_secret_file.exists():
        raise typer.BadParameter(
            f"Client secret file not found: {client_secret_file}. "
            "Put it at scripts/home-cli/client_secret.json or pass --client-secret-file."
        )

    credentials = run_oauth_flow(client_secret_file.expanduser())
    secret_json = json.loads(client_secret_file.read_text(encoding="utf-8"))
    secret_project_id = str(
        secret_json.get("installed", {}).get("project_id", "")
    ).strip()
    requested_project_id = project_id.strip()
    resolved_project_id = requested_project_id or secret_project_id
    if not resolved_project_id:
        raise typer.BadParameter(
            "Could not infer project_id from client secret. Pass --project-id explicitly."
        )
    if (
        requested_project_id
        and secret_project_id
        and secret_project_id != requested_project_id
    ):
        typer.echo(
            "Warning: --project-id does not match client secret project_id. "
            f"Using '{secret_project_id}' from client secret.",
            err=True,
        )
        resolved_project_id = secret_project_id

    device_model_id = f"{resolved_project_id}-home-cli-light-v1"
    device_id = "home_cli_light_1"
    ensure_device_registration(
        credentials=credentials,
        project_id=resolved_project_id,
        device_model_id=device_model_id,
        device_id=device_id,
    )

    existing = load_config()
    credentials_path = Path(existing.assistant_credentials_path).expanduser()
    saved_credentials_path = save_credentials(credentials, credentials_path)

    config = Config(
        backend="assistant",
        assistant_client_secret_file=str(client_secret_file),
        assistant_credentials_path=str(saved_credentials_path),
        assistant_project_id=resolved_project_id,
        assistant_device_model_id=device_model_id,
        assistant_device_id=device_id,
        assistant_language=language.strip(),
        query_allon=query_allon.strip(),
        query_alloff=query_alloff.strip(),
    )
    path = save_config(config)
    typer.echo(f"Saved config: {path}")
    typer.echo(f"Saved OAuth credentials: {saved_credentials_path}")
    typer.echo('Next: run `home say "what time is it"` to validate access.')


@app.command()
def say(
    text: str = typer.Argument(..., help="Text query sent to Google Assistant."),
) -> None:
    _run_query(text)


@app.command()
def allon() -> None:
    config = load_config()
    _run_query(config.query_allon)


@app.command()
def alloff() -> None:
    config = load_config()
    _run_query(config.query_alloff)


def main() -> None:
    app()


if __name__ == "__main__":
    main()
