---
skill: true
name: "dotnet-library-checker"
description: "**JUNTOSSOMOSMAIS .NET LIBRARY VALIDATOR** — Specialized skill for validating .NET dependencies against juntossomosmais/allowed-libraries repository and company security policies. USE FOR: NuGet package validation; security compliance checking; library approval verification; vulnerability assessment; license compliance; version compatibility checking; dependency upgrade planning; security policy enforcement. PROVIDES: approval status verification; security vulnerability reports; license compliance analysis; version compatibility matrix; dependency recommendations; upgrade pathways. JUNTOSSOMOSMAIS FOCUS: Integration with juntossomosmais/allowed-libraries repository, company security policies, approved .NET/C# package validation, Entity Framework Core ecosystem compatibility, ASP.NET Core framework compliance, CAP messaging library validation, and Hangfire ecosystem compatibility."
applyTo:
  - "**/*.csproj"
  - "**/packages.config"
  - "**/Directory.Build.props"
  - "**/Directory.Packages.props"
  - "**/global.json"
  - "**/nuget.config"
  - "**/packages.lock.json"
invokes:
  - "read_file"
  - "grep_search"
  - "semantic_search"
  - "mcp_io_github_git_get_file_contents"
  - "mcp_io_github_git_search_issues"
  - "fetch_webpage"
  - "vscode_askQuestions"
---

# juntossomosmais .NET Library Validator Skill

*Comprehensive .NET dependency validation against company security policies and approved libraries*

## Purpose

This skill validates .NET dependencies against juntossomosmais security policies and the approved libraries repository, ensuring compliance with company standards and security requirements. Provides comprehensive analysis of NuGet packages, vulnerabilities, and upgrade paths for .NET/C# applications.

## Core Capabilities

### Dependency Validation

- **Approval Status**: Check against juntossomosmais/allowed-libraries repository
- **Security Compliance**: NuGet vulnerability scanning and security policy validation
- **License Compliance**: License compatibility with company policies
- **Version Compatibility**: Approved version ranges and framework compatibility
- **Dependency Analysis**: Transitive dependency validation and conflict resolution
- **Upgrade Planning**: Safe upgrade paths and breaking change analysis

### Security Analysis

- **Vulnerability Assessment**: Known security issues in NuGet packages
- **Policy Compliance**: Company security policy adherence checking
- **Risk Assessment**: Security risk scoring and prioritization
- **Audit Trail**: Compliance documentation and approval tracking
- **Exception Management**: Process for handling unapproved dependencies
- **Security Updates**: Monitoring for security patches and updates

### .NET Ecosystem Validation

- **Framework Compatibility**: .NET 8, ASP.NET Core, Entity Framework Core validation
- **CliFx Ecosystem**: CliFx and related command-line tool validation
- **CAP Messaging**: DotNetCore.CAP and RabbitMQ library validation
- **Hangfire Libraries**: Background job processing library validation
- **Testing Libraries**: xUnit, Moq, and testing framework validation
- **Development Tools**: Code quality, logging, and development tool validation

## juntossomosmais .NET Library Categories

### Core .NET Framework Stack

```xml
<!-- Core framework dependencies -->
<PackageReference Include="Microsoft.AspNetCore.App" />
<PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="8.0.0" />
<PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="8.0.0" />
<PackageReference Include="Microsoft.Extensions.Hosting" Version="8.0.0" />

<!-- Configuration and logging -->
<PackageReference Include="Serilog.AspNetCore" Version="8.0.0" />
<PackageReference Include="Serilog.Sinks.Console" Version="5.0.0" />
<PackageReference Include="Microsoft.Extensions.Configuration.Json" Version="8.0.0" />
```

### CliFx Command Framework

```xml
<!-- Command-line interface -->
<PackageReference Include="CliFx" Version="2.3.5" />
<PackageReference Include="CliFx.Attributes" Version="2.3.5" />

<!-- Host builder integration -->
<PackageReference Include="Microsoft.Extensions.Hosting.Abstractions" Version="8.0.0" />
```

### CAP Messaging and Integration

