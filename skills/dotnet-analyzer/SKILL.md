---
skill: true
name: "dotnet-analyzer"
description: "**DOTNET DEEP ANALYZER** — Specialized skill for comprehensive, in-depth analysis of juntossomosmais .NET/C# applications. USE FOR: detailed code investigation; complex business logic analysis; performance bottleneck identification; security audit of .NET patterns; Entity Framework query optimization; CAP messaging flow analysis; Hangfire job analysis; authentication and authorization deep dive; error handling investigation; integration testing analysis. PROVIDES: detailed code reviews; architectural insights; performance recommendations; security findings; complex relationship mapping; integration flow documentation. JUNTOSSOMOSMAIS FOCUS: Deep understanding of StandardEntity patterns, CliFx command architecture, CAP transactional messaging, Entity Framework Core optimizations, Hangfire background processing, FluentValidation complex scenarios, and ASP.NET Core security patterns from juntossomosmais architecture."
applyTo:
  - "**/*.cs"
  - "**/Controllers/**/*"
  - "**/Commands/**/*"
  - "**/Consumers/**/*"
  - "**/Jobs/**/*"
  - "**/Migrations/**/*"
  - "**/Infra/**/*"
  - "**/tests/**/*"
  - "**/Tests/**/*"
invokes:
  - "semantic_search"
  - "grep_search"
  - "read_file"
  - "get_errors"
  - "vscode_listCodeUsages"
  - "vscode_askQuestions"
  - "mcp_io_github_git_get_file_contents"
  - "dotnet-explorer"
  - "github-repository-investigator"
---

# .NET Deep Analyzer Skill

*Comprehensive analysis and investigation of juntossomosmais .NET/C# applications*

## Purpose

This skill provides in-depth analysis of .NET/C# applications, going beyond surface exploration to understand complex patterns, relationships, and architectural decisions. Designed to work alongside `dotnet-explorer` when detailed investigation is needed for juntossomosmais .NET architecture.

## Core Capabilities

### Architectural Analysis
- **Complex Pattern Investigation**: Deep dive into CliFx commands, CAP messaging, and background job patterns
- **Integration Flow Mapping**: Comprehensive analysis of external service integrations and API flows
- **Performance Bottleneck Identification**: Entity Framework query analysis, memory usage, async patterns
- **Security Pattern Review**: Authentication flow security, authorization boundaries, data exposure risks
- **Code Quality Assessment**: Design pattern compliance, technical debt identification, maintainability analysis

### Business Logic Deep Dive
- **Transaction Analysis**: Complex database transaction patterns and Entity Framework contexts
- **Messaging Flow Investigation**: CAP publisher/consumer relationships, transactional outbox patterns
- **API Endpoint Analysis**: Controller logic, validation chains, and business rules
- **Background Job Investigation**: Hangfire job patterns, scheduling, error handling, and dependencies
- **Error Handling Analysis**: Exception propagation, logging patterns, and recovery mechanisms

### Data & Relationship Analysis
- **Entity Framework Optimization**: Query performance analysis, N+1 problem detection, bulk operations
- **Model Relationship Mapping**: Complex entity relationships, navigation properties, and inheritance
- **Migration Analysis**: Database schema evolution, migration dependencies, and data integrity
- **Validation Logic Investigation**: FluentValidation rules, business rule enforcement, and error handling
- **Test Coverage Analysis**: Integration test completeness, unit test quality, and edge case coverage

## juntossomosmais-Specific Deep Analysis

### CliFx Command Architecture Investigation

#### ApiCommand Deep Analysis
```csharp
public class ApiCommand : ICommand
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            /*
            Investigates:
            - Shared service registration patterns and dependencies
            - Hangfire configuration and job server setup
            - OpenTelemetry instrumentation scope and performance impact
            - FluentValidation registration patterns and validation chains
            - ASP.NET Core pipeline customization and middleware order
            */
            services.ConfigureSharedServices(_configuration);
            
            // Hangfire analysis: job storage, recurring jobs, dashboard security
            services.AddHangfire(config => /* complex configuration analysis */);
            
            // Validation pipeline analysis: automatic discovery, error handling
            services.AddControllers(options =>
            {
                options.Filters.Add<ModelValidationActionFilter>();
            });
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            /*
            Deep analysis of:
            - Health check endpoint security and performance implications
            - CORS policy evaluation and security boundary analysis
            - Auto-migration strategy risks and deployment considerations
            - Swagger configuration and API documentation completeness
            */
        }
    }
}
```

#### WorkerCommand Consumer Analysis
```csharp
public class WorkerCommand : ICommand
{
    /*
    Investigates:
    - Consumer auto-discovery mechanism and registration patterns
    - Ziggurat middleware pipeline performance and error handling
    - CAP subscription routing and load balancing strategies
    - Health check integration for consumer monitoring
    - Resource management and graceful shutdown patterns
    */
}
```

### CAP Messaging Deep Analysis

