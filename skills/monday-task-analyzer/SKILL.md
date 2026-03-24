---
skill: true
name: "monday-task-analyzer"
description: "**MONDAY TASK ANALYZER** — Consolidated skill for complete Monday.com task analysis from URL validation to technical architecture discovery. USE FOR: Monday.com workflow initialization; repository confirmation; Brazilian playbook validation; GitHub architecture discovery; single-stack validation. BLOCKS: invalid tasks from proceeding to refinement. JUNTOSSOMOSMAIS FOCUS: Zero-tolerance repository assumptions; real GitHub API investigation; Brazilian methodology compliance; March 2026 error prevention."
applyTo:
  - "monday.com/*"
  - "**/*planning*/**"
  - "**/*tasks*/**"
  - "**/*refinement*/**"
  - "**/*analysis*/**"
invokes:
  - "monday.com"
  - "github-repository-investigator"
  - "brazilian-agile-framework"
  - "memory"
---

# Monday Task Analyzer Skill

## Overview

**COMPREHENSIVE ANALYSIS GATEWAY:** Performs complete Monday.com task analysis from initial URL validation through technical architecture discovery. Serves as single entry point for Monday.com refinement workflow with multiple quality gates.

## Analysis Workflow

### Phase 1: Monday.com URL & Access Validation

```python
def validate_monday_url_and_access(monday_url: str) -> MondayValidationResult:
    """
    Validates Monday.com URL format, accessibility, and extracts task data.
    
    Args:
        monday_url: Monday.com task URL provided by user
        
    Returns:
        MondayValidationResult: Task data and access validation status
    """
    
    # Extract board_id and item_id from URL
    url_components = parse_monday_url(monday_url)
    if not url_components.is_valid:
        return MondayValidationResult(
            status="BLOCKED",
            message="URL do Monday.com inválido. Formato esperado: https://mycompany.monday.com/boards/BOARD_ID/pulses/ITEM_ID",
            blocking_issue="url_format"
        )
    
    # Access Monday.com API to fetch task data
    try:
        task_data = fetch_monday_task_data(
            board_id=url_components.board_id,
            item_id=url_components.item_id
        )
    except MondayAccessError as e:
        return MondayValidationResult(
            status="BLOCKED", 
            message=f"Erro de acesso ao Monday.com: {str(e)}",
            blocking_issue="access_denied"
        )
    
    return MondayValidationResult(
        status="VALIDATED",
        task_data=task_data,
        monday_url=monday_url
    )

def fetch_monday_task_data(board_id: str, item_id: str) -> MondayTaskData:
    """Fetches complete task data from Monday.com API."""
    
    # Use Monday.com MCP integration
    task_response = mcp_com_monday_mo_get_board_items_page(
        board_id=board_id,
        item_ids=[item_id],
        includeItemDescription=True,
        includeColumns=True,
        includeUpdates=True
    )
    
    if not task_response.items:
        raise MondayAccessError(f"Task {item_id} não encontrado no board {board_id}")
    
    task_item = task_response.items[0]
    
    return MondayTaskData(
        id=task_item.id,
        name=task_item.name,
        description=task_item.description,
        tema_epico=extract_column_value(task_item.columns, "tema_epico"),
        contexto=extract_column_value(task_item.columns, "contexto"), 
        valor=extract_column_value(task_item.columns, "valor"),
        criterios_aceite=extract_column_value(task_item.columns, "criterios_aceite"),
        status=extract_column_value(task_item.columns, "status"),
        assignees=task_item.assignees,
        board_id=board_id,
        monday_url=f"https://mycompany.monday.com/boards/{board_id}/pulses/{item_id}"
    )
```

### Phase 2: Repository Confirmation (Zero-Tolerance Policy)

