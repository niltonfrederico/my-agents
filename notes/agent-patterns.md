# Agent Patterns & Configurations

## File Types for Agent Customization

- `.instructions.md` - General coding preferences and guidelines
- `.prompt.md` - Prompt modifications and context
- `.agent.md` - Agent mode definitions
- `SKILL.md` - Domain-specific knowledge packages
- `copilot-instructions.md` - Copilot-specific instructions
- `AGENTS.md` - Agent registry and descriptions

## Common YAML Frontmatter Patterns

### Basic Agent Definition

```yaml
---
title: "Agent Name"
description: "Brief description of purpose"
applyTo:
  - "*.py"
  - "src/**/*.ts"
tools:
  - file_operations
  - terminal
---
```

### Skill Definition Structure

```yaml
---

name: "skill-name"
description: "Domain expertise description"
---
```

### Specialized Mermaid Skills Pattern

```yaml
---

name: "mermaid-[type]"
description: "**MERMAID [TYPE] EXPERT** — Specialized skill for creating tech-focused [TYPE] diagrams. USE FOR: [use cases]; CREATES: [outputs]; TECH FOCUS: [emphasis]"
applyTo:
  - "**/*.md"
  - "**/*.mmd"
  - "**/docs/**/*"
invokes:
  - "mermaid-diagram-validator"
  - "mermaid-diagram-preview"
---
```

### Multi-Domain Analysis Skills Pattern

```yaml
---

name: "domain-analysis"
description: "**DOMAIN EXPERT** — Comprehensive analysis skill combining multiple capabilities. USE FOR: [specific analysis tasks]; CREATES: [outputs including diagrams]; TECH FOCUS: [domain expertise]"
applyTo:
  - "**/*.domain-extension"
  - "**/domain-specific-dirs/**/*"
invokes:
  - "specialized-skills"
  - "validation-tools"
  - "rendering-tools"
---
```

### Meta-Agent Example (Saitama)

```yaml
---
name: saitama
description: "**META-AGENT** — Specialized agent for creating, updating, and managing GitHub Copilot agents and skills..."
---
```

### VS Code vs Generic Agent YAML

**VS Code Agents (.agent.md):**

- Core attributes: `name`, `description`, `target`, `tools`
- No `applyTo` or `invokes` support  
- Tool names must match VS Code schema
- Supported: agents, argument-hint, disable-model-invocation, github, handoffs, model, user-invocable

**Skills/Instructions:**

- Support `applyTo`, `invokes`, more flexible
- Different attribute sets available

## ApplyTo Patterns

- `"*.extension"` - All files with extension
- `"folder/**/*"` - All files in folder recursively
- `"**/pattern.ext"` - Pattern matching anywhere in tree
- `["pattern1", "pattern2"]` - Multiple patterns

## Agent Mode Types