```xml
<!-- CAP framework for transactional messaging -->
<PackageReference Include="DotNetCore.CAP" Version="7.2.0" />
<PackageReference Include="DotNetCore.CAP.SqlServer" Version="7.2.0" />
<PackageReference Include="DotNetCore.CAP.RabbitMQ" Version="7.2.0" />

<!-- Ziggurat middleware -->
<PackageReference Include="Ziggurat" Version="2.1.0" />
<PackageReference Include="Ziggurat.SqlServer" Version="2.1.0" />
<PackageReference Include="Ziggurat.CapAdapter" Version="2.1.0" />

<!-- Message broker client -->
<PackageReference Include="RabbitMQ.Client" Version="6.6.0" />
```

### Background Processing and Jobs

```xml
<!-- Hangfire background jobs -->
<PackageReference include="Hangfire.Core" Version="1.8.6" />
<PackageReference Include="Hangfire.SqlServer" Version="1.8.6" />
<PackageReference Include="Hangfire.AspNetCore" Version="1.8.6" />
```

### Validation and API Framework

```xml
<!-- FluentValidation -->
<PackageReference Include="FluentValidation" Version="11.8.0" />
<PackageReference Include="FluentValidation.DependencyInjectionExtensions" Version="11.8.0" />

<!-- ASP.NET Core API -->
<PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
<PackageReference Include="Newtonsoft.Json" Version="13.0.3" />
```

### Observability and Monitoring

```xml
<!-- OpenTelemetry -->
<PackageReference Include="OpenTelemetry" Version="1.6.0" />
<PackageReference Include="OpenTelemetry.Extensions.Hosting" Version="1.6.0" />
<PackageReference Include="OpenTelemetry.Instrumentation.AspNetCore" Version="1.5.1-beta.1" />
<PackageReference Include="OpenTelemetry.Instrumentation.EntityFrameworkCore" Version="1.0.0-beta.7" />
<PackageReference Include="OpenTelemetry.Instrumentation.SqlClient" Version="1.5.1-beta.1" />
<PackageReference Include="OpenTelemetry.Exporter.OpenTelemetryProtocol" Version="1.6.0" />

<!-- Health checks -->
<PackageReference Include="AspNetCore.HealthChecks.SqlServer" Version="7.0.0" />
<PackageReference Include="AspNetCore.HealthChecks.UI.Client" Version="7.1.0" />
```

### Testing Framework

```xml
<!-- xUnit testing framework -->
<PackageReference Include="xunit" Version="2.4.2" />
<PackageReference Include="xunit.runner.visualstudio" Version="2.4.5" />
<PackageReference Include="Microsoft.NET.Test.Sdk" Version="17.8.0" />

<!-- ASP.NET Core testing -->
<PackageReference Include="Microsoft.AspNetCore.Mvc.Testing" Version="8.0.0" />
<PackageReference Include="Microsoft.AspNetCore.TestHost" Version="8.0.0" />

<!-- Mocking -->
<PackageReference Include="Moq" Version="4.20.69" />
<PackageReference Include="Moq.AutoMock" Version="3.5.0" />
```

## Validation Workflows

### Project File Analysis

```csharp
public class DotNetProjectAnalyzer
{
    public async Task<ValidationResult> AnalyzeProjectFile(string projectPath)
    {
        /*
        Comprehensive analysis of .csproj files:
        - PackageReference validation against approved lists
        - TargetFramework compatibility checking (.NET 8)
        - Version range validation against security policies
        - Transitive dependency analysis and conflict detection
        - License compliance verification
        */

        var project = await ParseProjectFile(projectPath);
        var validation = new ValidationResult();

        foreach (var package in project.PackageReferences)
        {
            // Check approval status
            var approvalStatus = await CheckJuntossomosmaisApproval(package);

            // Security vulnerability check
            var vulnerabilities = await CheckNuGetVulnerabilities(package);

            // License compliance
            var licenseStatus = await CheckLicenseCompliance(package);

            // Framework compatibility
            var compatibilityStatus = CheckFrameworkCompatibility(package, project.TargetFramework);

            validation.Results.Add(CompileValidationResult(package, approvalStatus,
                vulnerabilities, licenseStatus, compatibilityStatus));
        }

        return validation;
    }
}
```

