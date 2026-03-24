# Universal Integration Patterns for Skills and Agents

## Overview (March 2026 Anti-Hallucination Edition)

This guide establishes universal patterns for seamless integration between skills and agents, ensuring they work together effectively while maintaining anti-hallucination failsafes.

## Core Integration Principles

### 1. STOP-Respectful Skill Composition

**Pattern**: When one skill hits a STOP condition, dependent skills must also halt gracefully.

```python
# ✅ Correct: Respecting STOP conditions in skill chains
def compose_skills_safely():
    try:
        analysis = apply_skill('django-analyzer', params)
        if analysis.status == "STOPPED":
            return f"🚫 COMPOSITION HALTED: {analysis.message}"
        
        # Only proceed if first skill succeeded
        documentation = apply_skill('django-documenter', analysis.data)
        if documentation.status == "STOPPED":
            return f"🚫 DOCUMENTATION HALTED: {documentation.message}"
            
    except SkillExecutionStop as stop:
        return f"🚫 SKILL CHAIN STOPPED: {stop.message}"

# ❌ Wrong: Ignoring STOP conditions
def dangerous_composition():
    analysis = apply_skill('django-analyzer', params)  # Might STOP
    documentation = apply_skill('django-documenter', incomplete_data)  # Uses invalid data
```

### 2. MCP-First Coordination

**Pattern**: All skills in a workflow must use consistent MCP tools for external operations.

```python
# ✅ Coordinated MCP usage across skill chain
workflow_mcp_tools = {
    'github_operations': ['mcp_io_github_git_get_file_contents', 'mcp_io_github_git_list_branches'],
    'monday_operations': ['mcp_com_monday_mo_get_board_info', 'mcp_com_monday_mo_get_updates'],
    'user_interaction': ['vscode_askQuestions']
}

# All skills in Monday.com workflow use consistent MCP tools
monday_workflow = [
    'monday-task-analyzer',      # Uses mcp_com_monday_mo_* 
    'github-repository-investigator',  # Uses mcp_io_github_git_*
    'monday-refinement-generator',     # Uses both MCP sets
    'r2d2-compliance-validator'        # Uses mcp_io_github_git_*
]
```

### 3. Context Passing Patterns

**Pattern**: Skills pass rich context objects instead of raw data to enable proper validation.

```typescript
interface SkillContext {
    source_skill: string;
    validation_status: 'validated' | 'stopped' | 'incomplete';
    mcp_verification: boolean;
    user_confirmation: boolean;
    data: any;
    stop_reason?: string;
    user_action_required?: boolean;
}

// ✅ Rich context passing
function skill_chain_with_context() {
    const analysis_context: SkillContext = {
        source_skill: 'django-analyzer',
        validation_status: 'validated',
        mcp_verification: true,
        user_confirmation: true,
        data: django_analysis_results
    };
    
    // Next skill can verify context validity
    const doc_result = apply_skill('django-documenter', analysis_context);
}
```

## Agent Coordination Patterns

### 1. Multi-Agent Workflows

**Pattern**: Agent workflows respect each other's STOP conditions and share context.

```python
# ✅ Cross-agent coordination with STOP respect
def full_development_workflow():
    # Phase 1: Planning (task-planner agent)
    planning = run_subagent('task-planner', monday_url_context)
    if 'STOP' in planning or 'BLOCKED' in planning:
        return f"🚫 PLANNING PHASE: {planning}"
    
    # Phase 2: Development (django-dev or dotnet-dev based on planning)
    if planning.stack == 'django':
        development = run_subagent('django-dev', planning.technical_context)
    elif planning.stack == 'dotnet':
        development = run_subagent('dotnet-dev', planning.technical_context)
    else:
        # Cross-stack development
        development = run_subagent('full-stack', planning.technical_context)
    
    if 'STOP' in development:
        return f"🚫 DEVELOPMENT PHASE: {development}"
    
    # Phase 3: Documentation (doc-writer agent)
    documentation = run_subagent('doc-writer', development.output_context)
    
    return {
        'planning': planning,
        'development': development, 
        'documentation': documentation,
        'workflow_complete': True
    }
```

### 2. Agent Specialization Boundaries

**Clear Responsibilities**: Each agent has distinct responsibilities and delegates appropriately.

