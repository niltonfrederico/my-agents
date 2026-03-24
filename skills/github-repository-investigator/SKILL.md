---
skill: true
name: "github-repository-investigator"
description: "**GITHUB REPOSITORY INVESTIGATOR** — Shared utility for discovering real application architecture using GitHub API. USE FOR: repository structure discovery; framework detection; file path verification; dependency mapping; architecture validation. PREVENTS: imaginary file paths; invented services; invalid assumptions. PROVIDES: real GitHub investigation patterns; framework detection utilities; architecture discovery functions. JUNTOSSOMOSMAIS FOCUS: Django/Python and .NET/C# specialization; proven investigation patterns from March 2026 lessons."
applyTo:
  - "**/*github*/**" 
  - "**/*repository*/**"
  - "**/*architecture*/**"
invokes:
  - "github.com"
  - "memory"
---

# GitHub Repository Investigator Skill

## Overview

**SHARED INVESTIGATION UTILITY:** Provides real GitHub API investigation patterns used across multiple Monday.com workflow skills. Prevents imaginary assumptions by verifying actual repository structure.

## Core Investigation Functions

### Repository Structure Discovery

```python
def investigate_repository_structure(repository_name: str) -> RepositoryAnalysis:
    """
    Master function for discovering real repository architecture.
    
    Args:
        repository_name: Explicitly confirmed repository (e.g., 'juntossomosmais/delfos')
        
    Returns:
        RepositoryAnalysis: Comprehensive structure with verified paths only
    """
    
    # Step 1: Verify repository exists
    try:
        repo_info = github_get_repository_info(repository_name)
    except RepositoryNotFound:
        return RepositoryAnalysis(
            status="ERROR", 
            message=f"Repositório {repository_name} não encontrado ou inacessível"
        )
    
    # Step 2: Investigate root structure 
    root_structure = github_get_directory_contents(repository_name, "/")
    
    # Step 3: Detect framework using proven patterns
    framework = detect_framework_from_structure(root_structure)
    
    # Step 4: Framework-specific architecture discovery
    architecture = investigate_framework_architecture(repository_name, framework, root_structure)
    
    return RepositoryAnalysis(
        repository=repository_name,
        framework=framework,
        root_structure=root_structure,
        architecture=architecture,
        investigation_timestamp=datetime.now(),
        real_paths_verified=True  # NEVER invented paths
    )

def detect_framework_from_structure(root_structure: list[GitHubFile]) -> FrameworkInfo:
    """
    Detects framework using proven indicators from March 2026.
    
    Returns:
        FrameworkInfo: Framework type with confidence level
    """
    
    file_names = [file.name.lower() for file in root_structure]
    
    # Proven detection patterns (March 2026)
    framework_indicators = {
        'django': {
            'required': ['manage.py'],
            'common': ['settings.py', 'wsgi.py', 'urls.py'],
            'confidence_boost': ['requirements.txt', 'requirements/']
        },
        'dotnet': {
            'required': ['*.sln', '*.csproj'],
            'common': ['program.cs', 'startup.cs'],
            'confidence_boost': ['appsettings.json', 'controllers/']
        },
        'nodejs': {
            'required': ['package.json'],
            'common': ['server.js', 'app.js', 'index.js'],
            'confidence_boost': ['node_modules/', 'src/']
        },
        'react': {
            'required': ['package.json'],
            'common': ['src/app.js', 'public/index.html'],
            'confidence_boost': ['src/components/', 'public/']
        }
    }
    
    detected_frameworks = []
    
    for framework, indicators in framework_indicators.items():
        confidence = 0
        
        # Check required files (high confidence)
        required_matches = sum(1 for req in indicators['required'] 
                             if any(req.replace('*', '') in fname for fname in file_names))
        if required_matches > 0:
            confidence += 50
        
        # Check common files (medium confidence)  
        common_matches = sum(1 for common in indicators['common']
                           if common in file_names)
        confidence += common_matches * 15
        
        # Check confidence boosters (low confidence)
        boost_matches = sum(1 for boost in indicators['confidence_boost']
                          if boost in file_names)
        confidence += boost_matches * 10
        
        if confidence >= 50:  # Minimum threshold
            detected_frameworks.append(FrameworkInfo(framework, confidence))
    
    if detected_frameworks:
        # Return highest confidence framework  
        best_framework = max(detected_frameworks, key=lambda x: x.confidence)
        return best_framework
    
    return FrameworkInfo('unknown', 0)
```

### Juntossomosmais Architecture Patterns

