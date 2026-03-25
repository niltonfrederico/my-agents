# GitHub Copilot Instructions

File-pattern-based coding guidelines and best practices that automatically apply based on file types and project patterns.

## Overview

Instructions provide coding standards, guidelines, and best practices that GitHub Copilot automatically applies when working with specific file types. These complement agents and skills by providing consistent baseline guidance across all development activities.

## 📋 Instruction Categories

### 🛡️ Safety & Governance

**Core Safety Patterns:**

- **[agent-safety.instructions.md](agent-safety.instructions.md)** — Universal safety guidelines for AI agent systems
  - Tool access controls and governance
  - Content safety and audit requirements  
  - Multi-agent safety patterns
  - Policy enforcement and compliance

### 🤖 Agent & Skill Development

**Customization Guidelines:**

- **[agents.instructions.md](agents.instructions.md)** — Custom agent file creation guidelines
  - YAML frontmatter standards
  - Awesome-copilot compatibility
  - Handoff workflow configuration
  - Agent naming and organization

- **[agent-skills.instructions.md](agent-skills.instructions.md)** — Agent skill creation guidelines  
  - Skill bundling and resource patterns
  - Progressive loading and portability
  - MCP integration requirements
  - Cross-agent compatibility

### 🔧 Technology Stack Instructions

**Development Guidelines (Extracted from Agent Patterns):**

- **[python-django-development.instructions.md](python-django-development.instructions.md)** — Python/Django development guidelines
  - StandardModelMixin patterns and juntossomosmais expertise
  - Django-STOMP vs django-outbox messaging patterns
  - DRF authentication and API best practices
  - Health check systems and database routing

- **[dotnet-csharp-development.instructions.md](dotnet-csharp-development.instructions.md)** — .NET/C# development guidelines
  - StandardEntity patterns and CliFx command architecture
  - CAP transactional messaging and Entity Framework optimization
  - Hangfire background processing and FluentValidation
  - ASP.NET Core security and minimal API patterns

- **[full-stack-development.instructions.md](full-stack-development.instructions.md)** — Cross-platform development guidelines
  - Migration planning and integration strategies
  - Unified messaging and dual-database patterns
  - Technology decision frameworks
  - Cross-stack pattern translation

- **[task-planning-management.instructions.md](task-planning-management.instructions.md)** — Project management guidelines
  - Monday.com integration and Brazilian Agile methodology
  - Planning Poker estimation and refinement processes
  - Repository investigation and quality gates
  - Zero-tolerance assumption prevention

- **[documentation-technical-writing.instructions.md](documentation-technical-writing.instructions.md)** — Documentation guidelines
  - Professional markdown and Mermaid visualization
  - API documentation and architectural decision records
  - HAR file analysis and performance documentation
  - Interactive diagrams and technical communication

## 📁 Instruction File Format

All instruction files follow awesome-copilot standards:

```yaml
---
description: 'Brief description of instruction purpose and scope'
applyTo:
  - "**/*.py"          # File patterns where instructions apply
  - "**/specific/**/*"  # Directory patterns
---

# Instruction Title

## Guidelines Content
Detailed coding guidelines, patterns, and best practices.
```

### ApplyTo Patterns

Instructions automatically activate based on file patterns:

- **Language-Specific**: `**/*.py`, `**/*.cs`, `**/*.ts`
- **Framework-Specific**: `**/Django/**`, `**/Controllers/**`
- **Configuration Files**: `**/appsettings*.json`, `**/requirements*.txt`
- **Documentation**: `**/*.md`, `**/docs/**`
- **Project Types**: `**/monday*.md`, `**/planning*.md`

## 🔄 Integration with Agents & Skills

### Layered Guidance System

Instructions provide the foundation layer for consistent development practices:

1. **Instructions** → Base coding standards and guidelines (automatic)
2. **Skills** → Specialized domain expertise and workflows (invoked)
3. **Agents** → Comprehensive orchestration and decision-making (interactive)

### Complementary Patterns

- **Instructions**: "How to write good Python/Django code"
- **Skills**: "How to analyze Django performance bottlenecks"  
- **Agents**: "Plan, implement, and document a Django feature"

## 🎯 Usage Patterns

### Automatic Application

