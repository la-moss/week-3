# Guardrail: Least-Privilege Policy Check (Python + venv)

This guardrail checks Terraform role definitions for wildcard actions and fails with the neutral message `guardrail unmet: least-privilege policy violation` when detected.

## Setup (run from repo root)
1) Create and activate a virtualenv:
```
python3 -m venv .venv
source .venv/bin/activate
```
2) Install dependencies (none required today, but keep the step):
```
pip install -r requirements.txt
```

## Run locally
```
python scripts/guardrails/run.py
```

## Expected outcomes
- Failure: `guardrail unmet: least-privilege policy violation`
- Success: `guardrail satisfied: least-privilege policy aligned`

