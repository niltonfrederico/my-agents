---

name: "pre-commit-validator"
description: "**PRE-COMMIT CODE VALIDATOR** — Specialized skill for validating generated code using pre-commit hooks without auto-fixing issues. USE FOR: code quality validation; linting verification; formatting compliance checking; security scan validation; commit readiness assessment; agent-generated code verification; CI/CD pipeline validation; development workflow quality gates. PROVIDES: comprehensive validation reports; detailed issue analysis; compliance status verification; actionable feedback for code improvement; integration with development workflows. JUNTOSSOMOSMAIS FOCUS: Validates Django/Python and .NET/C# code against company standards; integrates with existing pre-commit configurations; supports multiple code quality tools (black, mypy, flake8, eslint, etc.); ensures StandardModelMixin and StandardEntity pattern compliance."

---

# Pre-Commit Code Validator Skill

*Quality validation for agent-generated code using pre-commit hooks*

## Purpose

This skill provides comprehensive code quality validation using pre-commit hooks to verify that agent-generated code meets project standards before finalization. Unlike auto-fixing tools, this skill focuses on validation and reporting, helping development agents understand and improve their code generation processes.

## CRITICAL REQUIREMENTS (March 2026 Anti-Hallucination)

### STOP Conditions (MANDATORY)

```python
# When pre-commit configuration is missing, STOP and ask user
if not pre_commit_config_exists():
    raise SkillExecutionStop(
        reason="PRE_COMMIT_CONFIG_MISSING",
        message="🚫 STOP: Configuração .pre-commit-config.yaml não encontrada.\n\n❓ Configurar pre-commit primeiro ou validar sem hooks?",
        user_action_required=True
    )

# When validation tools are unavailable, STOP and ask user
if validation_tools_unavailable():
    questions = [{
        "header": "validation_approach",
        "question": "🔧 Ferramentas de validação indisponíveis. Como proceder?",
        "options": [
            {"label": "Instalar dependências necessárias", "value": "install_deps"},
            {"label": "Validação básica apenas", "value": "basic_validation"},
            {"label": "Pular validação (não recomendado)", "value": "skip_validation"}
        ]
    }]
    user_response = vscode_askQuestions(questions)
    validation_approach = user_response["validation_approach"]

# When validation fails critically, STOP and ask for guidance  
if critical_validation_failures():
    raise SkillExecutionStop(
        reason="CRITICAL_VALIDATION_FAILED",
        message="🚫 STOP: Validação encontrou erros críticos que impedem commit.\n\n❓ Corrigir erros automaticamente ou revisar manualmente?",
        user_action_required=True
    )
```

### MCP-First Pattern (MANDATORY)

- **USE mcp_io_github_git_get_file_contents** for repository file access when needed
- **NO assumptions** about project structure without verification

## Core Capabilities

### Validation Workflow

- **Changed Files Detection**: Automatically identifies modified files requiring validation
- **Selective Validation**: Runs pre-commit hooks only on changed/generated files for efficiency
- **Comprehensive Reporting**: Detailed analysis of validation results with actionable feedback
- **Multi-Language Support**: Validates Python, C#, JavaScript/TypeScript, and configuration files
- **Integration Ready**: Designed to work within agent workflows without disrupting development

### Pre-Commit Integration

- **Hook Execution**: Runs existing pre-commit configurations without modification
- **Custom Hook Support**: Handles project-specific hooks and custom validation rules
- **Tool Chain Integration**: Supports black, mypy, flake8, eslint, prettier, and security scanners
- **Configuration Detection**: Auto-discovers `.pre-commit-config.yaml` and project settings
- **Environment Handling**: Works with virtual environments and project-specific setups

### Validation Reporting

- **Issue Categorization**: Groups validation issues by type (formatting, linting, security, etc.)
- **Severity Assessment**: Prioritizes issues by impact and urgency
- **Fix Guidance**: Provides specific guidance for resolving validation failures
- **Success Confirmation**: Clear reporting when code passes all validation checks
- **Integration Metrics**: Tracks validation success rates and common issue patterns