- **Workflow Skills** - Multi-step processes with domain knowledge  
- **Code Generators** - Specialized code creation
- **Reviewers** - Code analysis and feedback
- **Debuggers** - Problem diagnosis and fixing
- **Meta Agents** - Agents that create other agents/skills
- **Analysis Skills** - Domain-specific data analysis with visualization capabilities
- **Composite Skills** - Skills that invoke other specialized skills for enhanced functionality
- **Technology Stack Agents** - Comprehensive agents for specific tech stacks (Python/Django, .NET/C#)
- **Cross-Stack Analyzers** - Agents that bridge multiple technology stacks
- **Task Management Agents** - Specialized agents for project planning and task refinement
- **Documentation Agents** - Comprehensive documentation and visualization specialists

## New Agent Patterns (March 2026)

### Technology Stack Agent Pattern

```yaml
---
name: tech-dev-agent
description: "**TECHNOLOGY DEVELOPER** — All-purpose [Technology] development agent with deep juntossomosmais expertise. USE FOR: [tech stack] development; [framework] creation; [language] scripting; database modeling; messaging implementation; authentication systems; performance optimization. PROVIDES: comprehensive [tech] solutions; [company patterns]; security best practices; code quality enforcement. LEVERAGES: [stack]-explorer for discovery; [stack]-analyzer for investigation; [stack]-documenter for docs; library-checker for validation; brazilian-agile-framework; r2d2-compliance-validator."
applyTo:
  - "**/*.[tech-extension]"
  - "**/[tech-config-files]"
  - "**/[tech-specific-folders]/**"
tools:
  - file_operations
  - terminal
  - [tech_environment]
---
```

### Cross-Stack Analyzer Pattern

```yaml
---
name: full-stack-analyzer
description: "**FULL-STACK ANALYZER** — Dual-stack analysis agent mastering both [Stack A] and [Stack B] with integration expertise. USE FOR: cross-platform architecture analysis; migration planning; integration design; comparative analysis; unified patterns. LEVERAGES: both [stackA]-* and [stackB]-* skills; github-repository-investigator; brazilian-agile-framework."
applyTo:
  - "**/*.[stackA-extension]"
  - "**/*.[stackB-extension]"
  - "**/[shared-config-files]"
tools:
  - file_operations
  - terminal
  - [stackA_environment]
  - [stackB_environment]
  - github_api
---
```

### Task Management Agent Pattern

```yaml
---
name: task-planner
description: "**TASK PLANNING SPECIALIST** — Strategic task analysis and refinement agent with Brazilian Agile methodology expertise. USE FOR: task validation; refinement generation; Planning Poker estimation; implementation planning. LEVERAGES: task-analyzer; refinement-generator; brazilian-agile-framework; github-repository-investigator; r2d2-compliance-validator."
applyTo:
  - "**/[task-related]*.md"
  - "**/[planning-files]"
tools:
  - [task_management_api]
  - github_api
  - file_operations
  - mermaid_diagrams
---
```

### Documentation Specialist Pattern  

```yaml
---
name: doc-writer
description: "**DOCUMENTATION SPECIALIST** — Comprehensive documentation and diagram creation agent with advanced visualization expertise. USE FOR: technical documentation; API documentation; architectural diagrams; Mermaid generation; system documentation. LEVERAGES: all mermaid skills; performance-analysis; tech-documenters; github-repository-investigator."
applyTo:
  - "**/*.md"
  - "**/docs/**"
  - "**/README*"
  - "**/documentation/**"
tools:
  - file_operations
  - mermaid_diagrams
  - github_api
  - [analysis_tools]
  - markdown_tools
---
```

### Skill Leveraging Pattern

**Multiple Skills Integration:**

```yaml
LEVERAGES: skill1 for purpose; skill2 for purpose; skill3 for purpose
```

**Skill Categories by Function:**

- **Discovery Skills**: `*-explorer` for rapid understanding
- **Analysis Skills**: `*-analyzer` for deep investigation  
- **Documentation Skills**: `*-documenter` for comprehensive docs
- **Validation Skills**: `*-validator`, `*-checker` for compliance
- **Framework Skills**: `brazilian-agile-framework` for methodology
- **Visualization Skills**: `mermaid-*` for diagrams

### Professional Agent Naming Convention

**Function-Based Hierarchy:**

- **django-dev**: Python/Django development agent (comprehensive Django expertise)
- **dotnet-dev**: .NET/C# development agent (comprehensive .NET expertise)  
- **full-stack**: Cross-stack analysis agent (bridges multiple technology stacks)
- **task-planner**: Strategic planning agent (Monday.com task analysis and refinement)
- **doc-writer**: Documentation specialist agent (technical documentation and visualization)
- **saitama**: Meta-agent (agent creation and management)

## Awesome Copilot Categories

- 🤖 **Agents** - Specialized Copilot agents with MCP servers
- 📋 **Instructions** - Coding standards by file pattern
- 🎯 **Skills** - Self-contained folders with bundled assets
- 🔌 **Plugins** - Curated bundles for specific workflows
- 🪝 **Hooks** - Automated actions during agent sessions
- ⚡ **Agentic Workflows** - AI-powered GitHub Actions

## Decision Matrix

| Need | Use | Location |
|------|-----|----------|
| Always-on project rules | Workspace Instructions | `.github/` |
| File-specific guidance | Instructions | `.github/instructions/` |
| Multi-step workflows | Skills | `.github/skills/` |
| Context isolation | Custom Agents | `.github/agents/` |
| Single focused task | Prompts | `.github/prompts/` |
| External integrations | MCP | Various |

- **Workflow Skills** - Multi-step processes with domain knowledge
- **Code Generators** - Specialized code creation
- **Reviewers** - Code analysis and feedback
- **Debuggers** - Problem diagnosis and fixing
