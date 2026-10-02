#!/usr/bin/env python

import json
import subprocess
import time


def windows():
    clients = json.loads(subprocess.check_output(["hyprctl", "clients", "-j"]))
    return [client for client in clients if client["class"] == "zen"]


def wait_for(predicate):
    deadline = time.monotonic() + 60
    while time.monotonic() < deadline:
        clients = windows()
        if predicate(clients):
            return clients
        time.sleep(0.5)
    raise RuntimeError("Timed out waiting for Zen startup windows")


def move(client, workspace):
    selector = json.dumps("address:" + client["address"])
    subprocess.run(
        [
            "hyprctl",
            "eval",
            f'hl.dispatch(hl.dsp.window.move({{window = {selector}, workspace = "{workspace}", follow = false}}))',
        ],
        check=True,
    )


def outlook(client):
    return "Outlook" in client["title"]


def main():
    wait_for(bool)
    previous = None
    stable_since = time.monotonic()

    def restored(clients):
        nonlocal previous, stable_since
        state = [(client["address"], client["title"]) for client in clients]
        if state != previous:
            previous = state
            stable_since = time.monotonic()
        return clients and time.monotonic() - stable_since >= 5

    clients = wait_for(restored)
    browsing = [client for client in clients if not outlook(client)]
    while len(browsing) < 2:
        known = {client["address"] for client in clients}
        subprocess.Popen(["zen-browser", "--new-window"])
        clients = wait_for(lambda clients: any(client["address"] not in known for client in clients))
        browsing = [client for client in clients if not outlook(client)]

    for index, client in enumerate(browsing):
        move(client, 2 if index == 1 else 1)

    mail = [client for client in clients if outlook(client)]
    if not mail:
        known = {client["address"] for client in clients}
        subprocess.Popen(["zen-browser", "--new-window", "https://outlook.office.com/mail/"])
        clients = wait_for(lambda clients: any(client["address"] not in known for client in clients))
        mail = [client for client in clients if client["address"] not in known]
    for client in mail:
        move(client, 4)


if __name__ == "__main__":
    main()