## Validation Functions

### Core Validation Workflow

```python
async def validate_generated_code(
    changed_files: list[str] = None,
    validation_scope: str = "changed",
    report_format: str = "detailed"
) -> PreCommitValidationResult:
    """
    Master validation function for agent-generated code.

    Args:
        changed_files: Specific files to validate (auto-detected if None)
        validation_scope: "changed" | "staged" | "all" | "specific"  
        report_format: "summary" | "detailed" | "json" | "integration"

    Returns:
        PreCommitValidationResult: Comprehensive validation analysis
    """

    # Step 1: Detect files requiring validation
    files_to_validate = await detect_validation_targets(changed_files, validation_scope)

    if not files_to_validate:
        return PreCommitValidationResult(
            status="no_changes",
            message="No files require validation",
            files_validated=[]
        )

    # Step 2: Discover and validate pre-commit configuration
    precommit_config = await discover_precommit_configuration()

    if not precommit_config.exists:
        return handle_missing_precommit_config(files_to_validate)

    # Step 3: Execute pre-commit validation
    validation_results = await execute_precommit_validation(
        files=files_to_validate,
        config=precommit_config
    )

    # Step 4: Analyze and categorize results
    analysis = await analyze_validation_results(validation_results)

    # Step 5: Generate comprehensive report
    report = await generate_validation_report(analysis, report_format)

    return PreCommitValidationResult(
        status=analysis.overall_status,
        files_validated=files_to_validate,
        validation_summary=analysis.summary,
        detailed_results=analysis.by_hook,
        recommendations=analysis.recommendations,
        report=report
    )

async def detect_validation_targets(
    specified_files: list[str],
    scope: str
) -> list[str]:
    """
    Intelligently detect which files need validation.

    Args:
        specified_files: Explicitly provided file paths
        scope: Validation scope strategy

    Returns:
        list[str]: Files requiring validation
    """

    if specified_files:
        return filter_valid_files(specified_files)

    if scope == "changed":
        # Get files modified but not committed
        changed_files = await get_git_changed_files(include_untracked=True)
        return filter_supported_files(changed_files)

    elif scope == "staged":
        # Get files staged for commit
        staged_files = await get_git_staged_files()
        return filter_supported_files(staged_files)

    elif scope == "all":
        # Validate entire project (careful - can be slow)
        all_files = await discover_project_files()
        return filter_supported_files(all_files)

    else:
        raise ValueError(f"Unsupported validation scope: {scope}")

async def execute_precommit_validation(
    files: list[str],
    config: PreCommitConfig
) -> PreCommitRawResults:
    """
    Execute pre-commit hooks on specified files.

    Args:
        files: List of file paths to validate
        config: Pre-commit configuration details

    Returns:
        PreCommitRawResults: Raw output from pre-commit execution
    """

    # Prepare file list for pre-commit
    files_arg = " ".join(shlex.quote(f) for f in files)

    # Execute pre-commit with proper error handling
    try:
        # Run pre-commit on specific files
        result = await run_command_with_capture(
            f"pre-commit run --files {files_arg}",
            timeout=300,  # 5 minute timeout
            capture_output=True
        )

        return PreCommitRawResults(
            exit_code=result.exit_code,
            stdout=result.stdout,
            stderr=result.stderr,
            execution_time=result.duration,
            files_processed=files
        )

    except CommandTimeoutError:
        return PreCommitRawResults(
            exit_code=124,  # Timeout exit code
            stdout="",
            stderr="Pre-commit validation timed out after 5 minutes",
            execution_time=300.0,
            files_processed=files
        )

    except Exception as e:
        return PreCommitRawResults(
            exit_code=1,
            stdout="",
            stderr=f"Pre-commit execution failed: {str(e)}",
            execution_time=0.0,
            files_processed=files
        )
```

### Results Analysis & Categorization

