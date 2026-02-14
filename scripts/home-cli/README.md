# home-cli

Small CLI for controlling room lights from the terminal.

Current backend: Google Assistant SDK text queries.

## Setup (Google Assistant SDK)

1. Create a Google Cloud project named `google-home-cli`.
2. Create OAuth desktop credentials in that project and download the JSON file.
3. Run auth:

```bash
home auth \
  --client-secret-file ~/Downloads/client_secret.json \
  --project-id google-home-cli
```

4. Test:

```bash
home say "what time is it"
home allon
home alloff
```

`home auth` auto-registers a simple Assistant SDK LIGHT model + device instance for this CLI.