### Package Lock File Analysis

```csharp
public class PackageLockAnalyzer
{
    public async Task<SecurityReport> AnalyzePackagesLockJson(string lockFilePath)
    {
        /*
        Detailed analysis of packages.lock.json:
        - Exact version tracking for security scanning
        - Transitive dependency vulnerability assessment
        - Package integrity verification
        - Version consistency across target frameworks
        - Dependency graph analysis for security impact
        */

        var lockFile = await ParsePackagesLockFile(lockFilePath);
        var securityReport = new SecurityReport();

        foreach (var dependency in lockFile.Dependencies)
        {
            // CVE database lookup
            var cveResults = await CheckCVEDatabase(dependency);

            // Company security policy validation
            var policyCompliance = await CheckSecurityPolicies(dependency);

            // Risk assessment
            var riskScore = CalculateRiskScore(dependency, cveResults, policyCompliance);

            securityReport.AddFinding(dependency, cveResults, riskScore);
        }

        return securityReport;
    }
}
```

### NuGet Configuration Validation

```csharp
public class NuGetConfigValidator
{
    public async Task<ConfigurationReport> ValidateNuGetConfig(string configPath)
    {
        /*
        NuGet configuration security validation:
        - Package source security and authentication
        - Trusted signers configuration validation
        - Package verification settings compliance
        - Corporate proxy and feed configuration
        - Security policy enforcement settings
        */

        var config = await ParseNuGetConfig(configPath);
        var report = new ConfigurationReport();

        // Validate package sources
        foreach (var source in config.PackageSources)
        {
            var sourceValidation = ValidatePackageSource(source);
            report.AddSourceValidation(sourceValidation);
        }

        // Check trusted signers
        var signerValidation = ValidateTrustedSigners(config.TrustedSigners);
        report.AddSignerValidation(signerValidation);

        return report;
    }
}
```

## Validation Reports

### .NET Dependency Approval Report

````markdown
# .NET Dependency Validation Report

## Approval Status Summary
- ✅ **Approved**: 42 packages
- ❌ **Unapproved**: 2 packages
- ⚠️ **Conditional**: 3 packages
- 🔍 **Under Review**: 1 package

## Framework Compatibility
- **Target Framework**: .NET 8.0
- **ASP.NET Core**: 8.0.0 ✅
- **Entity Framework**: 8.0.0 ✅

## Unapproved Dependencies

### System.Text.Json (8.0.1)
- **Status**: ❌ Not in approved list
- **Alternative**: Use `Newtonsoft.Json` (approved)
- **Risk Level**: Low
- **Migration Path**: Replace with Newtonsoft.Json serialization

### AutoMapper (12.0.1)
- **Status**: ❌ Prohibited pattern
- **Reason**: Violates juntossomosmais architectural decision (no AutoMapper)
- **Recommendation**: Remove and implement manual mapping
- **Impact**: Medium - requires code refactoring

## Security Vulnerabilities

### Microsoft.AspNetCore.App (8.0.0)
- **CVE-2024-21319**: Potential denial of service vulnerability
- **Severity**: Medium
- **Fix Available**: Upgrade to 8.0.1
- **juntossomosmais Status**: ✅ Approved version available

### Hangfire.SqlServer (1.8.5)
- **CVE-2023-45678**: SQL injection in dashboard
- **Severity**: High  
- **Fix Available**: Upgrade to 1.8.6
- **Status**: ✅ Fixed version approved

## License Compliance Issues

### Commercial License Dependencies
- **ComponentOne.Web.Mvc**: Commercial license required
- **Impact**: License fee and compliance documentation needed
- **Recommendation**: Evaluate open-source alternatives

## Recommendations

### Immediate Actions Required (Within 1 week)
1. Upgrade Hangfire.SqlServer to resolve CVE-2023-45678
2. Remove AutoMapper and implement manual mapping
3. Replace System.Text.Json with Newtonsoft.Json

### Strategic Improvements (Within 1 month)
1. Implement automated dependency scanning in CI/CD
2. Update project templates with approved packages
3. Create internal NuGet feed for approved packages
````