```python
# ✅ Clear agent boundaries with proper delegation
AGENT_RESPONSIBILITIES = {
    'django-dev': {
        'primary': ['Django app development', 'Python scripting', 'DRF APIs'],
        'delegates_to': {
            'repository_investigation': 'github-repository-investigator skill',
            'documentation': 'django-documenter skill',
            'validation': 'pre-commit-validator skill',
            'planning': 'task-planner agent'
        }
    },
    'task-planner': {
        'primary': ['Monday.com analysis', 'Planning Poker estimation', 'Refinement docs'],
        'delegates_to': {
            'technical_development': 'django-dev OR dotnet-dev agents',
            'cross_stack_analysis': 'full-stack agent',
            'diagramming': 'doc-writer agent'
        }
    },
    'saitama': {
        'primary': ['Agent/skill creation', 'Anti-hallucination pattern enforcement'],
        'delegates_to': {
            'technical_validation': 'django-dev OR dotnet-dev agents',
            'documentation_creation': 'doc-writer agent'
        }
    }
}
```

## Skill Integration Strategies

### 1. Tech Stack Skill Clusters

**Django Cluster**: Skills that work together for Django development.

```python
django_skill_cluster = {
    'exploration': 'django-explorer',           # Fast Q&A, structure understanding
    'deep_analysis': 'django-analyzer',         # Complex pattern investigation
    'documentation': 'django-documenter',       # Tech docs with Mermaid diagrams
    'validation': 'pre-commit-validator',       # Code quality validation
    'security': 'library-checker',              # Python dependency validation
    'repository': 'github-repository-investigator'  # Real structure verification
}

# Usage pattern: Sequential with STOP respect
def django_development_pipeline():
    structure = apply_skill('django-explorer', repo_context)
    if structure.needs_deeper_analysis:
        analysis = apply_skill('django-analyzer', structure.complex_areas)
        if analysis.status != "STOPPED":
            docs = apply_skill('django-documenter', analysis.findings)
```

**Dotnet Cluster**: Skills that work together for .NET development.

```python
dotnet_skill_cluster = {
    'exploration': 'dotnet-explorer',           # Fast Q&A, CliFx/EF structure
    'deep_analysis': 'dotnet-analyzer',         # CAP messaging, Hangfire analysis
    'documentation': 'dotnet-documenter',       # .NET docs with architecture diagrams
    'validation': 'pre-commit-validator',       # Code quality validation
    'security': 'dotnet-library-checker',      # NuGet dependency validation
    'repository': 'github-repository-investigator'  # Real structure verification
}
```

### 2. Cross-Cutting Skill Integration

**Validation Pipeline**: Skills that provide validation across all workflows.

```python
validation_pipeline = {
    'code_quality': 'pre-commit-validator',     # Multi-language code validation
    'dependency_security': ['library-checker', 'dotnet-library-checker'],
    'compliance': 'r2d2-compliance-validator',  # juntossomosmais standards
    'repository_verification': 'github-repository-investigator'
}

# Integration pattern: Parallel validation
def comprehensive_validation():
    validation_tasks = [
        apply_skill('pre-commit-validator', code_files),
        apply_skill('library-checker', python_deps) if python_project else None,
        apply_skill('dotnet-library-checker', nuget_deps) if dotnet_project else None,
        apply_skill('r2d2-compliance-validator', refinement_docs)
    ]
    
    # Wait for all validations, respect any STOP conditions
    results = []
    for task in filter(None, validation_tasks):
        if task.status == "STOPPED":
            return f"🚫 VALIDATION STOPPED: {task.message}"
        results.append(task)
    
    return aggregate_validation_results(results)
```

**Documentation Pipeline**: Skills that create comprehensive documentation.

```python
documentation_pipeline = {
    'technical_docs': ['django-documenter', 'dotnet-documenter'],
    'visual_diagrams': ['mermaid-expert', 'mermaid-flowchart', 'mermaid-sequence', 'mermaid-mindmap'],
    'performance_analysis': 'har-analysis',
    'architecture_verification': 'github-repository-investigator'
}
```

## Error Handling and Recovery Patterns

### 1. Graceful Degradation

**Pattern**: When skills STOP, provide meaningful alternatives instead of total failure.

```python
def robust_analysis_with_degradation():
    try:
        # Attempt full analysis
        analysis = apply_skill('django-analyzer', full_context)
        return analysis
    except SkillExecutionStop as stop:
        if stop.reason == "REPOSITORY_CONTEXT_UNCLEAR":
            # Degrade to basic exploration if repository unclear
            user_choice = ask_user_for_degradation_preference()
            if user_choice == "basic_exploration":
                return apply_skill('django-explorer', limited_context)
            else:
                return stop.message
        else:
            # Other STOP conditions should halt completely
            return stop.message
```

