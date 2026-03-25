---

name: "r2d2-compliance-validator"
description: "**R2-D2 COMPLIANCE VALIDATOR** — Final validation gate ensuring refinements comply with juntossomosmais organizational standards. USE FOR: r2-d2 standards validation; code quality compliance; architectural pattern verification; testing requirement validation; deployment checklist verification. VALIDATES: Python/Django and C#/.NET conventions; prevents technical debt; ensures architectural compliance. JUNTOSSOMOSMAIS FOCUS: Company-specific patterns; r2-d2 repository integration; technical debt prevention."

---

# R2-D2 Compliance Validator Skill

## Overview

**FINAL QUALITY GATE:** Validates refinements against juntossomosmais/r2-d2 organizational standards to prevent technical debt and ensure architectural compliance across Python/Django and C#/.NET projects.

## Prerequisites Verification

```typescript
interface CompliancePrerequisites {
  refinement_document: string; // temp.md location
  generation_results: string; // /memories/session/refinement_generation_results.md
  validated_stack: 'python' | 'csharp' | 'javascript';
  repository_name: string; // From validated context
}

function verify_compliance_prerequisites(prerequisites: CompliancePrerequisites): boolean {
  const refinement_exists = check_file_exists(prerequisites.refinement_document);
  const generation_memory = check_memory_file(prerequisites.generation_results);
  const stack_supported = ['python', 'csharp'].includes(prerequisites.validated_stack);

  return refinement_exists && generation_memory && stack_supported;
}
```

## Compliance Validation Process

### Phase 1: Load R2-D2 Standards

```python
def load_r2d2_organizational_standards(validated_stack: str) -> OrganizationalStandards:
    """
    Loads stack-specific compliance rules from juntossomosmais/r2-d2 repository.

    Args:
        validated_stack: Technology stack from technical analysis

    Returns:
        OrganizationalStandards: Complete compliance ruleset
    """

    # Access r2-d2 repository via GitHub MCP
    try:
        r2d2_repo = github_get_repository_info("juntossomosmais/r2-d2")
    except RepositoryNotFound:
        return handle_r2d2_unavailable(validated_stack)

    # Load stack-specific rules
    stack_rule_paths = {
        'python': 'rules/backend/python/',
        'csharp': 'rules/backend/csharp/',
        'javascript': 'rules/frontend/javascript/'
    }

    rule_path = stack_rule_paths.get(validated_stack)
    if rule_path:
        rules_content = github_get_directory_contents("juntossomosmais/r2-d2", rule_path)
        return parse_r2d2_compliance_rules(rules_content)

    return get_fallback_standards(validated_stack)
```

### Phase 2: Stack-Specific Validation

#### Python/Django Compliance Checklist

```python
def validate_python_django_compliance(refinement_content: str) -> ComplianceResult:
    """
    Validates refinement against juntossomosmais Django standards.

    Returns:
        ComplianceResult: Detailed compliance check with pass/fail status
    """

    compliance_checks = {
        # Testing Requirements (MANDATORY)
        'testing_strategy': validate_django_testing_strategy(refinement_content),
        'test_framework': check_test_framework_usage(refinement_content, 'django.test.TestCase'),
        'test_locations': validate_test_file_locations(refinement_content),
        'test_commands': check_docker_test_commands(refinement_content),

        # Code Quality Requirements (MANDATORY)  
        'logging_patterns': validate_no_fstring_logging(refinement_content),
        'environment_variables': check_settings_only_env_vars(refinement_content),
        'query_optimization': validate_n_plus_one_prevention(refinement_content),
        'type_annotations': check_method_type_annotations(refinement_content),

        # Django API Requirements (IF API CHANGES)
        'thin_views': validate_thin_view_principle(refinement_content),
        'explicit_permissions': check_permissions_classes(refinement_content),
        'named_urls': validate_named_url_patterns(refinement_content),
        'openapi_docs': check_extend_schema_usage(refinement_content),

        # Forbidden Patterns (BLOCKING)
        'business_logic_in_views': check_no_business_logic_in_views(refinement_content),
        'manual_validators': check_no_manual_validation_calls(refinement_content),
        'missing_auth': check_authentication_authorization(refinement_content)
    }

    # Calculate compliance score
    mandatory_failed = [check for check, result in compliance_checks.items()
                       if result.is_mandatory and not result.passed]

    if mandatory_failed:
        return ComplianceResult(
            status="BLOCKED",
            mandatory_failures=mandatory_failed,
            compliance_score=calculate_compliance_percentage(compliance_checks)
        )

    return ComplianceResult(
        status="APPROVED",
        warnings=extract_warnings(compliance_checks),
        compliance_score=calculate_compliance_percentage(compliance_checks)
    )

# Individual validation functions
def validate_django_testing_strategy(content: str) -> ValidationCheck:
    """Ensures comprehensive testing strategy is documented."""

    required_elements = [
        "django.test.TestCase",
        "tests/integration/api/",
        "docker compose run",
        "integration-tests"
    ]

    missing_elements = [elem for elem in required_elements if elem not in content]

    return ValidationCheck(
        name="Django Testing Strategy",
        passed=len(missing_elements) == 0,
        is_mandatory=True,
        message=f"Missing: {', '.join(missing_elements)}" if missing_elements else "✅ Complete"
    )

def validate_no_fstring_logging(content: str) -> ValidationCheck:
    """Prevents f-string usage in logging statements."""

    # Search for prohibited f-string logging patterns
    fstring_logging_patterns = [
        r'logger\.(debug|info|warning|error|critical)\(f["\']',
        r'log\.(debug|info|warning|error|critical)\(f["\']',
        r'logging\.(debug|info|warning|error|critical)\(f["\']'
    ]

    violations_found = []
    for pattern in fstring_logging_patterns:
        matches = re.findall(pattern, content, re.IGNORECASE)
        violations_found.extend(matches)

    return ValidationCheck(
        name="F-String Logging Prevention",
        passed=len(violations_found) == 0,
        is_mandatory=True,
        message="❌ F-strings detected in logging" if violations_found else "✅ Parameterized logging"
    )

def validate_thin_view_principle(content: str) -> ValidationCheck:
    """Ensures business logic is not placed in Django views."""

    business_logic_indicators = [
        "def post(self, request):",  # Complex view methods
        "business_logic",
        "calculation",
        "processing",
        "complex logic in view"
    ]

    # This is heuristic - mainly checks documentation mentions business logic placement
    violations = [indicator for indicator in business_logic_indicators
                 if indicator in content.lower() and "view" in content.lower()]

    return ValidationCheck(
        name="Thin View Principle",
        passed=len(violations) == 0,
        is_mandatory=True,
        message="⚠️ Business logic may be in views" if violations else "✅ Thin views maintained"
    )
```

