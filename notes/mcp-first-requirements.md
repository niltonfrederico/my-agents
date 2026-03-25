# MCP-First Requirements for All Skills and Agents

## Critical Requirements (March 2026 Session Fix)

### 1. MCP Tool Priority (MANDATORY)

**RULE:** Always use MCP tools when available for external operations

**GitHub Operations:**

- ✅ `mcp_io_github_git_get_file_contents` (not generic `github_get_file`)
- ✅ `mcp_io_github_git_list_branches` (not generic `github_list_branches`)
- ✅ `mcp_io_github_git_list_commits` (not generic GitHub references)

**Monday.com Operations:**

- ✅ `mcp_com_monday_mo_get_board_info` (not generic `monday.com` references)
- ✅ `mcp_com_monday_mo_get_updates` (not generic Monday API calls)
- ✅ `mcp_com_monday_mo_board_insights` (not assumptions about board data)

### 2. STOP Conditions (MANDATORY)

**RULE:** STOP immediately when information cannot be found or accessed

**Implementation Pattern:**

```python
try:
    result = mcp_tool_call(parameters)
    if not result:
        raise SkillExecutionStop(
            reason="DATA_NOT_ACCESSIBLE",
            message="🚫 STOP: [Specific data] não pode ser acessado.\n\n❓ [Clear question for user]",
            user_action_required=True
        )
except Exception as e:
    raise SkillExecutionStop(
        reason="MCP_CALL_FAILED",
        message=f"🚫 STOP: Falha ao acessar [resource].\n\nErro: {str(e)}\n\n❓ [User action needed]",
        user_action_required=True
    )
```

**Common STOP Scenarios:**

- Repository not accessible via GitHub MCP
- Monday.com board/item not found  
- MCP rate limits exceeded
- Authentication/permissions failures
- Required analysis context missing

### 3. Ask-User Pattern (MANDATORY)

**RULE:** Ask user when in doubt, never make assumptions

**Implementation:**

```python
# Use vscode_askQuestions tool
questions = [{
    "header": "clarification_needed",
    "question": "🤔 [Specific uncertainty]. Qual sua preferência?",
    "options": [
        {"label": "[Option 1]", "value": "option1"},
        {"label": "[Option 2]", "value": "option2"}
    ],
    "allowFreeformInput": True
}]

user_response = vscode_askQuestions(questions)
if not user_response["clarification_needed"]:
    # STOP if user doesn't provide clarity
    raise SkillExecutionStop(...)
```

**When to Ask:**

- Repository name unclear from task context
- Multiple technical approaches possible
- Missing implementation details
- Conflicting information in Monday.com task
- Architecture patterns not obvious

### 4. Real Repository Investigation (MANDATORY)

**RULE:** Use actual GitHub API calls to verify repository structure

**Anti-Pattern (FORBIDDEN):**

```python
# DON'T assume file paths exist
assumed_paths = ["src/", "models.py", "controllers/"]
```

**Correct Pattern (REQUIRED):**

```python  
# DO verify paths via MCP
try:
    actual_content = mcp_io_github_git_get_file_contents(
        owner=owner, repo=repo, path=path
    )
    if actual_content:
        # Path exists, use real data
        process_real_content(actual_content)
    else:
        # Path doesn't exist, handle appropriately
        handle_missing_path(path)
except Exception:
    # MCP failed, STOP and ask user
    raise SkillExecutionStop(...)
```

## Implementation Checklist for Skills

### Before Skill Execution

- [ ] Verify MCP tools are available and accessible
- [ ] Check prerequisites from previous analysis steps
- [ ] Validate user inputs thoroughly

### During Skill Execution  

- [ ] Use MCP tools for all external operations
- [ ] STOP immediately if data is inaccessible
- [ ] Ask user when faced with ambiguity
- [ ] Verify file paths via actual GitHub API calls
- [ ] Never assume repository structure

### After Skill Execution

- [ ] Validate results before returning
- [ ] Update session memory with findings
- [ ] Document any STOP conditions encountered
- [ ] Provide clear next steps if execution blocked

## Agent Compliance Requirements

**All agents MUST:**

1. Use only MCP-enabled skills for external operations
2. Enforce STOP conditions consistently  
3. Prioritize ask-user pattern over assumptions
4. Validate repository investigation results
5. Update troubleshooting notes when issues occur

**Agent Skill Invocation Pattern:**

```python
try:
    skill_result = invoke_skill('skill-name', parameters)
    if skill_result.status == "STOPPED":
        # Skill hit STOP condition, respect it
        return skill_result.message  # Pass stop message to user
    # Continue with valid results only
except SkillExecutionStop as stop:
    # Skill properly stopped, inform user
    return stop.message
```

## Success Metrics

- ✅ Zero assumptions about repository structure
- ✅ All external calls use MCP tools
- ✅ Clear STOP messages when data unavailable  
- ✅ User questions asked instead of guessing
- ✅ Real GitHub API verification for all file paths
- ✅ Stable, well-formed output in all responses

## Emergency Fallback Pattern

If MCP tools are unavailable:

```python
if not mcp_tools_available():
    raise SkillExecutionStop(
        reason="MCP_UNAVAILABLE",
        message="🚫 STOP: MCP tools não disponíveis.\n\n❓ Configurar MCP ou aguardar conectividade?",
        user_action_required=True
    )
```
