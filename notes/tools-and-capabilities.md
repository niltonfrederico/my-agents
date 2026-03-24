# Tools & Capabilities Reference

## Available Tool Categories

### File System Operations

- `file_operations` - Read, write, edit files
- `directory_operations` - Create, list, manage directories
- `search_tools` - Grep, semantic search, file finding

### Code Analysis & Generation  

- `language_servers` - Type checking, IntelliSense
- `code_generators` - Template-based code creation
- `syntax_validators` - Linting, formatting checks

### Development Workflow

- `terminal` - Shell command execution
- `git_operations` - Version control interactions  
- `build_tools` - Compilation, testing, packaging
- `debugging_tools` - Error diagnosis and fixing

### Diagram Creation & Visualization

- `mermaid-diagram-validator` - Validate Mermaid syntax and structure
- `mermaid-diagram-preview` - Render and preview Mermaid diagrams  
- `get-syntax-docs-mermaid` - Official Mermaid syntax documentation
- `activate_mermaid_diagram_tools` - Enable Mermaid tool access

### External Integrations

- `web_requests` - API calls, documentation fetching
- `github_integration` - Repository management
- `package_managers` - Dependency installation

## Tool Usage Patterns

### Safe Parallel Operations

- Multiple file reads
- Search operations  
- Web requests for documentation
- Status checks

### Sequential Only

- Terminal commands (avoid parallel execution)
- File modifications (prevent conflicts)
- Build/test operations

### Mermaid Workflow Pattern

1. **Get Documentation**: Use `get-syntax-docs-mermaid` for official syntax
2. **Create Diagram**: Write Mermaid code following syntax rules  
3. **Validate**: Use `mermaid-diagram-validator` to check for syntax errors
4. **Preview**: Use `mermaid-diagram-preview` to render and verify output

## Tool Restriction Strategies

### In Frontmatter (Limited Enforcement)

```yaml
tools:
  - file_operations
  - search_tools
```

### In Description (More Reliable)  

```yaml
description: "READ-ONLY codebase analysis. Uses search and file reading only."
```

### Clear Behavioral Guidelines

- Specify "no file modifications" explicitly
- State "terminal command restrictions"  
- Document expected tool usage patterns