```python
async def analyze_validation_results(
    raw_results: PreCommitRawResults
) -> ValidationAnalysis:
    """
    Parse and categorize pre-commit validation results.

    Args:
        raw_results: Raw pre-commit execution output

    Returns:
        ValidationAnalysis: Structured analysis of validation results
    """

    if raw_results.exit_code == 0:
        return ValidationAnalysis(
            overall_status="passed",
            summary=ValidationSummary(
                total_files=len(raw_results.files_processed),
                passed_hooks=0,  # Will be calculated
                failed_hooks=0,
                skipped_hooks=0,
                total_issues=0
            ),
            by_hook=[],
            recommendations=["All validation checks passed successfully!"]
        )

    # Parse pre-commit output to extract hook results
    hook_results = parse_precommit_output(raw_results.stdout, raw_results.stderr)

    # Categorize issues by type and severity
    categorized_issues = categorize_validation_issues(hook_results)

    # Generate recommendations based on issue patterns
    recommendations = generate_fix_recommendations(categorized_issues)

    # Calculate summary statistics
    summary = ValidationSummary(
        total_files=len(raw_results.files_processed),
        passed_hooks=len([h for h in hook_results if h.status == "passed"]),
        failed_hooks=len([h for h in hook_results if h.status == "failed"]),
        skipped_hooks=len([h for h in hook_results if h.status == "skipped"]),
        total_issues=sum(len(h.issues) for h in hook_results)
    )

    overall_status = "failed" if summary.failed_hooks > 0 else "passed"

    return ValidationAnalysis(
        overall_status=overall_status,
        summary=summary,
        by_hook=categorized_issues,
        recommendations=recommendations
    )

def parse_precommit_output(stdout: str, stderr: str) -> list[HookResult]:
    """
    Parse pre-commit command output into structured results.

    Args:
        stdout: Standard output from pre-commit command
        stderr: Standard error from pre-commit command  

    Returns:
        list[HookResult]: Parsed results for each hook
    """

    hook_results = []
    current_hook = None

    # Pre-commit output patterns
    hook_start_pattern = re.compile(r"^([^.]+)\.+(\w+)$")
    file_issue_pattern = re.compile(r"^(.+?):(\d+):(\d+):\s*(.+)$")

    lines = (stdout + stderr).split('\n')

    for line in lines:
        line = line.strip()

        # Match hook execution line (e.g., "black....Passed" or "mypy....Failed")
        hook_match = hook_start_pattern.match(line)
        if hook_match:
            if current_hook:
                hook_results.append(current_hook)

            hook_name = hook_match.group(1).strip()
            status = hook_match.group(2).lower()

            current_hook = HookResult(
                name=hook_name,
                status=status,
                issues=[]
            )
            continue

        # Match file-specific issues
        if current_hook and current_hook.status == "failed":
            issue_match = file_issue_pattern.match(line)
            if issue_match:
                issue = ValidationIssue(
                    file_path=issue_match.group(1),
                    line_number=int(issue_match.group(2)),
                    column_number=int(issue_match.group(3)) if issue_match.group(3) else None,
                    message=issue_match.group(4),
                    hook_name=current_hook.name
                )
                current_hook.issues.append(issue)

    # Add final hook if exists
    if current_hook:
        hook_results.append(current_hook)

    return hook_results

def categorize_validation_issues(hook_results: list[HookResult]) -> list[HookCategory]:
    """
    Categorize validation issues by type and severity for better reporting.

    Args:
        hook_results: Raw hook execution results

    Returns:
        list[HookCategory]: Issues organized by category
    """

    categories = []

    for hook in hook_results:
        if hook.status == "passed":
            categories.append(HookCategory(
                name=hook.name,
                status="passed",
                category=categorize_hook_type(hook.name),
                issue_count=0,
                issues=[],
                severity="info"
            ))
        else:
            severity = assess_hook_severity(hook.name, hook.issues)

            categories.append(HookCategory(
                name=hook.name,
                status=hook.status,
                category=categorize_hook_type(hook.name),
                issue_count=len(hook.issues),
                issues=hook.issues,
                severity=severity
            ))

    return categories

def categorize_hook_type(hook_name: str) -> str:
    """
    Determine the category of a pre-commit hook.

    Args:
        hook_name: Name of the pre-commit hook

    Returns:
        str: Category classification
    """

    formatting_hooks = ["black", "prettier", "autopep8", "isort", "whitespace"]
    linting_hooks = ["flake8", "pylint", "eslint", "mypy", "pyright"]  
    security_hooks = ["bandit", "safety", "semgrep", "security"]
    testing_hooks = ["pytest", "jest", "test"]
    documentation_hooks = ["markdown", "docs", "spelling"]

    hook_lower = hook_name.lower()

    if any(fmt in hook_lower for fmt in formatting_hooks):
        return "formatting"
    elif any(lint in hook_lower for lint in linting_hooks):
        return "linting"
    elif any(sec in hook_lower for sec in security_hooks):
        return "security"
    elif any(test in hook_lower for test in testing_hooks):
        return "testing"
    elif any(doc in hook_lower for doc in documentation_hooks):
        return "documentation"
    else:
        return "other"

def generate_fix_recommendations(categorized_issues: list[HookCategory]) -> list[str]:
    """
    Generate actionable recommendations for fixing validation issues.

    Args:
        categorized_issues: Categorized validation results

    Returns:
        list[str]: Specific recommendations for resolution
    """

    recommendations = []
    failed_categories = [cat for cat in categorized_issues if cat.status == "failed"]

    if not failed_categories:
        recommendations.append("✅ All pre-commit hooks passed! Code is ready for commit.")
        return recommendations

    # Group recommendations by category
    formatting_issues = [cat for cat in failed_categories if cat.category == "formatting"]
    linting_issues = [cat for cat in failed_categories if cat.category == "linting"]
    security_issues = [cat for cat in failed_categories if cat.category == "security"]

    # Formatting recommendations
    if formatting_issues:
        recommendations.append("🎨 **Formatting Issues Detected:**")
        for issue_cat in formatting_issues:
            if "black" in issue_cat.name.lower():
                recommendations.append(f"   • Run `black {' '.join(get_affected_files(issue_cat))}` to fix formatting")
            elif "isort" in issue_cat.name.lower():
                recommendations.append(f"   • Run `isort {' '.join(get_affected_files(issue_cat))}` to fix imports")
            else:
                recommendations.append(f"   • Fix {issue_cat.name} formatting issues in {issue_cat.issue_count} location(s)")

    # Linting recommendations  
    if linting_issues:
        recommendations.append("🔍 **Linting Issues Detected:**")
        for issue_cat in linting_issues:
            recommendations.append(f"   • Review and fix {issue_cat.issue_count} {issue_cat.name} issue(s)")
            # Add specific issue details for critical linting problems
            critical_issues = [issue for issue in issue_cat.issues if is_critical_linting_issue(issue)]
            for issue in critical_issues[:3]:  # Show first 3 critical issues
                recommendations.append(f"     - {issue.file_path}:{issue.line_number}: {issue.message}")

    # Security recommendations (highest priority)
    if security_issues:
        recommendations.insert(0, "🚨 **Security Issues Detected (Priority: HIGH):**")
        for issue_cat in security_issues:
            recommendations.insert(1, f"   • URGENT: Address {issue_cat.issue_count} security issue(s) in {issue_cat.name}")

    # General recommendations
    recommendations.append("")
    recommendations.append("💡 **General Recommendations:**")
    recommendations.append("   • Run `pre-commit run --all-files` to validate entire codebase")
    recommendations.append("   • Consider running `pre-commit install` to enable automatic validation")
    recommendations.append("   • Review pre-commit configuration in `.pre-commit-config.yaml`")

    return recommendations
```