#### Transactional Outbox Pattern Investigation
```csharp
public class ComplexBusinessOperationAnalysis
{
    public async Task AnalyzeTransactionalPattern()
    {
        /*
        Deep investigation of:
        - Transaction boundary enforcement across multiple operations
        - CAP publisher integration with Entity Framework transactions
        - Message delivery guarantees and failure recovery patterns
        - Idempotency implementation via UseEntityFrameworkIdempotency
        - Message ordering and processing sequence analysis
        */
        
        using var transaction = await _context.Database.BeginTransactionAsync();
        
        // Analyze complex multi-step business operations
        var result = await ProcessComplexBusinessLogic();
        
        // Investigate CAP publishing within transaction boundaries
        await _capBus.PublishAsync("topic.name", messagePayload);
        
        await transaction.CommitAsync();
    }
}
```

#### Consumer Pattern Deep Analysis
```csharp
public class OrderCreatedConsumer : ICapSubscribe
{
    /*
    Comprehensive analysis of:
    - Message validation pipeline performance and error scenarios
    - Ziggurat middleware execution order and side effects
    - Consumer service dependency injection patterns and lifetime
    - Error handling and dead letter queue configuration
    - Message processing idempotency and duplicate handling
    */
    
    public class Handler : IConsumerService<OrderCreatedMessage>
    {
        /*
        Business logic investigation:
        - Entity Framework context usage patterns and transaction handling
        - External service integration patterns and failure resilience
        - Complex business rule enforcement and validation chains
        - Performance analysis of database operations and queries
        - Error propagation and logging strategy analysis
        */
    }
}
```

### Entity Framework Deep Analysis

#### Complex Query Performance Investigation
```csharp
public class DatabaseAnalyzer
{
    public async Task AnalyzeQueryPerformance()
    {
        /*
        Investigates:
        - N+1 query detection and prevention strategies
        - Complex join performance and query plan analysis
        - Split query usage for multiple collection includes
        - Bulk operation performance vs individual operations
        - Index utilization and query optimization opportunities
        */
        
        // Analyze complex query patterns
        var result = await _context.Orders
            .Include(o => o.Items)
            .ThenInclude(i => i.Product)
            .Where(o => o.CreatedAt >= DateTime.UtcNow.AddDays(-30))
            .AsSplitQuery()
            .AsNoTracking()
            .ToListAsync();
    }
    
    public async Task AnalyzeBulkOperations()
    {
        /*
        Performance analysis of:
        - ExecuteUpdateAsync vs LoadAndUpdate patterns
        - ExecuteDeleteAsync vs LoadAndDelete performance
        - Batch operation sizing and memory usage
        - Transaction handling in bulk operations
        */
    }
}
```

#### StandardEntity Pattern Analysis
```csharp
public class StandardEntityAnalyzer
{
    /*
    Investigates:
    - Automatic timestamp updates in SaveChangesAsync override
    - Change tracking performance implications
    - Inheritance pattern impact on query performance
    - Audit trail completeness and consistency
    - Soft delete pattern implementation and query filtering
    */
    
    private void AutomaticallyAddCreatedAndUpdatedAt()
    {
        var entitiesOnDbContext = ChangeTracker.Entries<StandardEntity>();
        
        // Deep analysis of change tracking performance
        foreach (var item in entitiesOnDbContext.Where(t => t.State == EntityState.Added))
        {
            // Timestamp assignment pattern analysis
            item.Entity.CreatedAt = DateTime.Now.ToUniversalTime();
            item.Entity.UpdatedAt = DateTime.Now.ToUniversalTime();
        }
    }
}
```

### Hangfire Background Job Analysis

#### Job Processing Deep Investigation
```csharp
public class BackgroundJobAnalyzer
{
    /*
    Comprehensive analysis of:
    - Job enqueueing patterns and parameter serialization
    - Job processing reliability and error handling
    - Resource management and dependency injection lifetime
    - Job scheduling patterns and recurring job configuration
    - Dead job analysis and failure recovery strategies
    */
    
    public async Task AnalyzeJobPattern(TodoItemCompletionJob job)
    {
        /*
        Investigates:
        - ExecuteAsync method performance and optimization
        - Database operation efficiency in background context
        - Error handling and retry mechanism effectiveness
        - Job parameter validation and business rule enforcement
        - Integration with Entity Framework context lifetime
        */
    }
}
```

#### Job Dashboard Security Analysis
```csharp
public class HangfireDashboardAnalysis
{
    /*
    Security analysis of:
    - AllowAllDashboardAuthorizationFilter security implications
    - Dashboard access control and authentication requirements
    - Job data exposure through dashboard interface
    - Production security hardening recommendations
    */
}
```

### FluentValidation Deep Analysis

#### Complex Validation Chain Investigation
```csharp
public class ValidationAnalyzer
{
    /*
    Deep investigation of:
    - Validation pipeline performance with complex rules
    - Database validation rule efficiency and caching opportunities
    - Cross-field validation patterns and business rule enforcement
    - Error message localization and user experience
    - Validation rule composition and reusability patterns
    */
    
    public class CreateOrderValidation : AbstractValidator<CreateOrderDto>
    {
        /*
        Analyzes:
        - Database lookup validation performance
        - Complex business rule validation efficiency
        - Async validation patterns and their implications
        - Error message formatting and internationalization
        */
    }
}
```