### .NET Security Assessment Report

````markdown
# .NET Security Assessment Report

## Overall Security Score: 7.8/10 (Good)

## Critical Priority Issues

### CVE-2023-45678 (Hangfire.SqlServer)
- **Severity**: Critical
- **CVSS Score**: 9.1
- **Description**: SQL injection vulnerability in dashboard queries
- **Affected Versions**: <1.8.6
- **Fix**: Upgrade to Hangfire.SqlServer 1.8.6
- **Status**: ✅ Approved fix available

## High Priority Issues

### CVE-2024-21319 (Microsoft.AspNetCore.App)
- **Severity**: High
- **CVSS Score**: 7.5
- **Description**: Denial of Service in request processing
- **Affected Versions**: 8.0.0
- **Fix**: Upgrade to 8.0.1
- **Status**: ✅ Approved fix available

## Framework Security Compliance

### .NET 8 Security Standards
- ✅ Long Term Support (LTS) version in use
- ✅ Security updates enabled
- ✅ Minimal API surface exposure
- ⚠️ Some packages lack digital signatures

### ASP.NET Core Security
- ✅ HTTPS enforcement configured
- ✅ Authentication middleware configured
- ✅ CORS policy properly restricted
- ❌ Missing security headers middleware

## Package Integrity Assessment

### Digital Signature Validation
- **Signed Packages**: 38/48 (79%)
- **Microsoft Signed**: 32/48 (67%)
- **Third-party Signed**: 6/48 (12%)
- **Unsigned**: 10/48 (21%) ⚠️

### Dependency Chain Analysis
- **Direct Dependencies**: 26 packages
- **Transitive Dependencies**: 142 packages
- **Depth Analysis**: Maximum depth 4 levels
- **Circular Dependencies**: None detected ✅

## Risk Mitigation Strategy

### Immediate Actions (Within 1 week)
1. **Critical Fixes**: Upgrade Hangfire.SqlServer and ASP.NET Core
2. **Security Headers**: Add security headers middleware
3. **Package Signing**: Verify unsigned package necessity

### Short-term Actions (Within 1 month)
1. **Automated Scanning**: Implement NuGet security scanning in CI/CD
2. **Package Validation**: Add package signature validation
3. **Security Monitoring**: Set up vulnerability monitoring alerts

### Long-term Strategy (Within 3 months)
1. **Corporate NuGet Feed**: Establish internal package repository
2. **Security Policies**: Implement package approval workflow
3. **Developer Training**: Security awareness for dependency management
````

### .NET Framework Upgrade Planning Report

````markdown
# .NET Framework Upgrade Planning Report

## Current State Analysis

### Target Framework Assessment
- **Current**: .NET 8.0 ✅ (LTS)
- **Support Status**: Long Term Support until November 2026
- **Security Status**: Active security updates
- **Performance**: Latest performance optimizations

### Package Compatibility Matrix

| Package Category | Current Version | Latest Available | Compatible | Notes |
|-----------------|----------------|------------------|------------|--------|
| ASP.NET Core | 8.0.0 | 8.0.1 | ✅ | Security update recommended |
| Entity Framework | 8.0.0 | 8.0.1 | ✅ | Minor version safe |
| Hangfire | 1.8.5 | 1.8.6 | ✅ | Security fix required |
| CliFx | 2.3.5 | 2.3.5 | ✅ | Latest version |
| CAP Framework | 7.2.0 | 8.0.0 | ⚠️ | Breaking changes reviewed |

## Safe Upgrade Path

### Phase 1: Security Updates (Week 1)
```xml
<!-- Critical security updates -->
<PackageReference Include="Microsoft.AspNetCore.App" Version="8.0.1" />
<PackageReference Include="Hangfire.SqlServer" Version="1.8.6" />
<PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="8.0.1" />
```

### Phase 2: Framework Updates (Week 2-3)
```xml
<!-- Non-breaking feature updates -->
<PackageReference Include="Serilog.AspNetCore" Version="8.0.1" />
<PackageReference Include="FluentValidation" Version="11.8.1" />
<PackageReference Include="OpenTelemetry" Version="1.7.0" />
```

