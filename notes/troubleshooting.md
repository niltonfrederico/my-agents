# Troubleshooting GitHub Copilot Agents

## Common Issues

### YAML Frontmatter Problems

- **Syntax Errors**: Missing `---` delimiters, incorrect indentation
- **Invalid Keys**: Using unsupported frontmatter properties
- **Quote Issues**: Inconsistent string quoting in arrays/objects

### Agent Not Being Invoked

- Check `applyTo` patterns match current file types
- Verify skill description aligns with user request domain
- Ensure agent name matches exactly (case-sensitive)
- Check for conflicting agent definitions

### Tool Restrictions Not Working

- Tool restrictions in frontmatter may be ignored in some contexts
- Document intended restrictions in description instead
- Use clear language about tool usage expectations

## Debugging Strategies

### File Recognition Issues

1. Check if files exist at expected paths
2. Verify YAML syntax with validator
3. Test applyTo patterns with simple globs first
4. Check VS Code's file associations

### Agent Selection Problems  

1. Make description very specific to domain
2. Use clear keywords that match user intent
3. Test with explicit agent name requests
4. Check for name conflicts with built-in agents

### Performance Issues

- Large skill files may slow invocation
- Complex applyTo patterns can cause delays  
- Consider splitting large skills into focused ones