### Health Check System Analysis

#### Custom Health Check Investigation
```csharp
public class HealthCheckAnalyzer
{
    /*
    Comprehensive analysis of:
    - Health check execution performance and timeout handling
    - Dependency health verification accuracy and completeness
    - Health check endpoint security and information disclosure
    - Integration with monitoring systems and alerting
    - Graceful degradation patterns and circuit breaker integration
    */
    
    public async Task AnalyzeRabbitMQHealthCheck()
    {
        /*
        Investigates:
        - Connection factory configuration and security
        - Health check timeout and failure threshold analysis
        - Resource cleanup and connection lifecycle management
        - Error handling and diagnostic information collection
        */
    }
}
```

## Advanced Analysis Techniques

### Performance Analysis
- **Query Analysis**: EF Core query plan examination, index usage analysis, performance profiling
- **Memory Usage**: Object lifecycle analysis, garbage collection impact, memory leak detection
- **Async Patterns**: Task utilization, deadlock prevention, async/await optimization
- **Background Processing**: Hangfire job queue analysis, resource contention, processing throughput

### Security Analysis
- **Authentication Vulnerabilities**: JWT token validation, claim-based security, session management
- **Authorization Boundaries**: Permission enforcement, role-based access, resource protection
- **Data Exposure**: Serialization security, logging sensitive data, API response filtering
- **Input Validation**: FluentValidation bypass scenarios, injection vulnerabilities, business rule enforcement

### Integration Analysis
- **External Service Patterns**: HTTP client usage, timeout handling, circuit breaker implementation
- **Message Queue Integration**: CAP transactional guarantees, message ordering, failure recovery
- **Database Integration**: Connection pooling, transaction isolation, deadlock analysis
- **Monitoring Integration**: OpenTelemetry configuration, logging correlation, performance metrics

## Complex Investigation Workflows

### Business Logic Investigation
```
1. Map the complete request/response flow through CliFx commands
2. Analyze all validation layers and business rule enforcement
3. Investigate transaction boundaries and rollback scenarios
4. Review error handling and recovery mechanisms
5. Assess performance implications and optimization opportunities
```

### Integration Flow Analysis
```
1. Trace CAP message flow from publisher to consumer
2. Analyze Entity Framework query patterns and optimizations
3. Investigate Hangfire job dependencies and processing patterns
4. Review monitoring and observability integration
5. Assess reliability and failure recovery strategies
```

### Security Deep Dive
```
1. Map authentication and authorization flow across controllers
2. Analyze permission boundaries and potential bypass scenarios
3. Review data serialization and potential information disclosure
4. Investigate input validation completeness and edge cases
5. Assess compliance with security best practices
```

### Performance Investigation
```
1. Analyze Entity Framework query patterns and optimization opportunities
2. Review Hangfire job processing efficiency and resource usage
3. Investigate memory usage patterns and garbage collection impact
4. Analyze async/await patterns and potential deadlock scenarios
5. Review monitoring data and performance metrics correlation
```

## Analysis Output Formats

### Comprehensive Reports
- **Architecture Summary**: CliFx command relationships, service dependencies
- **Security Findings**: Authentication/authorization vulnerabilities, data exposure risks
- **Performance Analysis**: Query optimization opportunities, background job efficiency
- **Code Quality Review**: Technical debt, maintainability issues, pattern compliance
- **Integration Assessment**: External dependencies, messaging reliability, health check effectiveness

### Detailed Investigations
- **Code Flow Diagrams**: Request processing through controllers and commands
- **Entity Relationship Maps**: Complex database relationships and query patterns
- **Performance Profiles**: EF Core query analysis, Hangfire job processing metrics
- **Security Audit**: Authentication flows, authorization boundaries, data protection review
- **Test Coverage Analysis**: Integration test gaps, unit test quality assessment

### Actionable Recommendations
- **Refactoring Opportunities**: Code improvement suggestions, pattern modernization
- **Performance Optimizations**: Query improvements, async pattern enhancements
- **Security Enhancements**: Authentication hardening, authorization improvements
- **Architecture Improvements**: Design pattern recommendations, integration enhancements
- **Testing Strategy**: Coverage improvements, test quality enhancements

## Integration with Other Skills

### Workflow Integration
1. **dotnet-explorer** - Provides initial discovery and context
2. **dotnet-analyzer** - Performs deep investigation and analysis (this skill)
3. **dotnet-documenter** - Creates comprehensive documentation from analysis
4. **library-checker** - Validates .NET dependencies and compliance

### Collaborative Analysis
- **Performance Focus**: Works with infrastructure analysis for deployment optimization
- **Security Focus**: Integrates with security audit processes and compliance requirements
- **Documentation Focus**: Provides detailed findings for comprehensive documentation
- **Quality Focus**: Supports code review and technical debt reduction efforts

---

*"Uncover the deep truths hidden in your juntossomosmais .NET architecture"*