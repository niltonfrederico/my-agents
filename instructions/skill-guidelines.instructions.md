---
description: 'Skill creation and management guidelines for reusable domain expertise'
applyTo: "**/skills/**/*.md"
---

# Skill Guidelines

Complete skill creation patterns and best practices for reusable domain expertise packages.

## Skill Structure

### Required Files

```
skill-name/
├── SKILL.md          # Main skill definition (required)
├── templates/        # Optional templates directory
│   ├── template1.md
│   └── template2.py
└── assets/          # Optional assets directory
    ├── example.json
    └── reference.yml
```

### SKILL.md Format

```markdown
---
description: "**SKILL TYPE** — Brief purpose. USE FOR: use case 1; use case 2. PROVIDES: capability 1; capability 2. FOCUS: specialization details."
---

# Skill Name

Brief skill description and purpose.

## Capabilities

### Primary Functions
- Function 1: Description and use case
- Function 2: Description and use case
- Function 3: Description and use case

### Domain Expertise
- Knowledge area 1
- Knowledge area 2  
- Knowledge area 3

## Usage Patterns

### Integration with Agents
```yaml
# In agent descriptions
LEVERAGES: skill-name for specific purpose; other-skill for other purpose
```

### Natural Language Invocation  

Agents use skills through descriptive language:

- "Apply the django-explorer skill to understand project structure"
- "Use mermaid-expert skill to create system diagrams"
- "Leverage brazilian-agile-framework for Planning Poker estimation"

## Input Requirements

### Required Parameters

- parameter1: Description and format
- parameter2: Description and format

### Optional Parameters  

- optional1: Description and default behavior
- optional2: Description and default behavior

## Output Format

### Successful Execution

```json
{
  "status": "success",
  "result": "detailed results",
  "recommendations": ["rec1", "rec2"],
  "next_steps": ["step1", "step2"]
}
```

### Error Conditions

```json
{
  "status": "error",
  "error": "SkillExecutionStop",
  "message": "Specific error description",
  "user_action_required": true,
  "suggested_action": "What user should do"
}
```

## MCP Integration Requirements (MANDATORY)

### Tool Usage

- Use explicit MCP tool names: `mcp_io_github_git_*`, `mcp_com_monday_mo_*`
- NEVER use generic references like `github.com` or `monday.com`
- Include full MCP tool names in input/output documentation

### Error Handling

- Use `SkillExecutionStop` when external data is unavailable
- Set `user_action_required: true` for user intervention needs
- Provide specific error messages and suggested actions

### Anti-Hallucination Patterns

- Verify all external API calls through actual MCP tools
- Never assume or guess repository structures or configurations
- Use `vscode_askQuestions` when information is unclear

## Examples

### Technology Analysis Skill

Tools like `django-explorer`, `dotnet-analyzer`:

- Rapid project structure understanding
- Technology stack identification
- Architectural pattern recognition  
- Performance bottleneck identification

### Documentation Generation Skill

Tools like `mermaid-expert`, `django-documenter`:

- Technical documentation creation
- Diagram generation and validation
- API documentation with examples
- Architecture decision records

### Process Validation Skill

Tools like `brazilian-agile-framework`, `r2d2-compliance-validator`:

- Methodology compliance checking
- Estimation and planning support
- Quality gate validation
- Standards enforcement

## Advanced Features

### Template Integration

Skills can include templates for consistent output:

```markdown
## Templates

### Analysis Report Template
```json
{
  "analysis_type": "django_project",
  "findings": [],
  "recommendations": [],
  "risk_assessment": "low|medium|high",
  "next_actions": []
}
```

### Asset Bundling  

Include reference materials and examples:

```
assets/
├── example-configs/
│   ├── django-settings.py
│   └── appsettings.json
├── reference-docs/
│   ├── api-patterns.md
│   └── security-guidelines.md
└── validation-schemas/
    ├── task-schema.json
    └── response-schema.yml
```

## Skill Categories

### Technology Skills

Focus on specific technology stacks:

- `django-*` skills: Python/Django expertise
- `dotnet-*` skills: .NET/C# expertise
- `mermaid-*` skills: Diagram creation expertise

### Process Skills

Focus on methodologies and workflows:

- `brazilian-agile-framework`: Agile methodology expertise
- `pre-commit-validator`: Code quality validation
- `monday-*` skills: Project management expertise

### Analysis Skills

Focus on investigation and discovery:

- `github-repository-investigator`: Repository analysis
- `har-analysis`: Network performance analysis
- `library-checker`: Dependency validation

### Validation Skills

Focus on compliance and standards:

- `r2d2-compliance-validator`: Company standards
- Security and quality validation skills
- Architectural compliance skills

## Integration Patterns

### Agent Skill Usage

Agents reference skills in their descriptions:

```yaml
description: "Agent purpose. LEVERAGES: skill1 for purpose; skill2 for purpose."
```

### Multi-Skill Coordination

Skills can work together:

```markdown
Skill execution often follows patterns:
1. Explorer skill: Rapid discovery
2. Analyzer skill: Deep investigation  
3. Documenter skill: Comprehensive documentation
4. Validator skill: Compliance checking
```

### Error Recovery

Skills implement graceful degradation:

```markdown
When external data unavailable:
1. Use SkillExecutionStop with clear message
2. Provide user guidance for resolution
3. Suggest alternative approaches when possible
4. Never guess or assume missing information
```

## Maintenance

### Version Control

- Track skill changes through semantic versioning
- Document capability updates in SKILL.md
- Maintain backward compatibility for agent integration
- Update MCP tool references as APIs evolve

### Quality Assurance

- Test skills with multiple agents
- Validate MCP tool integration
- Ensure error handling works correctly
- Verify template and asset accessibility

## Example Skills

### Simple Analysis Skill

```markdown
---
description: "**PROJECT EXPLORER** — Rapid project structure analysis. USE FOR: initial discovery; framework detection. PROVIDES: structure overview; technology identification."
---

# Project Explorer Skill

Rapidly analyzes project structure to identify frameworks, patterns, and organization.

## Capabilities
- Framework detection (Django, .NET, React, etc.)
- Directory structure analysis
- Dependency identification
- Configuration file discovery

## Usage
Agents invoke: "Use project-explorer to understand the codebase structure"

## MCP Integration
Uses `mcp_io_github_git_list_repository_contents` for file discovery
Uses `mcp_io_github_git_get_file_contents` for configuration analysis
```

### Complex Integration Skill  

```markdown
---
description: "**MONDAY TASK ANALYZER** — Complete Monday.com task analysis. USE FOR: task validation; repository confirmation. PROVIDES: task breakdown; effort estimation. FOCUS: Brazilian Agile methodology integration."
---

# Monday Task Analyzer Skill

Comprehensive Monday.com task analysis with Brazilian Agile methodology integration.

## Capabilities
- Monday.com API integration via `mcp_com_monday_mo_*` tools
- GitHub repository verification via `mcp_io_github_git_*` tools
- Brazilian Agile Planning Poker estimation
- Task validation and breakdown

## Error Handling
- SkillExecutionStop when Monday.com task inaccessible
- User confirmation for repository assumptions
- Graceful degradation for API failures

## Integration
Works with:
- `brazilian-agile-framework` for estimation
- `github-repository-investigator` for validation
- `monday-refinement-generator` for implementation planning
```

This guideline ensures skills are created with proper MCP integration, error handling, and agent compatibility following March 2026 anti-hallucination standards.