## Integration Patterns

### For Django Development Agent

```python
# Integration within django-dev workflow
class DjangoCodeValidator:
    """
    Django-specific integration with pre-commit validation.
    """

    async def validate_django_code_generation(
        self,
        generated_files: list[str],
        validation_context: str = "django_development"
    ) -> DjangoValidationResult:
        """
        Validate Django code using pre-commit with Django-specific checks.

        Args:
            generated_files: List of files generated by django-dev agent
            validation_context: Context for specialized validation

        Returns:
            DjangoValidationResult: Django-focused validation results
        """

        # Execute pre-commit validation  
        validation_result = await validate_generated_code(
            changed_files=generated_files,
            validation_scope="specific",
            report_format="detailed"
        )

        # Add Django-specific analysis
        django_analysis = await analyze_django_specific_issues(
            validation_result,
            generated_files
        )

        return DjangoValidationResult(
            precommit_results=validation_result,
            django_specific=django_analysis,
            recommendations=merge_recommendations(
                validation_result.recommendations,
                django_analysis.recommendations
            )
        )

    async def analyze_django_specific_issues(
        self,
        validation_result: PreCommitValidationResult,
        django_files: list[str]
    ) -> DjangoSpecificAnalysis:
        """
        Analyze validation results for Django-specific patterns.
        """

        django_issues = []

        # Check for StandardModelMixin compliance
        model_files = [f for f in django_files if "models.py" in f]
        for model_file in model_files:
            model_issues = await validate_standard_model_mixin_usage(model_file)
            django_issues.extend(model_issues)

        # Check DRF serializer patterns
        serializer_files = [f for f in django_files if "serializers.py" in f]
        for serializer_file in serializer_files:
            serializer_issues = await validate_drf_serializer_patterns(serializer_file)
            django_issues.extend(serializer_issues)

        return DjangoSpecificAnalysis(
            django_issues=django_issues,
            compliance_status="compliant" if not django_issues else "issues_found",
            recommendations=generate_django_recommendations(django_issues)
        )

# Usage in django-dev agent workflow
async def django_dev_code_generation_with_validation():
    """
    Example of integrating validation into django-dev workflow.
    """

    # 1. Generate Django code (models, views, serializers, etc.)
    generated_files = await generate_django_components()

    # 2. Validate generated code
    validation_result = await DjangoCodeValidator().validate_django_code_generation(
        generated_files=generated_files,
        validation_context="model_and_api_generation"  
    )

    # 3. Report validation status
    if validation_result.precommit_results.status == "passed":
        return SuccessResult(
            message="✅ Django code generated and validated successfully!",
            files_created=generated_files,
            validation_summary=validation_result.precommit_results.validation_summary
        )
    else:
        return ValidationFailureResult(
            message="⚠️ Generated code has validation issues that need attention:",
            files_created=generated_files,
            issues=validation_result.precommit_results.detailed_results,
            recommendations=validation_result.recommendations
        )
```

