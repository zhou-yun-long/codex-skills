# Codex Skills

Personal Codex skills managed as a single GitHub repository.

## Layout

```text
skills/
  github-repo-publisher/
    SKILL.md
    agents/
    scripts/
  opentest-workflow/
    SKILL.md
    agents/

docs/
  opentest-install.md
  opentest-workflow.md
  opentest-stage-spec.md
  opentest-few-cases.md
  opentest-workflow-diagram.png

commands/
  opentest/
    opentest-*.md

scripts/
  opentest/
    *.py
    *.ps1

examples/
  opentest/
    requirement_analysis.good.md
    test_points.good.md
    test_cases.good.json
    test_cases.bad.*.json
  opentest-demo/
    1_requirements/
    README.md
```

Each skill should stay self-contained under `skills/<skill-name>/`.
User-facing documentation and diagrams should live under `docs/`.

## Current Skills

- `github-repo-publisher`: Create, connect, and push local projects to GitHub repositories.
- `opentest-workflow`: Standardize OpenTest QA artifact generation, staged outputs, bilingual artifacts, quality gates, and readable Excel reports.

## OpenTest Docs

- [OpenTest 安装说明](docs/opentest-install.md)
- [OpenTest Workflow 使用说明](docs/opentest-workflow.md)
- [OpenTest 阶段规范](docs/opentest-stage-spec.md)
- [OpenTest Few Cases](docs/opentest-few-cases.md)
- [OpenTest 流程图](docs/opentest-workflow-diagram.png)

## OpenTest Reusable Files

- `commands/opentest/`: Claude slash commands to copy into `.claude/commands/`.
- `scripts/opentest/`: helper scripts to copy into project `scripts/`.
- `examples/opentest-demo/`: minimal demo requirement for smoke testing an installation.

## Sync Notes

When adding or updating a skill, copy the skill folder into `skills/<skill-name>/`, then commit and push this repository.