### Phase 3: Major Version Updates (Week 4)
```xml
<!-- Breaking change updates (requires testing) -->
<PackageReference Include="DotNetCore.CAP" Version="8.0.0" />
<PackageReference Include="DotNetCore.CAP.SqlServer" Version="8.0.0" />
<PackageReference Include="DotNetCore.CAP.RabbitMQ" Version="8.0.0" />
```

## Breaking Change Analysis

### CAP Framework 7.2 → 8.0 Upgrade
- **Breaking Changes**:
  - Message serialization format changes
  - Consumer configuration API updates
  - Health check integration changes
- **Migration Required**: Update consumer registration patterns
- **Testing Impact**: Full integration test execution required

### Entity Framework Core 8.0 → 8.0.1
- **Breaking Changes**: None (patch version)
- **New Features**: Performance improvements, bug fixes
- **Migration Required**: None
- **Testing Impact**: Regression testing recommended

## Testing Strategy

### Pre-upgrade Validation
```bash
# Run full test suite with current packages
dotnet test --configuration Release --logger:"console;verbosity=detailed"

# Performance baseline establishment
dotnet run --project PerformanceTests -- --baseline
```

### Post-upgrade Validation
```bash
# Integration test execution
dotnet test --configuration Release --filter "Category=Integration"

# Performance regression testing
dotnet run --project PerformanceTests -- --compare-baseline

# Security validation
dotnet list package --vulnerable --include-transitive
```

## Risk Assessment

### Low Risk Updates
- **ASP.NET Core 8.0.0 → 8.0.1**: Patch version, security fixes only
- **Entity Framework 8.0.0 → 8.0.1**: Patch version, backward compatible
- **Serilog updates**: Minor versions, non-breaking

### Medium Risk Updates  
- **CAP Framework major version**: API changes require code updates
- **OpenTelemetry updates**: Configuration changes may be required
- **FluentValidation**: Validation behavior changes possible

### High Risk Updates
- **Framework version changes**: .NET version upgrades
- **Database provider updates**: EF Core provider major versions
- **Security library updates**: Authentication/authorization changes

## Rollback Strategy

### Emergency Rollback Plan
1. **Git Branch Strategy**: Maintain upgrade branch for quick revert
2. **Package Backup**: Document exact package versions before upgrade  
3. **Database Compatibility**: Ensure EF migrations are backward compatible
4. **Configuration Rollback**: Preserve original appsettings.json configurations

### Rollback Procedure
```bash
# Revert to previous package versions
git checkout main -- *.csproj
dotnet restore

# Database migration rollback if needed
dotnet ef database update [previous-migration] --project src

# Verify rollback success
dotnet test --filter "Category=Smoke"
```
````

## Integration with juntossomosmais Infrastructure

### Automated Validation Pipeline

```yaml
# GitHub Actions workflow for dependency validation
name: .NET Dependency Validation
on: [push, pull_request]

jobs:
  validate-dependencies:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: '8.0.x'

      - name: Restore dependencies
        run: dotnet restore

      - name: Validate Dependencies
        run: |
          # Run dotnet-library-checker skill
          # Generate validation report
          # Fail build if critical issues found

      - name: Security Scan
        run: dotnet list package --vulnerable --include-transitive

      - name: License Check
        run: dotnet-project-licenses --input . --output-format json
```

### Development Workflow Integration

- **Pre-commit Hooks**: Validate new package additions before commit
- **Pull Request Checks**: Automated dependency analysis in PR reviews
- **CI/CD Pipeline**: Block deployments with unapproved or vulnerable packages
- **Security Monitoring**: Continuous monitoring for new vulnerabilities
- **Approval Workflow**: Integration with juntossomosmais/allowed-libraries process

### Company Policy Integration

- **Security Policies**: Automated enforcement of company security standards
- **License Compliance**: Automatic license compatibility checking
- **Approval Process**: Integration with juntossomosmais package approval workflow
- **Exception Management**: Process for handling security policy exceptions
- **Audit Trail**: Complete documentation of dependency decisions and approvals

---

*"Ensure your .NET dependencies meet juntossomosmais security and compliance standards"*
