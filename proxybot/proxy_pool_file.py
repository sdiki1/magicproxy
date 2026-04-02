from __future__ import annotations

import json
from pathlib import Path
from typing import Any


def apply_pool_credential_updates(
    pool_file_path: str | None,
    updates: list[dict[str, Any]],
) -> int:
    if not pool_file_path or not updates:
        return 0

    path = Path(pool_file_path)
    if not path.exists():
        return 0

    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise ValueError("Proxy pool file must contain JSON array")

    updates_by_port: dict[int, tuple[str, str]] = {}
    for item in updates:
        port = item.get("port")
        username = item.get("username")
        password = item.get("password")
        if not isinstance(port, int):
            continue
        if not isinstance(username, str) or not username.strip():
            continue
        if not isinstance(password, str) or not password.strip():
            continue
        updates_by_port[port] = (username, password)

    if not updates_by_port:
        return 0

    changed = 0
    for item in raw:
        if not isinstance(item, dict):
            continue
        port = item.get("port")
        if not isinstance(port, int):
            continue
        creds = updates_by_port.get(port)
        if creds is None:
            continue

        username, password = creds
        if item.get("username") == username and item.get("password") == password:
            continue

        item["username"] = username
        item["password"] = password
        changed += 1

    if changed == 0:
        return 0

    tmp_path = path.with_suffix(f"{path.suffix}.tmp")
    tmp_path.write_text(json.dumps(raw, ensure_ascii=False, indent=2), encoding="utf-8")
    tmp_path.replace(path)

    return changed
