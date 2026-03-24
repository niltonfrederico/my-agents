---
skill: true
name: "brazilian-agile-framework"
description: "**BRAZILIAN AGILE FRAMEWORK** — Specialized utility for Brazilian Agile methodology validation and Planning Poker estimation. USE FOR: Planning Poker calculations; Brazilian playbook validation; effort estimation; complexity analysis; uncertainty assessment. PROVIDES: proven estimation algorithms; Brazilian methodology compliance; task complexity analysis; effort justification. JUNTOSSOMOSMAIS FOCUS: March 2026 proven 'Incertezas vs Complexidade' model; Brazilian task validation patterns; company-specific Agile practices."
applyTo:
  - "**/*planning*/**"
  - "**/*estimation*/**"
  - "**/*agile*/**" 
  - "**/*refinement*/**"
invokes:
  - "vscode_askQuestions"
  - "memory"
---

# Brazilian Agile Framework Skill

## Overview

**METHODOLOGY UTILITY:** Provides Brazilian Agile methodology validation and Planning Poker estimation using proven frameworks from juntossomosmais practices.

## Brazilian Playbook Validation

### Task Field Validation

```python
def validate_brazilian_playbook_compliance(task_data: MondayTaskData) -> PlaybookValidation:
    """
    Validates task against Brazilian Agile methodology requirements.
    
    Args:
        task_data: Complete Monday.com task information
        
    Returns:
        PlaybookValidation: Detailed compliance check with mandatory/optional results
    """
    
    mandatory_validations = {
        'tema_epico': validate_tema_epico_field(task_data.tema_epico),
        'contexto': validate_contexto_field(task_data.contexto)
    }
    
    optional_enhancements = {
        'description_quality': assess_description_quality(task_data.description),
        'business_value': assess_business_value(task_data.valor),
        'acceptance_criteria': assess_acceptance_criteria(task_data.criterios_aceite)
    }
    
    return PlaybookValidation(
        mandatory_results=mandatory_validations,
        enhancement_opportunities=optional_enhancements,
        overall_compliance=calculate_compliance_score(mandatory_validations, optional_enhancements)
    )

def validate_tema_epico_field(tema_epico: str) -> FieldValidation:
    """Validates Tema/Épico field against Brazilian standards."""
    
    if not tema_epico or tema_epico.strip() == "":
        return FieldValidation(
            status="FAIL",
            message="Campo Tema/Épico é obrigatório",
            is_blocking=True
        )
    
    # Check length constraints  
    if len(tema_epico.strip()) < 3:
        return FieldValidation(
            status="FAIL", 
            message="Tema/Épico deve ter pelo menos 3 caracteres",
            is_blocking=True
        )
    
    if len(tema_epico.strip()) > 100:
        return FieldValidation(
            status="FAIL",
            message="Tema/Épico deve ter no máximo 100 caracteres", 
            is_blocking=True
        )
    
    # Check for placeholder values
    placeholder_values = ["tbd", "n/a", "pendente", "a definir", "todo"]
    if tema_epico.lower().strip() in placeholder_values:
        return FieldValidation(
            status="FAIL",
            message="Tema/Épico não pode ser valor genérico ou placeholder",
            is_blocking=True,
            suggestion="Defina um tema específico que represente o valor de negócio"
        )
    
    return FieldValidation(
        status="PASS",
        message="Tema/Épico válido",
        is_blocking=False
    )

def validate_contexto_field(contexto: str) -> FieldValidation:
    """Validates Contexto field for business justification."""
    
    if not contexto or contexto.strip() == "":
        return FieldValidation(
            status="FAIL",
            message="Campo Contexto é obrigatório",
            is_blocking=True
        )
    
    # Minimum meaningful content requirement
    if len(contexto.strip()) < 30:
        return FieldValidation(
            status="FAIL",
            message="Contexto deve ter pelo menos 30 caracteres explicando a justificativa de negócio",
            is_blocking=True,
            suggestion="Adicione contexto sobre: problema atual, impacto no negócio, stakeholders afetados"
        )
    
    # Check for boilerplate content
    boilerplate_indicators = [
        "lorem ipsum", "texto padrão", "preencher depois",
        "contexto genérico", "adicionar contexto"
    ]
    
    if any(indicator in contexto.lower() for indicator in boilerplate_indicators):
        return FieldValidation(
            status="FAIL",
            message="Contexto não pode conter texto padrão ou boilerplate",
            is_blocking=True,
            suggestion="Descreva o contexto real de negócio para esta tarefa"
        )
    
    return FieldValidation(
        status="PASS", 
        message="Contexto válido com justificativa de negócio",
        is_blocking=False
    )
```

## Planning Poker Estimation Framework

### "Incertezas vs Complexidade" Model (March 2026 Proven)

