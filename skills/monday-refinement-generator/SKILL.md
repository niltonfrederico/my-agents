---
skill: true
name: "monday-refinement-generator"
description: "**MONDAY REFINEMENT GENERATOR** — Synthesizes validated Monday.com analysis into comprehensive implementation plans with Planning Poker estimation. USE FOR: implementation planning; effort estimation; task breakdown; acceptance criteria creation; testing strategy. CREATES: detailed refinement documents; Planning Poker estimates; file change analysis; testing plans. JUNTOSSOMOSMAIS FOCUS: Brazilian Agile methodology; Django/Python and .NET/C# patterns; r2-d2 compliance preparation."
applyTo:
  - "**/*refinement*/**"
  - "**/*planning*/**" 
  - "**/*implementation*/**"
  - "**/*analysis*/**"
invokes:
  - "brazilian-agile-framework"
  - "github-repository-investigator"
  - "memory"
  - "file_operations"
  - "Explore"
---

# Monday Refinement Generator Skill

## Overview

**SYNTHESIS SKILL:** Combines validated Monday.com analysis from monday-task-analyzer skill with Planning Poker estimation to generate comprehensive, actionable refinement documentation.

## Prerequisites Verification

```typescript
interface RefinementPrerequisites {
  analysis_results: string; // /memories/session/monday_task_analysis_results.md
  repository_investigation: string; // /memories/repo/{repo}_investigation.md (optional)
  analysis_complete: boolean; // From monday-task-analyzer
}

function verify_refinement_prerequisites(prerequisites: RefinementPrerequisites): boolean {
  const analysis_exists = check_memory_file(prerequisites.analysis_results);
  const analysis_complete = prerequisites.analysis_complete;
  
  return analysis_exists && analysis_complete;
}
```

## Refinement Generation Process

### Phase 1: Context Integration

```python
def load_validated_analysis_context() -> RefinementContext:
    """
    Loads complete validated context from monday-task-analyzer skill.
    
    Returns:
        RefinementContext: All validated inputs ready for refinement generation
    """
    
    # Load analysis results from session memory
    analysis_results = read_memory("/memories/session/monday_task_analysis_results.md")
    
    if not analysis_results.ready_for_refinement:
        raise AnalysisIncomplete("Analysis must be completed by monday-task-analyzer before refinement")
    
    # Load repository investigation if available
    repository_investigation = None
    if analysis_results.repository_investigation_path:
        repository_investigation = read_memory(analysis_results.repository_investigation_path)
    
    return RefinementContext(
        task_data=analysis_results.task_data,
        repository_name=analysis_results.repository_name,  # Explicitly confirmed
        framework=analysis_results.framework,
        stack=analysis_results.stack,
        architecture=repository_investigation.architecture if repository_investigation else None,
        playbook_compliant=analysis_results.playbook_compliant,
        analysis_timestamp=analysis_results.analysis_timestamp
    )
```

### Phase 2: Implementation Impact Analysis

```python
def analyze_implementation_impact(
    context: RefinementContext,
    task_business_terms: list[str]
) -> ImplementationImpact:
    """
    Analyzes codebase to understand implementation scope and complexity.
    
    Uses Explore subagent for deep codebase understanding when needed.
    """
    
    # Basic impact analysis from architecture memory
    if context.architecture:
        affected_files = estimate_files_from_architecture(context.architecture)
        integration_points = identify_integration_points(context.architecture)
    else:
        affected_files = []
        integration_points = []
    
    # Enhanced analysis via Explore subagent when gaps exist
    if needs_deeper_exploration(context, affected_files):
        exploration_results = runSubagent(
            agent="Explore",
            description="Codebase exploration for refinement",
            prompt=f"""
            Explore {context.repository_name} to understand:
            
            1. **Implementation Patterns**: How similar features are implemented
            2. **File Organization**: Where business logic, models, APIs are structured
            3. **Testing Patterns**: Test organization and coverage approach
            4. **Integration Points**: How this task might affect existing functionality
            
            Business context: {task_business_terms}
            Framework: {context.framework}
            
            Focus on: entry points, existing implementations of similar features, 
            test utilities, and any patterns relevant to this business domain.
            
            Provide concrete file paths and implementation patterns found.
            """
        )
        
        affected_files = integrate_exploration_results(affected_files, exploration_results)
    
    return ImplementationImpact(
        files_affected=affected_files,
        complexity_indicators=extract_complexity_indicators(context),
        integration_points=integration_points,
        testing_scope=determine_testing_scope(context)
    )

def needs_deeper_exploration(context: RefinementContext, affected_files: list) -> bool:
    """Determines if deeper codebase exploration is needed."""
    
    needs_exploration = [
        len(affected_files) == 0,  # No files identified
        context.architecture is None,  # No architecture context
        is_complex_business_domain(context.task_data),  # Complex business logic
        requires_integration_analysis(context.task_data)  # Integration complexity
    ]
    
    return any(needs_exploration)
```

