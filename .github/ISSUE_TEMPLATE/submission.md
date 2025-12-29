---
name: Submission
about: Provide your fixes and evidence for the guardrail incident ticket.
title: "[Submission] Azure IAM (Senior)"
labels: []
assignees: []
---

## Summary
- What you changed and why

## Evidence
- Before/after role definition diff
- Allow/Deny matrix for the automation identity
- CI run showing `guardrail satisfied`

## Rollback
- How to revert safely if needed
---
name: Submission
about: Evidence + notes for completing the practice ticket
title: "[submission] Azure IAM Terraform - least privilege guardrail"
labels: ["submission"]
---

## Summary
- What was failing and why (symptoms only)?

## Evidence
- CI logs (redacted)
- Role/policy diff (before/after)
- Allow/deny matrix for intended actions

## Change notes
- What changed (high level)?
- Risk/rollback plan

## Post-checks
- Anything verified after the change?
