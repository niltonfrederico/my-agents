# GitHub Copilot Skills

Reusable skills that provide specialized domain knowledge and capabilities for GitHub Copilot agents across technology stacks and workflows.

## Overview

Skills are self-contained packages with instructions and bundled resources that teach AI agents specialized capabilities. Each skill can include templates, examples, reference data, and detailed workflows alongside the main SKILL.md file.

## 🏗️ Skill Categories

### 🐍 Python/Django Development Skills

**Exploration & Analysis:**

- **[django-explorer](django-explorer/SKILL.md)** — Rapid Django project structure understanding
- **[django-analyzer](django-analyzer/SKILL.md)** — Deep Django code analysis and investigation
- **[django-documenter](django-documenter/SKILL.md)** — Django technical documentation with Mermaid diagrams

**Validation & Compliance:**

- **[library-checker](library-checker/SKILL.md)** — Python dependency validation against company policies

### ⚙️ .NET/C# Development Skills

**Exploration & Analysis:**

- **[dotnet-explorer](dotnet-explorer/SKILL.md)** — Rapid .NET project structure understanding  
- **[dotnet-analyzer](dotnet-analyzer/SKILL.md)** — Deep .NET code analysis and investigation
- **[dotnet-documenter](dotnet-documenter/SKILL.md)** — .NET technical documentation with Mermaid diagrams

**Validation & Compliance:**

- **[dotnet-library-checker](dotnet-library-checker/SKILL.md)** — NuGet dependency validation against company policies

### 📊 Project Management & Planning Skills

**Monday.com Integration:**

- **[monday-task-analyzer](monday-task-analyzer/SKILL.md)** — Complete Monday.com task analysis and validation
- **[monday-refinement-generator](monday-refinement-generator/SKILL.md)** — Implementation planning with Planning Poker estimation

**Brazilian Agile Methodology:**

- **[brazilian-agile-framework](brazilian-agile-framework/SKILL.md)** — Planning Poker estimation and Brazilian methodology validation

### 🎨 Visualization & Documentation Skills

**Mermaid Diagram Creation:**

- **[mermaid-expert](mermaid-expert/SKILL.md)** — Comprehensive Mermaid diagram creation (all types)
- **[mermaid-flowchart](mermaid-flowchart/SKILL.md)** — Specialized flowchart and process diagrams
- **[mermaid-sequence](mermaid-sequence/SKILL.md)** — Sequence diagrams for API and system interactions
- **[mermaid-mindmap](mermaid-mindmap/SKILL.md)** — Knowledge organization and system planning mindmaps

**Performance Analysis:**

- **[har-analysis](har-analysis/SKILL.md)** — HTTP Archive file analysis for performance insights

### 🔍 Investigation & Discovery Skills

**Repository Analysis:**

- **[github-repository-investigator](github-repository-investigator/SKILL.md)** — Real GitHub API investigation and architecture discovery

### ✅ Quality Assurance Skills

**Code Validation:**

- **[pre-commit-validator](pre-commit-validator/SKILL.md)** — Non-destructive code quality validation
- **[r2d2-compliance-validator](r2d2-compliance-validator/SKILL.md)** — Final compliance validation against organizational standards

## 📁 Skill Structure

Each skill follows the awesome-copilot bundled resource pattern:

```
skill-name/
├── SKILL.md              # Main skill instructions
├── templates/            # Optional: Template files
├── examples/             # Optional: Example code/configs
├── reference/            # Optional: Reference materials
└── assets/               # Optional: Additional resources
```

### SKILL.md Format

All skills use consistent YAML frontmatter:

```yaml
---
skill: true
name: "skill-name"
description: "**SKILL TYPE** — Purpose and capabilities description"
applyTo:
  - "**/*.py"           # File patterns where skill applies
  - "**/specific/**"
invokes:
  - "mcp_tool_name"     # Explicit MCP tool names
  - "other_skill_name"  # Other skills this skill uses
---
```

## 🔄 Skills Integration Patterns

### Multi-Skill Workflows

Skills are designed for composition and chaining:

```python
# Discovery → Analysis → Documentation workflow
project_structure = applySkill('django-explorer', {...})
analysis_results = applySkill('django-analyzer', {...})  
documentation = applySkill('django-documenter', {...})
```

### Cross-Stack Skills

Some skills work across multiple technology stacks:

- **github-repository-investigator**: Works with any repository
- **brazilian-agile-framework**: Applies to any technology stack
- **pre-commit-validator**: Supports Python, .NET, JavaScript validation
- **r2d2-compliance-validator**: Cross-platform organizational standards

### Validation Skills

Quality assurance skills provide comprehensive validation:

```python
# Parallel validation workflow  
code_quality = applySkill('pre-commit-validator', {'files': generated_files})
dependency_check = applySkill('library-checker', {'dependencies': deps})
compliance = applySkill('r2d2-compliance-validator', {'implementation': impl})
```

## 🛡️ Anti-Hallucination Patterns

All skills implement March 2026 safety requirements:

### MCP-First Tool Usage

- **Explicit MCP Tools**: All skills use specific MCP tool names (`mcp_io_github_git_*`)
- **No Generic References**: Never use `github.com` or `monday.com` - always MCP tools

### STOP-When-Stuck Protocol

```python
# When data is inaccessible
if not can_access_required_data:
    raise SkillExecutionStop(
        reason="🚫 STOP: Cannot access repository structure",
        user_action_required=True
    )
```

### Ask-User-When-Doubt

```python
# When requirements are unclear
unclear_requirements = vscode_askQuestions([
    {"header": "Clarification", "question": "Which analysis approach?"}
])
```

## 🎯 Skill Usage Patterns

### Direct Skill Application

```typescript
// Apply specific skill directly
applySkill('django-explorer', {
    target: '/path/to/project',
    focus: 'architecture_overview'
})
```

### Agent-Mediated Usage

```typescript
// Agents automatically select and apply relevant skills
@django-dev Analyze this Django application
// → Automatically uses django-explorer, django-analyzer, django-documenter
```

### Skill Chaining

```python
# Sequential skill application
exploration = applySkill('django-explorer', {target: project})
analysis = applySkill('django-analyzer', {context: exploration})
docs = applySkill('django-documenter', {analysis: analysis})
```

## 🔧 Creating New Skills

### Skill Development Guidelines

1. **Single Responsibility**: Each skill should have a focused, well-defined purpose
2. **Bundled Resources**: Include templates, examples, and reference materials
3. **MCP Integration**: Use explicit MCP tool names throughout
4. **Failsafe Patterns**: Include STOP conditions and user confirmation
5. **Cross-Agent Compatibility**: Design for use across multiple agents

### Skill Template Structure

Create new skills following this pattern:

```yaml
---
skill: true
name: "new-skill-name"
description: "**SKILL TYPE** — Purpose and detailed capabilities"
applyTo:
  - "**/*.ext"
invokes:
  - "mcp_specific_tool_name"
  - "existing_skill_name"
---

# Skill Name

## Purpose
Clear description of skill capabilities and use cases.

## STOP Conditions
When and how the skill should stop execution.

## Workflows
Step-by-step workflows and examples.
```

## 📚 Bundled Resources

### Template Files

Skills can include template files for common patterns:

- **Django**: Model templates, serializer patterns, API view templates
- **.NET**: Controller templates, entity patterns, service templates  
- **Documentation**: README templates, API doc templates
- **Configuration**: Docker templates, CI/CD templates

### Reference Materials

Include reference data for quick lookup:

- **API Patterns**: Common API design patterns and examples
- **Security Patterns**: Authentication and authorization templates
- **Performance Patterns**: Optimization techniques and examples
- **Testing Patterns**: Test structure and coverage examples

## 🎯 Success Metrics

### Skill Effectiveness

- **Reusability**: Same skill used across multiple agents
- **Accuracy**: Consistent, reliable outputs  
- **Performance**: Fast execution with minimal resource usage
- **User Satisfaction**: Positive feedback and adoption

### Quality Standards

- **MCP Compliance**: 100% explicit MCP tool usage
- **Safety Patterns**: All skills implement STOP and ask-user patterns
- **Documentation**: Complete and accurate skill documentation
- **Resource Quality**: High-quality templates and examples

---

## 📚 Related Documentation

- **[Agents](../agents/README.md)** - Custom agents that leverage these skills
- **[Instructions](../instructions/README.md)** - File-pattern-based coding guidelines  
- **[Root README](../README.md)** - Workspace overview and quick start guide
- **[Awesome Copilot Skills](https://github.com/github/awesome-copilot/blob/main/docs/README.skills.md)** - Official skill documentation