### For .NET Development Agent

```python
# Integration within dotnet-dev workflow
class DotNetCodeValidator:
    """
    .NET-specific integration with pre-commit validation.
    """

    async def validate_dotnet_code_generation(
        self,
        generated_files: list[str],
        validation_context: str = "dotnet_development"
    ) -> DotNetValidationResult:
        """
        Validate .NET code using pre-commit with .NET-specific checks.

        Args:
            generated_files: List of files generated by dotnet-dev agent
            validation_context: Context for specialized validation

        Returns:
            DotNetValidationResult: .NET-focused validation results
        """

        # Execute pre-commit validation
        validation_result = await validate_generated_code(
            changed_files=generated_files,
            validation_scope="specific",
            report_format="detailed"
        )

        # Add .NET-specific analysis
        dotnet_analysis = await analyze_dotnet_specific_issues(
            validation_result,
            generated_files
        )

        return DotNetValidationResult(
            precommit_results=validation_result,
            dotnet_specific=dotnet_analysis,
            recommendations=merge_recommendations(
                validation_result.recommendations,
                dotnet_analysis.recommendations
            )
        )

    async def analyze_dotnet_specific_issues(
        self,
        validation_result: PreCommitValidationResult,
        dotnet_files: list[str]
    ) -> DotNetSpecificAnalysis:
        """
        Analyze validation results for .NET-specific patterns.
        """

        dotnet_issues = []

        # Check for StandardEntity compliance
        entity_files = [f for f in dotnet_files if f.endswith(".cs") and "Entities" in f]
        for entity_file in entity_files:
            entity_issues = await validate_standard_entity_usage(entity_file)
            dotnet_issues.extend(entity_issues)

        # Check CliFx command patterns
        command_files = [f for f in dotnet_files if "Command" in f and f.endswith(".cs")]
        for command_file in command_files:
            command_issues = await validate_clifx_command_patterns(command_file)
            dotnet_issues.extend(command_issues)

        return DotNetSpecificAnalysis(
            dotnet_issues=dotnet_issues,
            compliance_status="compliant" if not dotnet_issues else "issues_found",
            recommendations=generate_dotnet_recommendations(dotnet_issues)
        )
```

