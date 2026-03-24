# Troubleshooting GitHub Copilot Agents

## Critical Session Issues (March 2026 Fixes)

### Bizarre Output / Malformed Responses

**Symptoms:** Garbled text, incomplete responses, strange formatting
**Root Causes:**

- Large context windows causing token limits
- Complex nested tool calls without proper error handling  
- MCP tool failures cascading into response corruption
- Memory file conflicts during parallel operations

**Fixes Applied:**

- ✅ MCP-first patterns with proper error handling
- ✅ STOP conditions to prevent cascade failures
- ✅ Explicit user questions instead of complex assumptions
- ✅ Reduced context complexity in skill operations

### MCP Tool Usage Problems

**Symptom:** Generic tool references instead of MCP tools
**Fix:** Updated all skills to use explicit MCP tool names:

- `mcp_io_github_git_get_file_contents` (not `github_get_file`)
- `mcp_com_monday_mo_get_board_info` (not generic `monday.com`)

### Assumption-Making Behavior

**Symptom:** Continuing with guesses when information unavailable
**Fix:** Added `SkillExecutionStop` pattern with user action required
**Implementation:** All skills now STOP and ask user when in doubt

### Repository Investigation Failures

**Symptom:** Imaginary file paths and invalid architecture assumptions  
**Fix:** Enforced real GitHub API verification for all file paths
**Pattern:** Use MCP tools to verify before processing

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

### MCP Connectivity Issues

1. Verify MCP server status in VS Code settings
2. Check authentication tokens for external services
3. Test MCP tools individually before skill usage
4. Implement graceful fallbacks for MCP failures