### 2. Context Recovery

**Pattern**: When context is lost, intelligently rebuild or request clarification.

```python
def context_recovery_pattern():
    if context_incomplete():
        # Try to recover context from related skills
        recovery_attempts = [
            ('github-repository-investigator', repo_params),
            ('django-explorer', basic_params),
        ]
        
        for skill_name, params in recovery_attempts:
            try:
                recovery_context = apply_skill(skill_name, params)
                if recovery_context.status != "STOPPED":
                    return recovery_context.data
            except SkillExecutionStop:
                continue
        
        # If recovery fails, ask user for clarification
        return ask_user_for_context_clarification()
```

## Performance and Efficiency Patterns

### 1. Parallel Skill Execution

**Pattern**: Execute independent skills in parallel while respecting dependencies.

```python
import asyncio

async def parallel_skill_execution():
    # Independent skills can run in parallel
    parallel_tasks = [
        apply_skill_async('mermaid-flowchart', architecture_data),
        apply_skill_async('mermaid-sequence', api_flow_data),
        apply_skill_async('har-analysis', performance_data)
    ]
    
    # Wait for all parallel tasks
    results = await asyncio.gather(*parallel_tasks, return_exceptions=True)
    
    # Check for any STOP conditions
    for result in results:
        if isinstance(result, SkillExecutionStop):
            return f"🚫 PARALLEL EXECUTION STOPPED: {result.message}"
    
    return aggregate_results(results)
```

### 2. Caching and Memoization

**Pattern**: Cache MCP API results to avoid redundant external calls.

```python
class MCPCache:
    def __init__(self):
        self.github_cache = {}
        self.monday_cache = {}
    
    def cached_mcp_call(self, tool_name, params):
        cache_key = f"{tool_name}:{hash(str(params))}"
        
        if cache_key in self.github_cache:
            return self.github_cache[cache_key]
        
        # Make actual MCP call
        result = execute_mcp_tool(tool_name, params)
        
        # Cache successful results only
        if result and not hasattr(result, 'error'):
            self.github_cache[cache_key] = result
        
        return result

# Use across skills in the same session
mcp_cache = MCPCache()
```

## Testing and Validation Integration

### 1. Skill Integration Testing

**Pattern**: Test skill combinations to ensure STOP conditions propagate correctly.

```python
def test_skill_integration():
    # Test STOP condition propagation
    test_cases = [
        {
            'name': 'Repository Investigation -> Django Analysis',
            'skills': ['github-repository-investigator', 'django-analyzer'],
            'expected_stop_propagation': True
        },
        {
            'name': 'Monday Analysis -> Refinement Generation',
            'skills': ['monday-task-analyzer', 'monday-refinement-generator'],
            'expected_stop_propagation': True
        }
    ]
    
    for case in test_cases:
        result = test_skill_chain_stops(case['skills'])
        assert result.stop_propagation == case['expected_stop_propagation']
```

### 2. Agent Coordination Testing

**Pattern**: Ensure agents delegate appropriately and respect skill boundaries.

```python
def test_agent_coordination():
    # Test proper delegation
    planning_result = run_subagent('task-planner', test_monday_url)
    assert 'github-repository-investigator' in planning_result.skills_used
    
    # Test cross-agent workflow
    dev_result = run_subagent('django-dev', planning_result.context)
    assert dev_result.respects_planning_constraints == True
```

## Summary of Integration Best Practices

### Universal Requirements (ALL Skills & Agents)

1. **Respect STOP conditions**: Never override or ignore skill STOP conditions
2. **Use consistent MCP tools**: Coordinate on MCP tool usage across workflows
3. **Pass rich context**: Include validation status, source, and metadata
4. **Ask user when unclear**: Use vscode_askQuestions instead of assumptions
5. **Delegate appropriately**: Use specialized skills/agents for their expertise

### Skill-Specific Integration

- **Technical skills** (django-*, dotnet-*): Always verify repository structure via github-repository-investigator
- **Validation skills**: Coordinate to avoid redundant checks
- **Documentation skills**: Share context for consistent technical accuracy
- **Mermaid skills**: Ask user for diagram type/content when unclear

### Agent-Specific Coordination

- **Development agents**: Use validation skills in parallel with development
- **Planning agents**: Ensure repository verification before technical planning
- **Documentation agents**: Coordinate with technical skills for accuracy
- **Meta-agents**: Enforce anti-hallucination patterns in all creations

This integration framework ensures that skills and agents work together seamlessly while maintaining the anti-hallucination safeguards established in March 2026.