### Phase 3: Planning Poker Estimation

```python
def calculate_planning_poker_estimate(
    context: RefinementContext,
    impact: ImplementationImpact
) -> PlanningPokerResult:
    """
    Uses brazilian-agile-framework skill for proven Planning Poker estimation.
    
    Returns:
        PlanningPokerResult: Size, effort, and detailed justification
    """
    
    # Prepare context for Brazilian Agile Framework
    task_context = TaskContext(
        requirements_unclear=assess_requirements_clarity(context.task_data),
        stakeholder_alignment_pending=needs_stakeholder_validation(context.task_data),
        business_rules_complex=has_complex_business_rules(context.task_data, impact)
    )
    
    technical_analysis = TechnicalAnalysis(
        files_affected=len(impact.files_affected),
        requires_database_changes=requires_db_changes(impact),
        affects_api_contracts=affects_apis(impact),
        complex_business_logic_required=has_complex_logic(impact),
        requires_extensive_testing=needs_extensive_testing(impact),
        affects_multiple_services=affects_multiple_services(impact),
        new_technologies_required=uses_new_technologies(context, impact),
        external_dependencies_unknown=has_unknown_dependencies(impact),
        integration_points_untested=has_untested_integrations(impact),
        performance_requirements_unclear=needs_performance_analysis(context.task_data)
    )
    
    # Delegate to Brazilian Agile Framework skill
    estimation_result = invoke_skill(
        "brazilian-agile-framework",
        "calculate_planning_poker_estimate",
        task_context=task_context,
        technical_analysis=technical_analysis
    )
    
    return estimation_result
```

## Stack-Specific Output Templates

### Django/Python Refinement Template

```markdown
def generate_django_refinement(
    context: RefinementContext, 
    estimate: PlanningPokerEstimate,
    impact: ImplementationImpact
) -> str:
    """Generates Django-specific refinement following juntossomosmais patterns."""
    
    template = f"""
# REFINEMENT - {context.task_data.name}

**ID:** #{context.task_data.id} | **Stack:** Python/Django ✅ | **Planning Poker:** **{estimate.size}**

## 🎯 Contexto de Negócio
**Tema:** {context.task_data.tema_epico}
**Contexto:** {context.task_data.contexto}
**Valor:** {context.task_data.valor or 'A ser definido durante implementação'}

## 📊 Análise de Complexidade  
**Estimativa:** **{estimate.size}** ({estimate.days_estimate} dias úteis)

### Incertezas ({estimate.uncertainty_level})
{format_uncertainty_factors(estimate.uncertainty_factors)}

### Complexidade ({estimate.complexity_level})
{format_complexity_factors(estimate.complexity_factors)}

## 🏗️ Aplicações Impactadas
### {context.repository}
**Framework:** Django {context.architecture.django_version or 'Latest'}
**Estrutura:** {context.architecture.summary}

## 📁 Arquivos por Mudança
{generate_file_change_table(impact.files_affected)}

## ⚡ Plano de Implementação

### 1. Análise e Preparação ({estimate.days_estimate * 0.2:.1f} dias)
- [ ] **Exploração:** Mapear implementações similares no codebase
- [ ] **Dependências:** Confirmar integrações com outros serviços
- [ ] **Dados:** Analisar modelo de dados e migrações necessárias
- [ ] **Testes:** Revisar estratégia de testes existente

### 2. Implementação ({estimate.days_estimate * 0.6:.1f} dias)
{generate_django_implementation_steps(context, impact)}

### 3. Testing Strategy ({estimate.days_estimate * 0.2:.1f} dias)
**Framework:** django.test.TestCase (padrão juntossomosmais)
**Localização:** `tests/integration/api/{get_module_name(context)}/test_views.py`

#### Test Cases Mínimos:
{generate_test_cases(context, impact)}

#### Comandos de Teste:
- **Seletivo:** `docker compose run --remove-orphans --rm integration-tests python manage.py test {get_test_path(context)}`
- **Completo:** `docker compose run --remove-orphans --rm integration-tests`

## 🛡️ Critérios de Aceite
{generate_acceptance_criteria(context.task_data)}

---
**Gerado:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} | **Próximo:** Validação de compliance r2-d2
"""
    return template
```

### .NET/C# Refinement Template

