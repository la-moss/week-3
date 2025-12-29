#!/usr/bin/env python3
"""Offline least-privilege guardrail for custom role definitions."""

from __future__ import annotations

import re
import sys
from pathlib import Path


def count_wildcard_actions(base_dir: Path) -> int:
    """Count permissions blocks that include wildcard actions."""
    count = 0
    for tf_file in sorted(base_dir.rglob("*.tf")):
        text = tf_file.read_text()
        for match in re.finditer(r"permissions\s*{[^}]*?actions\s*=\s*\[(.*?)\]", text, re.S | re.I):
            block = match.group(1)
            if re.search(r'"\*"', block):
                count += 1
    return count


def count_wildcard_not_actions(base_dir: Path) -> int:
    """Count permissions blocks that include wildcard not_actions/denies."""
    count = 0
    for tf_file in sorted(base_dir.rglob("*.tf")):
        text = tf_file.read_text()
        for match in re.finditer(r"permissions\s*{[^}]*?not_actions\s*=\s*\[(.*?)\]", text, re.S | re.I):
            block = match.group(1)
            if re.search(r'"\*"', block):
                count += 1
    return count


def count_broad_scopes(base_dir: Path) -> int:
    """Count role definitions that assign at subscription/tenant scope."""
    count = 0
    for tf_file in sorted(base_dir.rglob("*.tf")):
        text = tf_file.read_text()
        for match in re.finditer(r"assignable_scopes\s*=\s*\[(.*?)\]", text, re.S | re.I):
            scopes_block = match.group(1)
            if re.search(r'"/subscriptions/|"/"?\s*\]"', scopes_block):
                count += 1
    return count


def count_missing_not_actions(base_dir: Path) -> int:
    """Count permissions blocks that do not declare not_actions."""
    count = 0
    for tf_file in sorted(base_dir.rglob("*.tf")):
        text = tf_file.read_text()
        for match in re.finditer(r"permissions\s*{(.*?)}", text, re.S | re.I):
            block = match.group(1)
            if "not_actions" not in block:
                count += 1
    return count


def main() -> int:
    repo_root = Path(__file__).resolve().parents[2]
    terraform_dir = repo_root / "senior" / "terraform"

    if not terraform_dir.exists():
        print("guardrail error: expected terraform directory missing", file=sys.stderr)
        return 1

    wildcard_actions = count_wildcard_actions(terraform_dir)
    wildcard_not_actions = count_wildcard_not_actions(terraform_dir)
    broad_scopes = count_broad_scopes(terraform_dir)
    missing_not_actions = count_missing_not_actions(terraform_dir)

    violations_found = any([wildcard_actions, wildcard_not_actions, broad_scopes, missing_not_actions])

    if violations_found:
        print("guardrail unmet: least-privilege policy violation")
        if wildcard_actions:
            print(f"detected wildcard actions in {wildcard_actions} block(s)")
        if wildcard_not_actions:
            print(f"detected wildcard not_actions in {wildcard_not_actions} block(s)")
        if broad_scopes:
            print(f"detected broad assignable scopes in {broad_scopes} block(s)")
        if missing_not_actions:
            print(f"detected permissions missing not_actions in {missing_not_actions} block(s)")
        return 1

    print("guardrail satisfied: least-privilege policy aligned")
    return 0


if __name__ == "__main__":
    sys.exit(main())