```python
def calculate_planning_poker_estimate(
    task_context: TaskContext,
    technical_analysis: TechnicalAnalysis
) -> PlanningPokerResult:
    """
    Uses proven 'Incertezas vs Complexidade' model for accurate estimation.
    
    Args:
        task_context: Business context and requirements
        technical_analysis: Architecture and implementation complexity
        
    Returns:
        PlanningPokerResult: Size estimate with detailed justification
    """
    
    uncertainty_assessment = assess_uncertainty_level(task_context, technical_analysis)
    complexity_assessment = assess_complexity_level(task_context, technical_analysis)
    
    # March 2026 proven estimation matrix
    size_matrix = {
        ('low', 'low'): EstimateSize.XS,      # 1-2 dias
        ('low', 'medium'): EstimateSize.S,    # 2-3 dias
        ('medium', 'low'): EstimateSize.S,    # 2-3 dias  
        ('medium', 'medium'): EstimateSize.M, # 3-5 dias
        ('medium', 'high'): EstimateSize.L,   # 5-8 dias
        ('high', 'medium'): EstimateSize.L,   # 5-8 dias
        ('high', 'high'): EstimateSize.XL     # 8+ dias
    }
    
    estimated_size = size_matrix.get(
        (uncertainty_assessment.level, complexity_assessment.level), 
        EstimateSize.M  # Default fallback
    )
    
    return PlanningPokerResult(
        size=estimated_size,
        days_estimate=get_days_for_size(estimated_size),
        uncertainty_factors=uncertainty_assessment.factors,
        complexity_factors=complexity_assessment.factors,
        estimation_confidence=calculate_confidence(uncertainty_assessment, complexity_assessment),
        methodology="Incertezas vs Complexidade (Mar 2026)"
    )

def assess_uncertainty_level(
    task_context: TaskContext, 
    technical_analysis: TechnicalAnalysis
) -> UncertaintyAssessment:
    """Assesses uncertainty factors that affect estimation accuracy."""
    
    uncertainty_factors = []
    
    # Business uncertainty indicators
    if task_context.requirements_unclear:
        uncertainty_factors.append("Requisitos de negócio não completamente definidos")
    
    if task_context.stakeholder_alignment_pending:
        uncertainty_factors.append("Alinhamento com stakeholders ainda necessário")
    
    if task_context.business_rules_complex:
        uncertainty_factors.append("Regras de negócio complexas requerem validação")
    
    # Technical uncertainty indicators  
    if technical_analysis.new_technologies_required:
        uncertainty_factors.append("Tecnologias ou padrões novos para a equipe")
    
    if technical_analysis.external_dependencies_unknown:
        uncertainty_factors.append("Dependências externas com comportamento incerto")
        
    if technical_analysis.integration_points_untested:
        uncertainty_factors.append("Pontos de integração não testados anteriormente")
    
    if technical_analysis.performance_requirements_unclear:
        uncertainty_factors.append("Requisitos de performance não quantificados")
    
    # Calculate uncertainty level
    uncertainty_score = len(uncertainty_factors)
    
    if uncertainty_score >= 4:
        level = "high"
    elif uncertainty_score >= 2:
        level = "medium"
    else:
        level = "low"
    
    return UncertaintyAssessment(
        level=level,
        score=uncertainty_score,
        factors=uncertainty_factors,
        assessment_date=datetime.now()
    )

def assess_complexity_level(
    task_context: TaskContext,
    technical_analysis: TechnicalAnalysis  
) -> ComplexityAssessment:
    """Assesses technical complexity factors that affect implementation effort."""
    
    complexity_factors = []
    
    # Implementation complexity indicators
    if technical_analysis.files_affected > 5:
        complexity_factors.append(f"Múltiplos arquivos impactados ({technical_analysis.files_affected})")
    
    if technical_analysis.requires_database_changes:
        complexity_factors.append("Mudanças no modelo de dados e migrações")
    
    if technical_analysis.affects_api_contracts:
        complexity_factors.append("Alterações em contratos de API (breaking changes)")
    
    if technical_analysis.complex_business_logic_required:
        complexity_factors.append("Lógica de negócio complexa com múltiplas regras")
    
    if technical_analysis.requires_extensive_testing:
        complexity_factors.append("Estratégia de testes abrangente necessária")
    
    if technical_analysis.affects_multiple_services:
        complexity_factors.append("Impacto em múltiplos serviços ou aplicações")
    
    if technical_analysis.requires_performance_optimization:
        complexity_factors.append("Otimizações de performance requeridas")
    
    # Calculate complexity level
    complexity_score = len(complexity_factors)
    
    if complexity_score >= 5:
        level = "high"
    elif complexity_score >= 2:
        level = "medium" 
    else:
        level = "low"
    
    return ComplexityAssessment(
        level=level,
        score=complexity_score, 
        factors=complexity_factors,
        assessment_date=datetime.now()
    )
```