#### C#/.NET Compliance Checklist

```python
def validate_dotnet_compliance(refinement_content: str) -> ComplianceResult:
    """
    Validates refinement against juntossomosmais .NET standards.

    Returns:
        ComplianceResult: Detailed compliance check for .NET projects
    """

    compliance_checks = {
        # Data Access Requirements (MANDATORY)
        'sqlcontext_injection': validate_sqlcontext_direct_injection(refinement_content),
        'no_tracking_queries': check_as_no_tracking_usage(refinement_content),
        'entity_framework': validate_entity_framework_patterns(refinement_content),

        # Testing Requirements (MANDATORY)
        'xunit_framework': check_xunit_usage(refinement_content),
        'fluent_assertions': validate_fluent_assertions(refinement_content),
        'test_categorization': check_test_categories(refinement_content),

        # API Requirements (IF API CHANGES)
        'controller_patterns': validate_controller_structure(refinement_content),
        'dependency_injection': check_di_container_usage(refinement_content),
        'swagger_documentation': validate_swagger_integration(refinement_content),

        # Code Quality (MANDATORY)
        'async_patterns': validate_async_await_patterns(refinement_content),
        'exception_handling': check_exception_handling_strategy(refinement_content),
        'logging_framework': validate_logging_configuration(refinement_content)
    }

    mandatory_failed = [check for check, result in compliance_checks.items()
                       if result.is_mandatory and not result.passed]

    if mandatory_failed:
        return ComplianceResult(
            status="BLOCKED",
            mandatory_failures=mandatory_failed,
            compliance_score=calculate_compliance_percentage(compliance_checks)
        )

    return ComplianceResult(
        status="APPROVED",
        warnings=extract_warnings(compliance_checks),
        compliance_score=calculate_compliance_percentage(compliance_checks)
    )

def validate_sqlcontext_direct_injection(content: str) -> ValidationCheck:
    """Ensures SqlContext is injected directly, not through repository pattern."""

    repository_pattern_indicators = [
        "IRepository",
        "Repository<",
        "GenericRepository",
        "BaseRepository"
    ]

    sqlcontext_patterns = [
        "SqlContext",
        "DbContext",
        "ApplicationDbContext"
    ]

    has_repository = any(pattern in content for pattern in repository_pattern_indicators)
    has_sqlcontext = any(pattern in content for pattern in sqlcontext_patterns)

    return ValidationCheck(
        name="SqlContext Direct Injection",
        passed=has_sqlcontext and not has_repository,
        is_mandatory=True,
        message="❌ Repository pattern detected" if has_repository else "✅ Direct SqlContext injection"
    )

def check_as_no_tracking_usage(content: str) -> ValidationCheck:
    """Validates .AsNoTracking() usage on read-only queries."""

    read_query_patterns = [
        "SELECT",
        "Where(",
        "FirstOrDefault",
        "ToList()",
        "read-only"
    ]

    no_tracking_usage = ".AsNoTracking()" in content
    has_read_queries = any(pattern in content for pattern in read_query_patterns)

    return ValidationCheck(
        name="AsNoTracking Usage",
        passed=not has_read_queries or no_tracking_usage,
        is_mandatory=True,
        message="⚠️ Read queries without .AsNoTracking()" if has_read_queries and not no_tracking_usage else "✅ Proper query tracking"
    )
```

