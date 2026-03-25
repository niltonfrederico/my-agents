---

name: "library-checker"
description: "**JUNTOSSOMOSMAIS LIBRARY VALIDATOR** — Specialized skill for validating Python dependencies against juntossomosmais/allowed-libraries repository and company security policies. USE FOR: dependency validation; security compliance checking; library approval verification; vulnerability assessment; license compliance; version compatibility checking; dependency upgrade planning; security policy enforcement. PROVIDES: approval status verification; security vulnerability reports; license compliance analysis; version compatibility matrix; dependency recommendations; upgrade pathways. JUNTOSSOMOSMAIS FOCUS: Integration with juntossomosmais/allowed-libraries repository, company security policies, approved Django/Python package validation, STOMP messaging library compliance, and DRF ecosystem compatibility."

---

# juntossomosmais Library Validator Skill

*Comprehensive dependency validation against company security policies and approved libraries*

## Purpose

This skill validates Python dependencies against juntossomosmais security policies and the approved libraries repository, ensuring compliance with company standards and security requirements. Provides comprehensive analysis of dependencies, vulnerabilities, and upgrade paths.

## Core Capabilities

### Dependency Validation

- **Approval Status**: Check against juntossomosmais/allowed-libraries repository
- **Security Compliance**: Vulnerability scanning and security policy validation
- **License Compliance**: License compatibility with company policies
- **Version Compatibility**: Approved version ranges and compatibility matrix
- **Dependency Analysis**: Transitive dependency validation and conflict resolution
- **Upgrade Planning**: Safe upgrade paths and breaking change analysis

### Security Analysis

- **Vulnerability Assessment**: Known security issues in dependencies
- **Policy Compliance**: Company security policy adherence checking
- **Risk Assessment**: Security risk scoring and prioritization
- **Audit Trail**: Compliance documentation and approval tracking
- **Exception Management**: Process for handling unapproved dependencies
- **Security Updates**: Monitoring for security patches and updates

### Integration Validation

- **Django Ecosystem**: Django/DRF package compatibility validation
- **STOMP Messaging**: django-stomp and outbox pattern library validation
- **Database Libraries**: PostgreSQL, Redis, and caching library validation  
- **Authentication Libraries**: JWT, OAuth, and authentication library validation
- **Testing Libraries**: pytest, factory-boy, and testing framework validation
- **Development Tools**: Code quality, linting, and development tool validation

## juntossomosmais Library Categories

### Core Django/DRF Stack

```yaml
# Core framework dependencies
django: ">=4.2,<5.1"
djangorestframework: ">=3.14,<4.0"
django-cors-headers: ">=4.0,<5.0"
django-extensions: ">=3.2,<4.0"

# Database and caching
psycopg2-binary: ">=2.9,<3.0"
django-redis: ">=5.2,<6.0"
redis: ">=4.5,<5.0"

# Authentication and security
djangorestframework-simplejwt: ">=5.2,<6.0"
cryptography: ">=40.0,<42.0"
```

### Messaging and Integration

```yaml
# STOMP messaging (legacy)
django-stomp: ">=2.0,<3.0"
stomp-py: ">=8.1,<9.0"

# Outbox pattern (modern)
django-outbox-pattern: ">=1.0,<2.0"

# HTTP clients and integration
requests: ">=2.31,<3.0"
httpx: ">=0.24,<1.0"
celery: ">=5.2,<6.0"
```

### Monitoring and Observability

```yaml
# Health checks and monitoring
django-health-check: ">=3.17,<4.0"
opentelemetry-api: ">=1.18,<2.0"
opentelemetry-instrumentation-django: ">=0.39b0,<1.0"
sentry-sdk: ">=1.28,<2.0"

# Logging and debugging
structlog: ">=23.1,<24.0"
django-debug-toolbar: ">=4.1,<5.0"
```

### Development and Testing

```yaml
# Testing frameworks
pytest: ">=7.4,<8.0"
pytest-django: ">=4.5,<5.0"
factory-boy: ">=3.2,<4.0"
freezegun: ">=1.2,<2.0"

# Code quality
black: ">=23.7,<24.0"
isort: ">=5.12,<6.0"
flake8: ">=6.0,<7.0"
mypy: ">=1.5,<2.0"
```

## Validation Workflows

### Dependency File Analysis