## Specialized Validation Functions

### Git Integration Functions

```python
async def get_git_changed_files(include_untracked: bool = True) -> list[str]:
    """
    Get list of files that have been modified in the current Git repository.

    Args:
        include_untracked: Whether to include untracked files

    Returns:
        list[str]: List of modified file paths
    """

    # Get modified files (tracked)
    modified_result = await run_command_with_capture("git diff --name-only")
    modified_files = modified_result.stdout.strip().split('\n') if modified_result.stdout.strip() else []

    # Get staged files
    staged_result = await run_command_with_capture("git diff --cached --name-only")
    staged_files = staged_result.stdout.strip().split('\n') if staged_result.stdout.strip() else []

    # Combine and deduplicate
    changed_files = list(set(modified_files + staged_files))

    # Add untracked files if requested
    if include_untracked:
        untracked_result = await run_command_with_capture("git ls-files --others --exclude-standard")
        untracked_files = untracked_result.stdout.strip().split('\n') if untracked_result.stdout.strip() else []
        changed_files.extend(untracked_files)

    # Filter out empty strings and ensure files exist
    valid_files = []
    for file_path in changed_files:
        if file_path and os.path.exists(file_path):
            valid_files.append(file_path)

    return valid_files

async def discover_precommit_configuration() -> PreCommitConfig:
    """
    Discover and analyze pre-commit configuration in the current project.

    Returns:
        PreCommitConfig: Configuration details and hook information
    """

    config_paths = [
        ".pre-commit-config.yaml",
        ".pre-commit-config.yml",
        ".github/.pre-commit-config.yaml"
    ]

    config_file = None
    for path in config_paths:
        if os.path.exists(path):
            config_file = path
            break

    if not config_file:
        return PreCommitConfig(
            exists=False,
            config_file=None,
            hooks=[],
            python_version=None
        )

    # Parse YAML configuration
    with open(config_file, 'r') as f:
        config_data = yaml.safe_load(f)

    # Extract hook information
    hooks = []
    for repo in config_data.get('repos', []):
        for hook in repo.get('hooks', []):
            hooks.append(PreCommitHook(
                id=hook['id'],
                name=hook.get('name', hook['id']),
                language=hook.get('language', 'unknown'),
                files=hook.get('files', '.*'),
                types=hook.get('types', [])
            ))

    return PreCommitConfig(
        exists=True,
        config_file=config_file,
        hooks=hooks,
        python_version=config_data.get('python', None)
    )
```

## Usage Examples

### Basic Validation

```python
# Validate all changed files
validation_result = await validate_generated_code()

if validation_result.status == "passed":
    print("✅ All validation checks passed!")
else:
    print(f"❌ Validation failed with {validation_result.validation_summary.total_issues} issues")
    for recommendation in validation_result.recommendations:
        print(f"   {recommendation}")
```

### Specific File Validation