### Phase 3: Generate Compliance Report

```python
def generate_compliance_report(
    compliance_result: ComplianceResult,
    refinement_path: str,
    repository: str
) -> ComplianceReport:
    """
    Generates final compliance report with actionable feedback.

    Returns:
        ComplianceReport: Complete validation results with next steps
    """

    if compliance_result.status == "APPROVED":
        return ComplianceReport(
            status="✅ APROVADO - Compliance R2-D2",
            summary=f"""
📋 Validação Completa - {repository}
• Score de Compliance: {compliance_result.compliance_score}%
• Padrões Organizacionais: ✅ Atendidos
• Refinement: Pronto para implementação

📄 Documento: {refinement_path}
🎯 Status: Aprovado para desenvolvimento
            """,
            next_steps=["Iniciar implementação conforme refinement",
                       "Seguir plano de testes documentado",
                       "Aplicar padrões organizacionais validados"]
        )

    else:  # BLOCKED
        return ComplianceReport(
            status="🚫 BLOQUEADO - Correções Necessárias",
            summary=f"""
❌ Falhas de Compliance R2-D2 - {repository}
• Score: {compliance_result.compliance_score}%  
• Problemas Críticos: {len(compliance_result.mandatory_failures)}

🔧 Correções Obrigatórias:
{format_mandatory_failures(compliance_result.mandatory_failures)}

⚠️ IMPLEMENTAÇÃO BLOQUEADA até correção de todas as falhas críticas.
            """,
            next_steps=["Corrigir falhas críticas listadas",
                       "Re-executar validação de compliance",
                       "Aguardar aprovação antes de implementar"]
        )
```

### Output Templates

#### Approval Template

```yaml
✅ COMPLIANCE R2-D2 APROVADO:

📊 Resultado da Validação:
• Repositório: {repository_name}
• Framework: {framework}  
• Score de Compliance: {compliance_score}%
• Padrões Validados: ✅ {validated_standards_count}

🎯 Refinement Aprovado:
• Documento: temp.md
• Testing Strategy: ✅ Conforme padrão juntossomosmais
• Code Quality: ✅ Atende r2-d2 standards  
• Architecture: ✅ Alinhado com convenções

🚀 Próximos Passos:
1. Salvar refinement no Monday.com
2. Iniciar implementação seguindo o plano
3. Aplicar testing strategy documentada
4. Manter compliance durante desenvolvimento

✅ WORKFLOW DE REFINEMENT COMPLETO
```

#### Blocked Template

```yaml
🚫 COMPLIANCE R2-D2 BLOQUEADO:

❌ Falhas Críticas Encontradas:
{detailed_mandatory_failures_list}

📊 Score de Compliance: {compliance_score}% (mínimo: 85%)

🔧 Correções Obrigatórias:
{step_by_step_correction_guide}

⚠️ BLOQUEIOS ATIVOS:
- Implementação não pode iniciar
- Refinement precisa ser corrigido
- Re-validação necessária após correções

📚 Referência: juntossomosmais/r2-d2 → {specific_rule_sections}
```

## Memory Documentation

```typescript
interface ComplianceMemory {
  repository_name: string;
  framework: string;
  compliance_status: 'APPROVED' | 'BLOCKED';
  compliance_score: number;
  validation_timestamp: string;
  mandatory_failures?: string[];
  warnings?: string[];
  r2d2_rules_version: string;
}

// Saved to: /memories/session/compliance_validation_results.md
```

## Integration Points  

- **Input:** Generated refinement document from monday-refinement-generator
- **Dependencies:** GitHub MCP (r2-d2 access), memory management, file operations
- **Output:** Compliance validation with approval/blocking decision
- **Memory:** Validation results for audit trail and workflow tracking
- **Quality Gate:** Final approval required before implementation can begin

## Anti-Patterns Prevention

```yaml
❌ COMPLIANCE VIOLATIONS (BLOCKING):
Python/Django:
- F-strings in logging statements
- Business logic in views  
- Missing authentication/authorization
- Incomplete testing strategy

C#/.NET:
- Repository pattern usage (use direct SqlContext)
- Missing .AsNoTracking() on read queries  
- Incomplete exception handling
- Missing test categorization

✅ ORGANIZATION ALIGNMENT:
- Testing follows juntossomosmais conventions
- Code quality meets r2-d2 standards
- Architecture aligns with approved patterns
- Documentation supports maintainability
```

---

**Skill Principle:** Enforce organizational standards as the final quality gate. Prevent technical debt by blocking non-compliant refinements before implementation begins.