### Effort Calculation and Justification

```python
def generate_estimation_justification(result: PlanningPokerResult) -> EstimationJustification:
    """Generates detailed justification for Planning Poker estimate."""
    
    justification_template = f"""
### 📊 Planning Poker: **{result.size}** ({result.days_estimate} dias úteis)

#### Metodologia: {result.methodology}
**Confiança:** {result.estimation_confidence}% (baseado em histórico Mar 2026)

#### Fatores de Incerteza ({result.uncertainty_assessment.level.upper()})
{format_factor_list(result.uncertainty_factors)}

#### Fatores de Complexidade ({result.complexity_assessment.level.upper()})  
{format_factor_list(result.complexity_factors)}

#### Distribuição de Esforço Estimada:
- **Análise e Preparação:** {result.days_estimate * 0.2:.1f} dias ({20}%)
- **Implementação:** {result.days_estimate * 0.6:.1f} dias ({60}%)
- **Testes e Validação:** {result.days_estimate * 0.2:.1f} dias ({20}%)

#### Marcos de Validação:
{generate_validation_milestones(result)}
    """
    
    return EstimationJustification(
        content=justification_template,
        confidence_level=result.estimation_confidence,
        validation_milestones=generate_validation_milestones(result),
        risk_factors=extract_risk_factors(result)
    )

def format_factor_list(factors: list[str]) -> str:
    """Formats factor list for markdown output."""
    if not factors:
        return "- Nenhum fator significativo identificado"
    
    return "\n".join([f"- {factor}" for factor in factors])

def generate_validation_milestones(result: PlanningPokerResult) -> list[str]:
    """Generates validation milestones based on estimate size."""
    
    milestones = [
        f"Dia {result.days_estimate * 0.2:.0f}: Análise completa e abordagem validada",
        f"Dia {result.days_estimate * 0.6:.0f}: Implementação core finalizada",
        f"Dia {result.days_estimate * 0.8:.0f}: Testes implementados e passando", 
        f"Dia {result.days_estimate:.0f}: Validação final e deploy pronto"
    ]
    
    # Add size-specific milestones
    if result.size in [EstimateSize.L, EstimateSize.XL]:
        milestones.insert(1, f"Dia {result.days_estimate * 0.3:.0f}: Spike/POC concluído (se necessário)")
    
    if result.size == EstimateSize.XL:
        milestones.insert(-1, f"Dia {result.days_estimate * 0.9:.0f}: Review arquitetural e performance")
    
    return milestones
```

## Size Definitions and Standards

```python
class EstimateSize(Enum):
    XS = "XS"  # 1-2 dias  
    S = "S"    # 2-3 dias
    M = "M"    # 3-5 dias
    L = "L"    # 5-8 dias
    XL = "XL"  # 8+ dias

SIZE_DEFINITIONS = {
    EstimateSize.XS: {
        'days': (1, 2),
        'description': 'Alterações simples, padrões conhecidos, risco baixo',
        'examples': ['Ajustes de configuração', 'Correções de texto', 'Pequenos bugfixes']
    },
    EstimateSize.S: {
        'days': (2, 3), 
        'description': 'Funcionalidade pequena, padrões estabelecidos',
        'examples': ['Nova API endpoint simples', 'Validação de campo', 'Pequena regra de negócio']
    },
    EstimateSize.M: {
        'days': (3, 5),
        'description': 'Funcionalidade média, pode incluir padrões novos',
        'examples': ['CRUD completo', 'Integração com serviço conhecido', 'Refatoração média']
    },
    EstimateSize.L: {
        'days': (5, 8),
        'description': 'Funcionalidade complexa, múltiplas integrações',
        'examples': ['Nova integração externa', 'Mudanças arquiteturais', 'Performance crítica']
    },
    EstimateSize.XL: {
        'days': (8, float('inf')),
        'description': 'Épico ou funcionalidade muito complexa',
        'examples': ['Nova arquitetura', 'Múltiplos sistemas', 'Research significativo']
    }
}

def get_days_for_size(size: EstimateSize) -> float:
    """Returns median days estimate for given size."""
    days_range = SIZE_DEFINITIONS[size]['days']
    return (days_range[0] + min(days_range[1], 15)) / 2  # Cap at 15 for XL
```

## Integration Points

- **Used by:** monday-task-analyzer, monday-refinement-generator
- **Provides:** Brazilian methodology validation, Planning Poker estimation
- **Standards:** March 2026 proven "Incertezas vs Complexidade" model
- **Memory:** Saves estimation patterns for continuous improvement

---

**Framework Principle:** Use proven Brazilian Agile practices with data-driven estimation. Uncertainty and complexity assessment drives accurate effort planning.