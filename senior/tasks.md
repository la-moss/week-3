# Tasks — Azure IAM (RBAC) Guardrail Failure

## Objective
Restore least-privilege compliance for the automation identity while keeping behavior consistent across regions.

## What you have
- Terraform configuration that models primary and secondary region resource groups, an automation identity, and RBAC wiring.
- A CI guardrail that blocks overly-broad permissions with a neutral message.

## Tasks
1. Reproduce the CI failure locally (format + validate + guardrail) and capture the exact failing message.
2. Identify the permission scope that violates least-privilege expectations (focus on custom role actions and any broad resource scopes).
3. Derive the intended operational scope for the automation identity and document it as an allow/deny matrix.
4. Implement a least-privilege correction that preserves the operational needs of the automation identity.
5. Ensure the primary and secondary region footprints behave consistently from an authorization perspective.
6. Provide evidence artifacts:
   - Before/after role definition diff (redacted if necessary)
   - CI output showing guardrail passing
   - Notes on risk and rollback (how to revert safely)

## Constraints
- Keep the change narrowly scoped to authorization (avoid “drive-by” refactors).
- Prefer deterministic, reviewable permissions over broad wildcards.
- Avoid introducing environment-specific divergence unless it is justified and documented.

## How to reproduce locally
1) From repo root, create and activate a virtualenv:
```
python3 -m venv .venv
source .venv/bin/activate
```
2) Install dependencies:
```
pip install -r requirements.txt
```
3) From `senior/terraform`, run:
```
terraform fmt -check
terraform init -backend=false
terraform validate
```
4) From repo root, run the guardrail:
```
python scripts/guardrails/run.py
```
   - Current failing message: `guardrail unmet: least-privilege policy violation`
   - Expected after fix: `guardrail satisfied: least-privilege policy aligned`