```python
def analyze_requirements_file(file_path: str) -> dict:
    """
    Comprehensive analysis of dependency files.

    Returns:
    - Approval status for each dependency
    - Security vulnerability assessment
    - License compliance check
    - Version compatibility matrix
    - Upgrade recommendations
    """

    analysis = {
        "approved": [],
        "unapproved": [],
        "vulnerable": [],
        "outdated": [],
        "license_issues": [],
        "recommendations": []
    }

    # Parse dependency file
    dependencies = parse_dependency_file(file_path)

    for dep in dependencies:
        # Check approval status
        approval_status = check_juntossomosmais_approval(dep)

        # Security vulnerability check
        vulnerabilities = check_vulnerabilities(dep)

        # License compliance
        license_status = check_license_compliance(dep)

        # Version compatibility
        version_status = check_version_compatibility(dep)

        # Compile results
        compile_analysis_results(analysis, dep, approval_status,
                               vulnerabilities, license_status, version_status)

    return analysis
```

### Security Policy Validation

```python
def validate_security_policies(dependencies: list) -> dict:
    """
    Validate dependencies against juntossomosmais security policies.

    Checks:
    - Known vulnerability databases
    - Company security exceptions
    - Risk assessment and scoring
    - Compliance with security standards
    """

    security_report = {
        "high_risk": [],
        "medium_risk": [],
        "low_risk": [],
        "compliance_issues": [],
        "policy_violations": []
    }

    for dep in dependencies:
        # CVE database check
        cve_results = check_cve_database(dep)

        # Company policy check
        policy_compliance = check_company_policies(dep)

        # Risk scoring
        risk_score = calculate_risk_score(dep, cve_results, policy_compliance)

        # Categorize by risk level
        categorize_security_risk(security_report, dep, risk_score)

    return security_report
```

### License Compliance Analysis

```python
def analyze_license_compliance(dependencies: list) -> dict:
    """
    Comprehensive license compliance analysis.

    Checks:
    - License compatibility with company policies
    - GPL/copyleft license restrictions
    - Commercial use restrictions
    - Attribution requirements
    """

    license_report = {
        "compatible": [],
        "incompatible": [],
        "unknown": [],
        "attribution_required": [],
        "commercial_restrictions": []
    }

    for dep in dependencies:
        # License detection
        detected_licenses = detect_licenses(dep)

        # Compatibility analysis
        compatibility = analyze_license_compatibility(detected_licenses)

        # Company policy compliance
        policy_compliance = check_license_policies(detected_licenses)

        # Compile license analysis
        compile_license_results(license_report, dep, detected_licenses,
                              compatibility, policy_compliance)

    return license_report
```

## Validation Reports

### Dependency Approval Report

````markdown
# Dependency Validation Report

## Approval Status Summary
- ✅ **Approved**: 45 dependencies
- ❌ **Unapproved**: 3 dependencies  
- ⚠️ **Conditional**: 2 dependencies
- 🔍 **Under Review**: 1 dependency

## Unapproved Dependencies

### requests-oauthlib (2.1.0)
- **Status**: ❌ Not in approved list
- **Risk Level**: Medium
- **Reason**: Security vulnerabilities in version 2.1.0
- **Recommendation**: Upgrade to version 2.2.1 or use company-approved OAuth library
- **Alternative**: Use `authlib>=1.2.1` (approved)

### python-dateutil (2.8.1)  
- **Status**: ❌ Outdated version
- **Risk Level**: Low
- **Reason**: Version below minimum approved (2.8.2)
- **Recommendation**: Upgrade to `python-dateutil>=2.8.2,<3.0`

## Security Vulnerabilities

### django (4.1.7)
- **CVE-2023-31047**: SQL injection vulnerability
- **Severity**: High
- **Fix Available**: Upgrade to django>=4.2.2
- **juntossomosmais Status**: ✅ Approved version available

## License Issues

### GPL-licensed Dependencies
- **mysql-connector-python**: GPL-2.0 license
- **Impact**: Commercial use restrictions
- **Recommendation**: Use `psycopg2-binary` (PostgreSQL) instead

## Recommendations

### Immediate Actions Required
1. Upgrade `django` to resolve CVE-2023-31047
2. Replace `mysql-connector-python` with approved PostgreSQL drivers
3. Submit approval request for `requests-oauthlib` or use alternative

### Upgrade Opportunities  
1. `celery` 5.1.2 → 5.3.1 (performance improvements)
2. `redis` 4.3.0 → 4.6.0 (bug fixes and features)
3. `sentry-sdk` 1.25.1 → 1.28.1 (latest stable)
````

### Security Assessment Report

````markdown
# Security Assessment Report

## Overall Security Score: 8.2/10 (Good)

## High Priority Issues