```python
def confirm_repository_explicitly(task_data: MondayTaskData) -> RepositoryConfirmation:
    """
    Enforces explicit repository confirmation to prevent March 2026 error patterns.
    
    CRITICAL: Never assumes repository from task name or context.
    """
    
    # Check if repository can be inferred from task data
    potential_repositories = extract_potential_repositories(task_data)
    
    if len(potential_repositories) == 1 and is_high_confidence_match(potential_repositories[0], task_data):
        # Single high-confidence match - still require explicit confirmation
        repository_question = {
            "header": "repository_confirmation",
            "question": f"Confirme o repositório que será afetado por esta task:",
            "options": [
                {
                    "label": f"✅ {potential_repositories[0]} (detectado automaticamente)",
                    "value": potential_repositories[0],
                    "recommended": True
                },
                {
                    "label": "🔍 Outro repositório (especificar manualmente)",
                    "value": "manual_specify"
                }
            ],
            "allowFreeformInput": True
        }
    else:
        # Multiple possibilities or no clear match - manual specification required
        repository_question = {
            "header": "repository_confirmation", 
            "question": "🚫 REPOSITÓRIO DEVE SER CONFIRMADO EXPLICITAMENTE\\n\\n📚 LIÇÃO APRENDIDA (Mar 2026): Assumir repositório gera análise técnica inválida.\\n\\nQual repositório será afetado?",
            "options": [
                {"label": "juntossomosmais/delfos", "value": "juntossomosmais/delfos"},
                {"label": "juntossomosmais/vitrine", "value": "juntossomosmais/vitrine"},
                {"label": "juntossomosmais/catalog", "value": "juntossomosmais/catalog"},
                {"label": "Outro repositório", "value": "other"}
            ],
            "allowFreeformInput": True
        }
    
    user_response = ask_questions([repository_question])
    repository_name = user_response["repository_confirmation"]
    
    if not repository_name or repository_name == "manual_specify":
        raise RepositoryNotConfirmed(
            "Repositório deve ser confirmado explicitamente antes de prosseguir com análise técnica"
        )
    
    # Validate repository exists via GitHub API
    repository_validation = validate_repository_exists(repository_name)
    if not repository_validation.exists:
        raise RepositoryNotFound(
            f"Repositório {repository_name} não encontrado ou inacessível via GitHub API"
        )
    
    return RepositoryConfirmation(
        repository_name=repository_name,
        confirmation_method="explicit_user_confirmation",
        validation_timestamp=datetime.now(),
        github_validation=repository_validation
    )
```

### Phase 3: Brazilian Playbook Validation

```python
def validate_brazilian_methodology_compliance(task_data: MondayTaskData) -> PlaybookCompliance:
    """
    Validates task against Brazilian Agile methodology requirements.
    
    Uses brazilian-agile-framework skill for standardized validation.
    """
    
    # Delegate to specialized Brazilian Agile Framework skill
    playbook_validation = invoke_skill(
        "brazilian-agile-framework",
        "validate_brazilian_playbook_compliance",
        task_data=task_data
    )
    
    # Check for blocking issues
    blocking_issues = []
    for field_name, validation in playbook_validation.mandatory_results.items():
        if validation.is_blocking and validation.status == "FAIL":
            blocking_issues.append({
                "field": field_name,
                "issue": validation.message,
                "suggestion": validation.suggestion
            })
    
    if blocking_issues:
        return PlaybookCompliance(
            status="BLOCKED",
            blocking_issues=blocking_issues,
            message=generate_playbook_blocking_message(blocking_issues)
        )
    
    return PlaybookCompliance(
        status="COMPLIANT",
        validation_results=playbook_validation,
        enhancement_opportunities=list_enhancement_opportunities(playbook_validation)
    )

def generate_playbook_blocking_message(blocking_issues: list[dict]) -> str:
    """Generates user-friendly blocking message for playbook failures."""
    
    message = "🚫 VALIDAÇÃO BRASILEIRA FALHOU - Correções Obrigatórias\\n\\n"
    message += "❌ Problemas CRÍTICOS encontrados:\\n"
    
    for issue in blocking_issues:
        message += f"• **{issue['field'].upper()}**: {issue['issue']}\\n"
        if issue.get('suggestion'):
            message += f"  💡 {issue['suggestion']}\\n"
    
    message += "\\n⚠️ Corrija os problemas obrigatórios antes de prosseguir com análise técnica."
    
    return message
```

### Phase 4: Technical Architecture Discovery

