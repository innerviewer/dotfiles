#!/usr/bin/env python3
# A simple Python script to watch for hyprctl client changes
import subprocess
import time
import re
import sys

INTERVAL = 0.3  # seconds between checks
HYPRCTL_CMD = ["hyprctl", "clients"]


def get_clients():
    """Return dict of windows from hyprctl clients"""
    try:
        out = subprocess.check_output(HYPRCTL_CMD, text=True)
    except subprocess.CalledProcessError:
        return {}

    clients = {}
    current_id = None
    current_info = {}

    for line in out.splitlines():
        if line.startswith("Window "):
            if current_id:
                clients[current_id] = current_info
            match = re.match(r"Window\s+([0-9a-fx]+)\s+->\s+(.*):", line)
            if match:
                current_id = match.group(1)
                current_info = {"desc": match.group(2)}
        elif ":" in line and current_id:
            key, val = [s.strip() for s in line.split(":", 1)]
            current_info[key] = val

    if current_id:
        clients[current_id] = current_info
    return clients


def log_window_info(info):
    """Print all info about a window"""
    print("Window info:")
    for key, val in info.items():
        print(f"  {key}: {val}")

    # Check for transient or dialog
    windowtype = info.get("windowtype", "").lower()
    transient = info.get("transient", "").lower()
    if windowtype == "dialog":
        print("  -> This is a dialog window.")
    if transient == "true":
        print("  -> This is a transient (popup) window.")
    print()


def main():
    print("Watching windows... Press Ctrl+C to stop.\n")
    prev = get_clients()
    seen_ids = set(prev.keys())

    try:
        while True:
            time.sleep(INTERVAL)
            current = get_clients()
            current_ids = set(current.keys())

            new_ids = current_ids - seen_ids
            closed_ids = seen_ids - current_ids

            if new_ids or closed_ids:
                print("---- Change detected ----")
                if new_ids:
                    for wid in new_ids:
                        info = current[wid]
                        print(
                            f"[+] New window {wid}: {info.get('class', '')} -> {info.get('title', info.get('desc', ''))}"
                        )
                        log_window_info(info)
                if closed_ids:
                    for wid in closed_ids:
                        print(f"[-] Closed window {wid}")
                seen_ids = current_ids
    except KeyboardInterrupt:
        print("\nStopping watcher.")
        sys.exit(0)


if __name__ == "__main__":
    main()
