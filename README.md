# Azure IAM (RBAC) — Terraform Incident Practice

## Context
A recent access review flagged elevated privileges in a custom RBAC role used by an automation identity. At the same time, rollout work has started to duplicate the workload footprint into a secondary region for resiliency. A policy gate in CI has begun blocking changes with the message:

**guardrail unmet: least-privilege policy violation**

## Symptoms
- PR checks fail on the guardrail step with a least-privilege violation message.
- Security reviewers report that the automation identity can perform more actions than intended.
- Differences in authorization behavior are being observed between primary and secondary region resources.

## Acceptance criteria
- CI passes: formatting, init/validate, and the least-privilege guardrail.
- The automation identity has only the permissions required for its intended operational scope.
- Authorization behavior is consistent across primary and secondary region resources.
- Evidence is attached: before/after permission diff, and the resulting role definition changes (redacted as needed).

## Local validation (recommended)
1) Create and activate a virtualenv:
```
python3 -m venv .venv
source .venv/bin/activate
```
2) Install dependencies:
```
pip install -r requirements.txt
```
3) Run Terraform checks from `senior/terraform`:
```
terraform fmt -check
terraform init -backend=false
terraform validate
```
4) Run the guardrail from repo root:
```
python scripts/guardrails/run.py
```
   - Failure message (expected until fixed): `guardrail unmet: least-privilege policy violation`
   - Passing message: `guardrail satisfied: least-privilege policy aligned`

## Evidence expectations
- Policy/role definition diff (before vs. after).
- A concise allow/deny matrix for the automation identity’s intended actions.
- CI run output showing the guardrail message resolved.