```python
def investigate_django_architecture(
    repository_name: str, 
    root_structure: list[GitHubFile]
) -> DjangoArchitecture:
    """
    Specialized Django investigation using juntossomosmais patterns.
    
    Uses proven paths from delfos, vitrine, catalog repositories.
    """
    
    # Extract app name from repository structure
    app_name = extract_django_app_name(root_structure)
    
    # Proven investigation paths for juntossomosmais Django projects
    investigation_paths = {
        'core_api': f"{app_name}/core/api/v1/",
        'models': f"{app_name}/core/models.py", 
        'enums': f"{app_name}/core/enums.py",
        'use_cases': f"{app_name}/core/use_cases/",
        'health_checks': f"{app_name}/core/health/",
        'integration_tests': "tests/integration/api/",
        'requirements': "requirements/",
        'docker_compose': "docker-compose.yml",
        'settings': f"{app_name}/settings/"
    }
    
    # Investigate each path via GitHub API
    architecture_components = {}
    for component, path in investigation_paths.items():
        try:
            if path.endswith('.py'):
                # Single file
                content = github_get_file_content(repository_name, path)
                architecture_components[component] = FileInfo(path, exists=True, content_preview=content[:500])
            else:
                # Directory
                content = github_get_directory_contents(repository_name, path)
                architecture_components[component] = DirectoryInfo(path, exists=True, file_count=len(content))
        except (FileNotFound, DirectoryNotFound):
            architecture_components[component] = ComponentInfo(path, exists=False)
    
    return DjangoArchitecture(
        app_name=app_name,
        components=architecture_components,
        django_version=detect_django_version(architecture_components.get('requirements')),
        api_endpoints=extract_api_endpoints(architecture_components.get('core_api')),
        uses_standard_model_mixin=check_standard_model_mixin(architecture_components.get('models'))
    )

def investigate_dotnet_architecture(
    repository_name: str,
    root_structure: list[GitHubFile]
) -> DotNetArchitecture:
    """
    Specialized .NET investigation using juntossomosmais patterns.
    
    Uses proven patterns from .NET template and production applications.
    """
    
    investigation_paths = {
        'solution': "*.sln",
        'projects': "src/",
        'controllers': "Controllers/",
        'models': "Models/",
        'services': "Services/",
        'data': "Data/",
        'tests': "Tests/",
        'program': "Program.cs",
        'settings': "appsettings.json"
    }
    
    architecture_components = {}
    for component, path in investigation_paths.items():
        try:
            if path.startswith('*'):
                # Pattern search
                matching_files = github_search_files(repository_name, path)
                architecture_components[component] = PatternMatch(path, matches=matching_files)
            elif path.endswith('.json') or path.endswith('.cs'):
                # Single file
                content = github_get_file_content(repository_name, path)
                architecture_components[component] = FileInfo(path, exists=True, content_preview=content[:500])
            else:
                # Directory
                content = github_get_directory_contents(repository_name, path)
                architecture_components[component] = DirectoryInfo(path, exists=True, file_count=len(content))
        except (FileNotFound, DirectoryNotFound, PatternNotFound):
            architecture_components[component] = ComponentInfo(path, exists=False)
    
    return DotNetArchitecture(
        solution_files=architecture_components.get('solution'),
        project_structure=architecture_components.get('projects'),
        controllers=architecture_components.get('controllers'),
        models=architecture_components.get('models'),
        services=architecture_components.get('services'),
        data_layer=architecture_components.get('data'),
        dotnet_version=detect_dotnet_version(architecture_components.get('program'))
    )
```

### Anti-Pattern Prevention

```python
def validate_investigation_results(analysis: RepositoryAnalysis) -> InvestigationValidation:
    """
    Validates investigation results to prevent March 2026 error patterns.
    
    Returns:
        InvestigationValidation: Confirmation that no assumptions were made
    """
    
    validation_checks = {
        'no_invented_paths': verify_no_invented_paths(analysis),
        'real_api_verification': verify_real_api_responses(analysis), 
        'framework_confidence': verify_framework_confidence(analysis),
        'architecture_completeness': verify_architecture_completeness(analysis)
    }
    
    failed_checks = [check for check, passed in validation_checks.items() if not passed]
    
    if failed_checks:
        return InvestigationValidation(
            status="INVALID",
            message=f"Investigation failed checks: {', '.join(failed_checks)}",
            safe_to_use=False
        )
    
    return InvestigationValidation(
        status="VERIFIED", 
        message="Investigation results verified - no assumptions made",
        safe_to_use=True,
        architecture_confidence=analysis.framework.confidence
    )

# March 2026 Anti-Patterns (NEVER DO)
FORBIDDEN_PATTERNS = [
    "assume_repository_structure",
    "invent_file_paths", 
    "guess_api_endpoints",
    "create_imaginary_services",
    "proceed_without_verification"
]
```

## Memory Integration

```python
def save_investigation_memory(
    repository_name: str,
    analysis: RepositoryAnalysis
) -> str:
    """
    Saves investigation results to repository memory for reuse.
    
    Returns:
        str: Path to saved memory file
    """
    
    memory_content = {
        'repository': repository_name,
        'framework': analysis.framework.name,
        'confidence': analysis.framework.confidence,
        'structure': analysis.root_structure,
        'architecture': analysis.architecture,
        'investigation_date': analysis.investigation_timestamp.isoformat(),
        'verified_real_paths': True,
        'safe_for_refinement': analysis.validation.safe_to_use
    }
    
    memory_path = f"/memories/repo/{repository_name.replace('/', '_')}_investigation.md"
    save_memory(memory_path, memory_content)
    
    return memory_path
```

## Integration Points

- **Used by:** monday-task-analyzer, r2d2-compliance-validator
- **Provides:** Real repository structure, framework detection, architecture mapping
- **Prevents:** Imaginary assumptions, invalid file paths, invented services  
- **Memory:** Saves investigation results for reuse across skills

---

**Investigation Principle:** Only report what can be verified through GitHub API. Never assume, never invent, never guess. All paths must be real and confirmed.