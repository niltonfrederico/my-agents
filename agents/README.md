# GitHub Copilot Agents

Custom agents for GitHub Copilot providing specialized expertise across technology stacks and development workflows.

## Overview

This directory contains both **comprehensive agents** (full-capability) and **focused agents** (specialized) following [awesome-copilot](https://awesome-copilot.github.com/) standards for maximum flexibility and evaluation.

## Agent Categories

### 🔧 Comprehensive Development Agents

Full-capability agents with broad expertise and skill integration:

- **[django-dev](django-dev.agent.md)** — Complete Python/Django development with juntossomosmais patterns
- **[dotnet-dev](dotnet-dev.agent.md)** — Complete .NET/C# development with ASP.NET Core expertise
- **[full-stack](full-stack.agent.md)** — Cross-platform analysis and integration (Python ↔ .NET)

### 📋 Strategic Planning Agents

Task planning and project management with Brazilian Agile methodology:

- **[task-planner](task-planner.agent.md)** — Monday.com integration with comprehensive planning workflows

### 📚 Documentation & Communication Agents

Technical documentation and visualization specialists:

- **[doc-writer](doc-writer.agent.md)** — Comprehensive documentation with Mermaid diagram mastery

### 🤖 Meta-Management Agents

Agent and skill creation and management:

- **[saitama](saitama.agent.md)** — Meta-agent for creating and managing agents/skills

## 🎯 Focused Specialist Agents

Specialized agents for specific workflows (evaluation):

### Django Specialists

- **[django-explorer-agent](django-explorer-agent.agent.md)** — Rapid Django project exploration
- **[django-analyzer-agent](django-analyzer-agent.agent.md)** — Deep Django code analysis
- **[django-documenter-agent](django-documenter-agent.agent.md)** — Django-specific documentation

### .NET Specialists  

- **[dotnet-explorer-agent](dotnet-explorer-agent.agent.md)** — Rapid .NET project exploration

### Planning Specialists

- **[monday-analyzer-agent](monday-analyzer-agent.agent.md)** — Monday.com task validation

### Documentation Specialists

- **[mermaid-specialist-agent](mermaid-specialist-agent.agent.md)** — Mermaid diagram creation

## 🔄 Handoff Workflows

All agents implement **flexible handoff patterns** for guided multi-step workflows:

```yaml
handoffs:
  - prompt: "Document the implementation with architectural diagrams"
    agent: "doc-writer"
  - prompt: "Plan related tasks using Brazilian Agile methodology"
    agent: "task-planner"
```

### Common Workflow Patterns

1. **Planning → Implementation → Documentation**
   - `task-planner` → `django-dev`/`dotnet-dev` → `doc-writer`

2. **Exploration → Analysis → Implementation**
   - `django-explorer-agent` → `django-analyzer-agent` → `django-dev`

3. **Cross-Platform Integration**
   - `full-stack` → `django-dev` + `dotnet-dev` → `doc-writer`

## 🛠️ Agent Configuration

### YAML Frontmatter Format

All agents follow awesome-copilot standards:

```yaml
---
name: agent-name
description: "**AGENT TYPE** — Purpose and capabilities description"
model: 'Claude Sonnet 4.5'
target: 'vscode'
tools:
  - file_operations
  - terminal
handoffs:
  - prompt: "Next step description"
    agent: "target-agent"
---
```

### Required Fields

- **name**: Agent identifier (matches filename)
- **description**: Purpose, capabilities, and usage patterns
- **model**: AI model specification  
- **target**: Environment (vscode)
- **tools**: Available tool list
- **handoffs**: Flexible transition workflows

## 💡 Usage Patterns

### Invoking Comprehensive Agents

Use comprehensive agents for complete workflows:

```typescript
// Complete Django development workflow
@django-dev Create a DRF API with authentication and STOMP messaging

// Full-stack integration analysis  
@full-stack Analyze integration between Python and .NET services

// Comprehensive task planning
@task-planner Plan implementation from Monday.com task URL
```

### Invoking Focused Agents

Use focused agents for specific tasks:

```typescript  
// Quick Django exploration
@django-explorer-agent What is the structure of this Django project?

// Deep technical analysis
@django-analyzer-agent Analyze performance bottlenecks in this Django app

// Mermaid diagram creation
@mermaid-specialist-agent Create a sequence diagram for this API flow
```

### Handoff Usage

Let agents guide you through multi-step workflows:

1. Start with any relevant agent
2. Agent completes its task
3. Use handoff buttons to transition to next step
4. Continue guided workflow until complete

## 🔍 Agent Selection Guide

### When to Use Comprehensive Agents

- **Complete workflows** requiring multiple skills
- **Complex projects** with cross-cutting concerns
- **Integration tasks** spanning multiple technologies
- **Unknown scope** - let agent determine approach

### When to Use Focused Agents

- **Specific tasks** with clear scope
- **Evaluation period** - comparing approaches
- **Specialized expertise** for narrow domains
- **Learning workflow** - understanding agent boundaries

## 🏗️ Skills Integration

All agents leverage shared skills from the [skills](../skills/) directory:

- **Exploration**: `django-explorer`, `dotnet-explorer`
- **Analysis**: `django-analyzer`, `dotnet-analyzer`  
- **Documentation**: `django-documenter`, `dotnet-documenter`
- **Validation**: `pre-commit-validator`, `r2d2-compliance-validator`
- **Planning**: `monday-task-analyzer`, `brazilian-agile-framework`

## 🔐 Anti-Hallucination Patterns

All agents implement March 2026 anti-hallucination requirements:

- **MCP-First**: Explicit MCP tool usage (`mcp_io_github_git_*`)
- **STOP Conditions**: `SkillExecutionStop` when data unavailable  
- **User Confirmation**: `vscode_askQuestions` instead of assumptions
- **Real Investigation**: GitHub API verification for all repository operations

## 📈 Evaluation Strategy

The dual approach (comprehensive + focused) enables evaluation of:

- **Workflow Efficiency**: Single vs. multi-agent workflows
- **Specialization Benefits**: Deep expertise vs. broad capability  
- **Handoff Effectiveness**: Guided transitions vs. manual coordination
- **User Experience**: Simplicity vs. flexibility

## 🎯 Success Metrics

- **Task Completion**: Successful resolution of user requests
- **Handoff Adoption**: Usage of guided workflow transitions  
- **Specialization Value**: Focused agent effectiveness vs. comprehensive
- **User Satisfaction**: Preference feedback and adoption patterns

---

## 📚 Related Documentation

- **[Skills](../skills/README.md)** - Reusable skill packages with bundled resources
- **[Instructions](../instructions/README.md)** - File-pattern-based coding guidelines
- **[Root README](../README.md)** - Workspace overview and quick start guide
- **[Awesome Copilot](https://awesome-copilot.github.com/)** - Official standards and patterns
