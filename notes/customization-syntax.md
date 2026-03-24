# Customization Syntax Reference

## YAML Frontmatter Properties

### Core Properties

- `title`: Display name for agent/skill
- `description`: Purpose and domain explanation  
- `applyTo`: File pattern array for automatic invocation
- `tools`: Available tool restrictions (may not be enforced)
- `skill`: Boolean flag for skill classification
- `name`: Internal identifier (skills only)
- `invokes`: Tools/capabilities the skill uses

### File Pattern Syntax

- Glob patterns supported
- Use forward slashes `/` for all platforms
- `**` for recursive directory matching
- `*` for wildcard matching within directory
- `[]` for character classes
- `{}` for brace expansion alternatives

### Examples

```yaml
# Simple extension matching
applyTo: ["*.py", "*.pyi"]

# Directory-specific
applyTo: ["src/**/*.ts", "tests/**/*.test.js"]  

# Complex patterns
applyTo: ["**/{test,spec}*.{js,ts}", "*.config.{json,yaml}"]
```

## Markdown Structure Best Practices

### Headers for Navigation

- `#` Main topic
- `##` Categories/sections  
- `###` Specific items/examples
- `####` Sub-details

### Code Block Languages

- `yaml` for frontmatter examples
- Language-specific for code samples
- `bash`/`shell` for terminal commands
- `json` for configuration

### Cross-References  

- Link to related skills: `[skill-name](../path/to/skill)`
- External docs: `[Display](https://url)`
- Internal sections: `[text](#anchor)`