### CVE-2023-31047 (django)
- **Severity**: Critical
- **CVSS Score**: 9.8
- **Description**: SQL injection in QuerySet.extra()
- **Affected Versions**: <4.1.9, <4.2.2
- **Fix**: Upgrade to django>=4.2.2
- **Status**: ✅ Approved fix available

## Medium Priority Issues

### CVE-2023-25577 (werkzeug)  
- **Severity**: Medium
- **CVSS Score**: 7.5
- **Description**: High resource consumption in multipart parser
- **Affected Versions**: <2.2.3
- **Fix**: Upgrade to werkzeug>=2.2.3
- **Status**: ⚠️ Development dependency only

## Security Policy Compliance

### Approved Security Standards
- ✅ No GPL-licensed production dependencies
- ✅ All cryptographic libraries approved
- ✅ Authentication libraries meet standards  
- ✅ No deprecated security libraries

### Policy Violations
- ❌ Unapproved HTTP client library detected
- ⚠️ Outdated TLS/SSL library version

## Risk Mitigation Recommendations

1. **Immediate** (Within 1 week):
   - Upgrade Django to patch CVE-2023-31047
   - Replace unapproved HTTP client libraries

2. **Short-term** (Within 1 month):
   - Upgrade all medium-risk vulnerabilities
   - Submit approval requests for pending dependencies

3. **Long-term** (Within 3 months):
   - Implement automated dependency scanning
   - Establish regular security update schedule
````

### Upgrade Planning Report

````markdown
# Dependency Upgrade Planning Report

## Safe Upgrade Path

### Phase 1: Critical Security Updates (Week 1)
```bash
pip install django>=4.2.2
pip install requests>=2.31.0  
pip install cryptography>=41.0.1
```

### Phase 2: Framework Updates (Week 2-3)
```bash
pip install djangorestframework>=3.14.0
pip install celery>=5.3.1
pip install redis>=4.6.0
```

### Phase 3: Development Tools (Week 4)
```bash
pip install pytest>=7.4.0
pip install black>=23.7.0
pip install mypy>=1.5.0
```

## Breaking Change Analysis

### Django 4.1 → 4.2 Upgrade
- **Breaking Changes**:
  - Removed support for PostgreSQL 11
  - Changed default `auto_created` field behavior
- **Migration Required**: Database migration for auto fields
- **Testing Impact**: Update test fixtures for auto field changes

### DRF 3.13 → 3.14 Upgrade  
- **Breaking Changes**: Minimal
- **New Features**: Enhanced OpenAPI schema generation
- **Testing Impact**: Update API documentation tests

## Compatibility Matrix

| Package | Current | Target | Compatible | Notes |
|---------|---------|--------|------------|-------|
| django | 4.1.7 | 4.2.2 | ✅ | Requires PostgreSQL 12+ |
| DRF | 3.13.1 | 3.14.0 | ✅ | Minor API changes |
| celery | 5.1.2 | 5.3.1 | ✅ | No breaking changes |
| redis | 4.3.0 | 4.6.0 | ✅ | Backward compatible |

## Rollback Strategy

### Emergency Rollback Plan
1. Maintain current versions in separate branch
2. Database migration rollback scripts prepared
3. Container images with previous versions tagged
4. Feature flag configuration for gradual rollout

## Testing Strategy

### Pre-upgrade Testing
- Full test suite execution with new dependencies
- Integration testing with external services
- Performance testing for regression detection
- Security scanning of upgraded packages

### Post-upgrade Validation
- Smoke tests in staging environment
- User acceptance testing for critical flows
- Performance monitoring for degradation
- Security validation of upgraded components
````

## Integration with juntossomosmais Infrastructure

### Automated Validation Pipeline

```yaml
# GitHub Actions workflow integration
name: Dependency Validation
on: [push, pull_request]

jobs:
  validate-dependencies:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate Dependencies
        run: |
          # Run library-checker skill
          # Generate validation report
          # Fail build if critical issues found
```

### Development Workflow Integration

- **Pre-commit Hooks**: Validate new dependencies before commit
- **Pull Request Checks**: Automated dependency analysis in PR reviews  
- **CI/CD Pipeline**: Block deployments with unapproved dependencies
- **Security Monitoring**: Continuous monitoring for new vulnerabilities
- **Approval Workflow**: Integration with juntossomosmais approval process

### Company Policy Integration

- **Security Policies**: Automated enforcement of company security standards
- **License Compliance**: Automatic license compatibility checking
- **Approval Process**: Integration with juntossomosmais/allowed-libraries workflow
- **Exception Management**: Process for handling security policy exceptions
- **Audit Trail**: Complete documentation of dependency decisions

---

*"Ensure your dependencies meet juntossomosmais security and compliance standards"*