Instructions apply automatically when working with matching files:

```python
# When editing a .py file, python-django-development.instructions.md applies
# Provides guidance on StandardModelMixin patterns, STOMP messaging, etc.

def create_user_model(BaseModel):
    # Instructions automatically suggest juntossomosmais patterns
    pass
```

### File-Pattern-Based Activation

Different instructions activate based on file context:

- **Django Models** (`**/models.py`) → Django development instructions
- **.NET Controllers** (`**/Controllers/*.cs`) → .NET development instructions  
- **Documentation** (`**/*.md`) → Documentation writing instructions
- **Monday.com Tasks** (`**/monday*.md`) → Task planning instructions

## 🔗 Awesome Copilot Integration

All instructions follow [awesome-copilot](https://awesome-copilot.github.com/instructions/) standards:

### Official Categories

- 🤖 **Agents** - Specialized Copilot agents with MCP servers
- 📋 **Instructions** - Coding standards by file pattern (this directory)
- 🎯 **Skills** - Self-contained folders with bundled assets  
- 🔌 **Plugins** - Curated bundles for specific workflows
- 🪝 **Hooks** - Automated actions during agent sessions
- ⚡ **Agentic Workflows** - AI-powered GitHub Actions

### Standards Compliance

- **YAML Frontmatter**: Consistent frontmatter across all instruction files
- **File Patterns**: Proper applyTo pattern usage for automatic activation
- **Description Quality**: Clear, actionable descriptions
- **Content Organization**: Structured, scannable content with clear sections

## 💡 Creating New Instructions

### Instruction Development Guidelines

1. **Specific Scope**: Target specific file patterns or technologies
2. **Actionable Content**: Provide concrete, actionable guidelines
3. **Pattern Examples**: Include code examples and pattern demonstrations  
4. **Integration Points**: Reference relevant skills and agents
5. **Company Standards**: Include juntossomosmais-specific patterns

### Instruction Template

```yaml
---
description: 'Clear description of what guidance this provides'
applyTo:
  - "**/*.ext"      # Specific file patterns
  - "**/folder/**"  # Directory patterns
---

# Instruction Title

## Core Guidelines
Primary coding standards and patterns.

## Technology Integration  
Framework-specific guidance and patterns.

## Skills Integration
Reference to relevant skills for deeper expertise.

## Quality Standards
Code quality requirements and validation.
```

## 🔍 Migration from Agent applyTo Patterns

These instruction files were extracted from agent `applyTo` patterns during the awesome-copilot migration:

### Pattern Extraction Process

1. **Agent Analysis**: Extracted `applyTo` patterns from comprehensive agents
2. **Pattern Consolidation**: Combined overlapping patterns and removed duplicates  
3. **Guideline Creation**: Transformed agent capabilities into file-pattern guidelines
4. **Cross-Reference**: Ensured instructions align with corresponding skills and agents

### Preserved Patterns

- **Django Development**: Complete Python/Django file pattern coverage
- **.NET Development**: Full C#/.NET project pattern coverage
- **Full-Stack**: Cross-platform file pattern integration
- **Documentation**: Comprehensive documentation file patterns  
- **Project Management**: Monday.com and planning file patterns

## 🎯 Success Metrics

### Instruction Effectiveness

- **Automatic Activation**: Instructions activate correctly for target file patterns
- **Guidance Quality**: Developers follow instruction guidelines consistently
- **Pattern Adoption**: juntossomosmais patterns implemented correctly
- **Integration Success**: Smooth coordination with agents and skills

### Coverage Metrics

- **File Pattern Coverage**: All relevant file types have appropriate instructions
- **Technology Stack Coverage**: Complete guidance for Python, .NET, documentation, planning
- **Quality Standards**: Consistent code quality across all file types
- **Compliance**: 100% awesome-copilot standard compliance

---

## 📚 Related Documentation

- **[Agents](../agents/README.md)** - Custom agents that leverage instruction guidelines
- **[Skills](../skills/README.md)** - Specialized skills for domain expertise
- **[Root README](../README.md)** - Workspace overview and integration patterns
- **[Awesome Copilot Instructions](https://awesome-copilot.github.com/instructions/)** - Official instruction standards and patterns
