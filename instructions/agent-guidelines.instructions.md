---
description: 'Agent creation and management guidelines following awesome-copilot standards'
applyTo: "**/*.{agent.md,md}"
---

# Agent Guidelines

Complete agent creation patterns and best practices for VS Code AI agents.

## YAML Frontmatter Requirements

### Required Fields

```yaml
---
name: agent-name
description: "Agent purpose and capabilities"
model: 'claude-3-5-sonnet-20241022'
target: 'copilot'
tools:
  - str_replace_editor
  - bash
handoffs:
  - label: "Action Description"
    prompt: "What to ask the receiving agent"
    agent: "target-agent-name"
---
```

### Supported Tools

- `str_replace_editor` - File editing capabilities
- `bash` - Terminal command execution
- `python` - Python environment access

### Model Options

- `claude-3-5-sonnet-20241022` - Recommended for comprehensive agents
- Other Claude 3.5 Sonnet variants for specific use cases

### Target

- Always use `copilot` for VS Code agents

## Agent Types

### Comprehensive Agents

Full-capability agents with broad expertise:

- `django-dev` - Complete Django/Python development
- `dotnet-dev` - Complete .NET/C# development
- `full-stack` - Cross-platform analysis and integration
- `task-planner` - Project planning and management
- `doc-writer` - Documentation and visualization

### Focused Agents

Specialized agents for specific tasks:

- `django-explorer-agent` - Rapid Django project exploration
- `django-analyzer-agent` - Deep Django code analysis
- `mermaid-specialist-agent` - Diagram creation specialist

## Handoff Workflows

### Purpose

Handoffs enable guided multi-step workflows where agents delegate specific tasks to specialized agents.

### Best Practices

1. **Clear Labels**: Use descriptive labels for each handoff
2. **Specific Prompts**: Include exact context for the receiving agent
3. **Logical Flow**: Design handoffs that create coherent workflows
4. **Agent Matching**: Choose appropriate target agents for each task

### Common Patterns

```yaml
# Documentation handoff
- label: "Documentation"
  prompt: "Document the implementation with architectural diagrams"
  agent: "doc-writer"

# Planning handoff
- label: "Task Planning"
  prompt: "Plan related tasks using Brazilian Agile methodology"
  agent: "task-planner"

# Cross-platform analysis
- label: "Cross-Platform Analysis"
  prompt: "Analyze integration with other technology stacks"
  agent: "full-stack"
```

## Agent Description Format

### Structure

```
**AGENT TYPE** — Brief purpose statement. USE FOR: specific use cases; USE FOR: more cases. PROVIDES: capabilities; PROVIDES: more capabilities. LEVERAGES: skill1 for purpose; skill2 for purpose.
```

### Example

```
**PYTHON/DJANGO DEVELOPER** — All-purpose Python and Django development agent with deep juntossomosmais expertise. USE FOR: Django app development; DRF API creation; Python scripting; database modeling. PROVIDES: comprehensive Django/Python solutions; StandardModelMixin integration. LEVERAGES: django-explorer for rapid discovery; django-analyzer for deep investigation.
```

## Anti-Hallucination Patterns

### MCP-First Architecture

- Use explicit MCP tool names in all external API calls
- Implement STOP conditions when data is unavailable
- Ask users for clarification instead of making assumptions
- Verify repository structures via GitHub API before proceeding

### Error Handling

- Use `SkillExecutionStop` when encountering data access issues
- Provide clear user guidance when external systems are unavailable
- Include fallback strategies for common failure scenarios

## Awesome Copilot Compliance

### Required Elements

1. **YAML Frontmatter**: Proper structure with all required fields
2. **Tool Usage**: Only supported VS Code tools
3. **Handoff Workflows**: Enable guided multi-agent processes
4. **Model Compatibility**: Use supported Claude models
5. **Target Specification**: Always 'copilot' for VS Code agents

### Forbidden Elements

- `applyTo` patterns (use instruction files instead)
- Unknown or custom tools
- Missing handoff labels
- Unsupported model names

## Testing and Validation

### Before Deployment

1. **YAML Validation**: Ensure all frontmatter is properly formatted
2. **Tool Verification**: Confirm all tools are supported
3. **Handoff Testing**: Verify handoff workflows function correctly
4. **Model Testing**: Test with specified Claude model
5. **Integration Testing**: Ensure proper skill integration

### Common Issues

- Missing quotes in YAML strings
- Invalid tool names
- Missing handoff labels
- Incorrect model specifications
- Unsupported applyTo patterns

## Skill Integration

### Skill Usage Patterns

Agents leverage skills through natural language processing:

```
"Apply the django-explorer skill to understand project structure"
"Use mermaid-expert skill to create system diagrams"
"Leverage brazilian-agile-framework for Planning Poker estimation"
```

### Skill Categories

- **Technology Skills**: django-*, dotnet-*, mermaid-*
- **Process Skills**: brazilian-agile-framework, pre-commit-validator
- **Analysis Skills**: github-repository-investigator, har-analysis
- **Validation Skills**: r2d2-compliance-validator, library-checker

## Agent Coordination

### Multi-Agent Workflows

Design agents to work together through handoffs:

1. **Planning Phase**: task-planner → implementation agents
2. **Implementation Phase**: specialized agents → doc-writer
3. **Analysis Phase**: explorer → analyzer → implementer
4. **Documentation Phase**: any agent → doc-writer

### Conflict Prevention

- Clear agent responsibilities prevent overlap
- Handoff workflows maintain proper delegation
- Skill specialization ensures focused expertise
- Error handling prevents cascade failures

## Maintenance and Updates

### Version Control

- Track agent changes through git commits
- Document capability updates in agent descriptions
- Maintain backward compatibility for handoff workflows
- Update skill references as skills evolve

### Performance Monitoring

- Monitor handoff success rates
- Track agent usage patterns
- Identify optimization opportunities
- Update tools and model versions as needed

## Examples

### Minimal Agent

```yaml
---
name: example-agent
description: "**EXAMPLE AGENT** — Simple demonstration agent. USE FOR: testing; examples. PROVIDES: basic functionality."
model: 'claude-3-5-sonnet-20241022'
target: 'copilot'
tools:
  - str_replace_editor
---
```

### Complex Agent with Handoffs

```yaml
---
name: comprehensive-dev
description: "**COMPREHENSIVE DEVELOPER** — Full-stack development capabilities. USE FOR: complex projects; integration tasks. PROVIDES: end-to-end development; architectural guidance. LEVERAGES: multiple technology skills; planning frameworks."
model: 'claude-3-5-sonnet-20241022'
target: 'copilot'
tools:
  - str_replace_editor
  - bash
  - python
handoffs:
  - label: "Documentation"
    prompt: "Create comprehensive documentation for the implementation"
    agent: "doc-writer"
  - label: "Task Planning"
    prompt: "Break down the implementation into manageable tasks"
    agent: "task-planner"
---
```

This guideline ensures agents are created following awesome-copilot standards with proper YAML frontmatter, tool usage, and handoff workflows.