```markdown
def generate_dotnet_refinement(
    context: RefinementContext,
    estimate: PlanningPokerEstimate, 
    impact: ImplementationImpact
) -> str:
    """Generates .NET-specific refinement following juntossomosmais patterns."""
    
    template = f"""
# REFINEMENT - {context.task_data.name}

**ID:** #{context.task_data.id} | **Stack:** C#/.NET ✅ | **Planning Poker:** **{estimate.size}**

## 🎯 Contexto de Negócio
**Tema:** {context.task_data.tema_epico}
**Contexto:** {context.task_data.contexto}
**Valor:** {context.task_data.valor or 'A ser definido durante implementação'}

## 📊 Análise de Complexidade
**Estimativa:** **{estimate.size}** ({estimate.days_estimate} dias úteis)
{estimate.justification}

## 🏗️ Aplicações Impactadas
### {context.repository}
**Framework:** .NET {context.architecture.dotnet_version or 'Latest'}
**Estrutura:** {context.architecture.summary}

## 📁 Arquivos por Mudança  
{generate_file_change_table(impact.files_affected)}

## ⚡ Plano de Implementação

### 1. Análise e Preparação ({estimate.days_estimate * 0.2:.1f} dias)
- [ ] **Controllers:** Mapear endpoints afetados na camada de API
- [ ] **Entities:** Analisar modelo de dados e Entity Framework migrations
- [ ] **Services:** Identificar business logic e dependency injection
- [ ] **Tests:** Revisar estrutura de testes (Unit/Integration)

### 2. Implementação ({estimate.days_estimate * 0.6:.1f} dias)
{generate_dotnet_implementation_steps(context, impact)}

### 3. Testing Strategy ({estimate.days_estimate * 0.2:.1f} dias)
**Frameworks:** xUnit + FluentAssertions (padrão juntossomosmais)
**Localização:** `Tests/{get_project_name(context)}.Tests/Integration/`

#### Test Cases Mínimos:
{generate_test_cases(context, impact)}

#### Comandos de Teste:
- **Unit Tests:** `dotnet test --filter "Category=Unit"`
- **Integration:** `dotnet test --filter "Category=Integration"`
- **Completo:** `dotnet test`

## 🛡️ Critérios de Aceite
{generate_acceptance_criteria(context.task_data)}

---
**Gerado:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} | **Próximo:** Validação de compliance r2-d2
"""
    return template
```

### Output Management

```python
def save_refinement_output(
    refinement_content: str, 
    context: RefinementContext,
    estimation: PlanningPokerResult
) -> str:
    """
    Saves refinement to temp.md and updates session memory.
    
    Returns:
        str: Path to saved refinement file
    """
    
    # Save to temp.md for compliance validation
    output_path = "/Users/niltonfrat/.copilot/agents/temp.md" 
    write_file(output_path, refinement_content)
    
    # Update session memory with generation results
    generation_results = {
        'refinement_path': output_path,
        'repository': context.repository_name,
        'framework': context.framework,
        'stack': context.stack,
        'planning_poker_size': estimation.size,
        'planning_poker_days': estimation.days_estimate,
        'estimation_confidence': estimation.estimation_confidence,
        'generation_timestamp': datetime.now().isoformat(),
        'ready_for_compliance': True
    }
    
    update_memory("/memories/session/refinement_generation_results.md", generation_results)
    
    return output_path
```

## Quality Assurance

### Pre-Generation Validation

```yaml
✅ QUALITY GATES:
- [ ] Analysis results loaded from monday-task-analyzer
- [ ] Repository explicitly confirmed (never assumed) 
- [ ] Brazilian playbook compliance verified
- [ ] Architecture discovery completed (if available)
- [ ] Single-stack constraint validated

❌ BLOCKING CONDITIONS:
- Missing analysis results from monday-task-analyzer skill
- Analysis not marked as ready_for_refinement
- Repository not explicitly confirmed in analysis phase
- Incomplete task data or context
```

### Post-Generation Verification

```yaml
✅ OUTPUT VALIDATION:
- [ ] Planning Poker estimate with detailed justification (Brazilian framework)
- [ ] File change analysis with concrete paths (from real architecture)
- [ ] Implementation plan with stack-specific steps
- [ ] Testing strategy following juntossomosmais conventions
- [ ] Acceptance criteria derived from business context
- [ ] Compliance preparation for r2-d2 validation

📝 SUCCESS MESSAGE:
"✅ REFINEMENT GERADO COM SUCESSO

📋 Resumo:
• Planning Poker: {size} ({days} dias)
• Metodologia: {estimation_methodology}
• Arquivos Impactados: {file_count}
• Framework: {framework} 
• Testing: {test_strategy}

📄 Refinement salvo: temp.md
🎯 Próximo: Validação de compliance r2-d2"
```

## Integration Points

- **Input:** Validated analysis from monday-task-analyzer skill
- **Dependencies:** brazilian-agile-framework, github-repository-investigator, memory, Explore subagent
- **Output:** Comprehensive refinement document saved to temp.md
- **Memory:** Generation results for r2d2-compliance-validator
- **Quality:** Brazilian Planning Poker methodology with proven March 2026 accuracy

---

**Skill Principle:** Focus on synthesis and output generation. Leverage specialized utility skills for Planning Poker estimation and architecture investigation to maintain single responsibility.