```python
# Validate specific files generated by an agent
generated_files = [
    "src/models.py",
    "src/serializers.py",
    "src/views.py"
]

validation_result = await validate_generated_code(
    changed_files=generated_files,
    validation_scope="specific",
    report_format="detailed"  
)

print(f"Validated {len(generated_files)} files")
print(f"Status: {validation_result.status}")
print(f"Issues found: {validation_result.validation_summary.total_issues}")
```

### Integration with Development Workflow

```python
# Example integration in a development agent
async def create_django_api_with_validation():
    """
    Create Django API components with automatic validation.
    """

    # 1. Generate Django components
    generated_files = []

    # Create model
    model_file = await create_django_model("User", fields=user_fields)
    generated_files.append(model_file)

    # Create serializer
    serializer_file = await create_drf_serializer("UserSerializer", model="User")
    generated_files.append(serializer_file)

    # Create viewset
    viewset_file = await create_drf_viewset("UserViewSet", serializer="UserSerializer")
    generated_files.append(viewset_file)

    # 2. Validate generated code
    validation_result = await validate_generated_code(
        changed_files=generated_files,
        validation_scope="specific"
    )

    # 3. Report results
    if validation_result.status == "passed":
        return {
            "success": True,
            "message": "Django API created and validated successfully!",
            "files": generated_files,
            "validation": validation_result.validation_summary
        }
    else:
        return {
            "success": False,  
            "message": "Generated code requires attention before finalization",
            "files": generated_files,
            "issues": validation_result.detailed_results,
            "recommendations": validation_result.recommendations
        }
```

## Data Models

```python
from dataclasses import dataclass
from typing import Optional, List
from enum import Enum

@dataclass
class ValidationIssue:
    file_path: str
    line_number: int
    column_number: Optional[int]
    message: str
    hook_name: str
    severity: str = "warning"

@dataclass
class HookResult:
    name: str
    status: str  # "passed", "failed", "skipped"
    issues: List[ValidationIssue]

@dataclass
class HookCategory:
    name: str
    status: str
    category: str  # "formatting", "linting", "security", etc.
    issue_count: int
    issues: List[ValidationIssue]
    severity: str

@dataclass
class ValidationSummary:
    total_files: int
    passed_hooks: int
    failed_hooks: int
    skipped_hooks: int
    total_issues: int

@dataclass
class ValidationAnalysis:
    overall_status: str
    summary: ValidationSummary
    by_hook: List[HookCategory]
    recommendations: List[str]

@dataclass
class PreCommitValidationResult:
    status: str
    files_validated: List[str]
    validation_summary: ValidationSummary
    detailed_results: List[HookCategory]
    recommendations: List[str]

@dataclass
class PreCommitConfig:
    exists: bool
    config_file: Optional[str]
    hooks: List['PreCommitHook']
    python_version: Optional[str]

@dataclass
class PreCommitHook:
    id: str
    name: str
    language: str
    files: str
    types: List[str]
```

## Best Practices

### Integration Guidelines

1. **Non-Destructive Validation**: Never automatically fix code - only report issues
2. **Context-Aware**: Provide recommendations specific to the detected issues
3. **Agent Integration**: Designed to work seamlessly with development agent workflows
4. **Performance Focused**: Validate only changed files for efficiency
5. **Comprehensive Reporting**: Detailed analysis with actionable suggestions

### Error Handling

- **Missing Configuration**: Gracefully handle projects without pre-commit setup
- **Tool Dependencies**: Clear messaging when required tools are not installed
- **Timeout Protection**: Prevent validation from hanging on large codebases
- **Environment Issues**: Robust handling of virtual environment and path issues

### Quality Assurance

- **Validation Accuracy**: Ensure validation results accurately reflect code quality
- **False Positive Management**: Minimize and clearly identify potential false positives
- **Integration Testing**: Verify compatibility with existing development workflows
- **Performance Monitoring**: Track validation execution time and optimize accordingly

This pre-commit validation skill provides development agents with reliable, comprehensive code quality validation without the complexity of automatic fixing, enabling better code generation processes and ensuring compliance with project standards.