```python
def discover_repository_architecture(
    repository_name: str, 
    task_context: MondayTaskData
) -> ArchitectureDiscovery: 
    """
    Discovers real application architecture using GitHub API investigation.
    
    Delegates to github-repository-investigator for standardized patterns.
    """
    
    # Use GitHub Repository Investigator skill
    investigation_result = invoke_skill(
        "github-repository-investigator", 
        "investigate_repository_structure",
        repository_name=repository_name
    )
    
    if investigation_result.status == "ERROR":
        return ArchitectureDiscovery(
            status="BLOCKED",
            message=f"Erro na investigação do repositório: {investigation_result.message}",
            blocking_issue="repository_investigation_failed"
        )
    
    # Validate single-stack constraint
    stack_validation = validate_single_stack_constraint(
        task_context=task_context,
        architecture=investigation_result.architecture
    )
    
    if stack_validation.status == "MIXED_STACK":
        return ArchitectureDiscovery(
            status="BLOCKED", 
            message="🚫 TASKS MISTAS NÃO PERMITIDAS\\n\\nDivida em tasks separadas por stack tecnológica.",
            blocking_issue="mixed_stack_detected"
        )
    
    return ArchitectureDiscovery(
        status="DISCOVERED",
        repository=repository_name,
        framework=investigation_result.framework,
        stack=stack_validation.primary_stack,
        architecture=investigation_result.architecture,
        investigation_confidence=investigation_result.validation.architecture_confidence
    )

def validate_single_stack_constraint(
    task_context: MondayTaskData,
    architecture: RepositoryArchitecture
) -> StackValidation:
    """Validates that task focuses on single technology stack."""
    
    # Extract stack indicators from task description and context
    task_stack_indicators = extract_stack_indicators_from_task(task_context)
    
    # Determine primary stack from architecture
    architecture_stack = determine_primary_stack(architecture)
    
    # Check for mixed-stack patterns in task description
    mixed_stack_keywords = [
        "frontend e backend", "full-stack", "múltiplas stacks",
        "mobile e web", "api e ui", "mixed technologies"
    ]
    
    task_text = f"{task_context.description} {task_context.contexto}".lower()
    
    if any(keyword in task_text for keyword in mixed_stack_keywords):
        return StackValidation(
            status="MIXED_STACK",
            message="Task indica trabalho em múltiplas stacks",
            mixed_indicators=extract_mixed_indicators(task_text)
        )
    
    return StackValidation(
        status="SINGLE_STACK",
        primary_stack=architecture_stack,
        task_stack_alignment=check_task_stack_alignment(task_stack_indicators, architecture_stack)
    )
```

### Memory Management

```python
def save_analysis_memory(
    monday_validation: MondayValidationResult,
    repository_confirmation: RepositoryConfirmation, 
    playbook_compliance: PlaybookCompliance,
    architecture_discovery: ArchitectureDiscovery
) -> MemoryPaths:
    """
    Saves complete analysis results to session and repository memory.
    
    Returns:
        MemoryPaths: Paths to saved memory files for downstream skills
    """
    
    # Session memory: Analysis results for refinement generation
    session_memory = {
        'analysis_timestamp': datetime.now().isoformat(),
        'monday_url': monday_validation.monday_url,
        'task_data': monday_validation.task_data,
        'repository_name': repository_confirmation.repository_name,
        'repository_explicitly_confirmed': True,  # Critical flag
        'framework': architecture_discovery.framework,
        'stack': architecture_discovery.stack,
        'playbook_compliant': playbook_compliance.status == "COMPLIANT",
        'ready_for_refinement': all_phases_successful(monday_validation, repository_confirmation, playbook_compliance, architecture_discovery)
    }
    
    session_path = "/memories/session/monday_task_analysis_results.md"
    save_memory(session_path, session_memory)
    
    # Repository memory: Architecture investigation for reuse
    if architecture_discovery.status == "DISCOVERED":
        repo_memory_path = invoke_skill(
            "github-repository-investigator",
            "save_investigation_memory", 
            repository_name=repository_confirmation.repository_name,
            analysis=architecture_discovery
        )
    else:
        repo_memory_path = None
    
    return MemoryPaths(
        session_analysis=session_path,
        repository_investigation=repo_memory_path
    )
```

## Output Templates

### Success Template

```yaml
✅ ANÁLISE MONDAY.COM COMPLETA:

📋 Task Validada:
• URL: ✅ Acessível
• Repositório: ✅ {repository_name} (confirmado explicitamente)
• Playbook Brasileiro: ✅ Conforme

🏗️ Arquitetura Descoberta:
• Framework: {framework} 
• Stack: {stack} (single-stack ✅)
• Confiança: {investigation_confidence}%

📝 Próximo Passo: 
Refinement generation com contexto validado

💾 Memória Salva:
• Session: /memories/session/monday_task_analysis_results.md
• Repository: {repo_memory_path}
```

### Blocked Template 

```yaml
🚫 ANÁLISE BLOQUEADA - {blocking_reason}:

❌ Problema CRÍTICO:
{detailed_blocking_message}

🔧 Ação Requerida:
{step_by_step_correction_guide}

⚠️ REFINEMENT BLOQUEADO até resolução do problema.

📚 Referência: March 2026 lessons learned - {relevant_lesson}
```

## Integration Points

- **Input:** Monday.com task URL from user
- **Dependencies:** monday.com MCP, github-repository-investigator, brazilian-agile-framework
- **Output:** Complete task analysis with validated context
- **Memory:** Session analysis results + repository investigation
- **Consumers:** monday-refinement-generator skill

## Quality Gates Summary

1. **URL Validation** → Ensures Monday.com accessibility
2. **Repository Confirmation** → Prevents March 2026 assumption errors 
3. **Brazilian Playbook** → Validates methodology compliance
4. **Architecture Discovery** → Maps real repository structure
5. **Single-Stack Validation** → Prevents scope creep

---

**Analysis Principle:** Validate everything, assume nothing. Each quality gate must pass before proceeding to ensure accurate refinement generation.