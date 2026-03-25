---
skill: true
name: "dotnet-explorer"
description: "**DOTNET FAST EXPLORER** — Specialized skill for rapid exploration and quick Q&A about juntossomosmais .NET/C# applications. USE FOR: understanding project structure; identifying CliFx commands and controllers; locating specific files and patterns; answering quick questions about code organization; finding models, controllers, consumers, and jobs; exploring API endpoints and routing patterns; understanding Entity Framework configurations; identifying CAP/RabbitMQ messaging patterns; exploring Hangfire background jobs. PROVIDES: fast responses about code structure; component relationships; file locations and purposes; quick summaries of functionality; guidance for deeper analysis. JUNTOSSOMOSMAIS FOCUS: Understands StandardEntity patterns, CliFx command structure (ApiCommand/WorkerCommand), CAP messaging consumers, Entity Framework Core with SQL Server/MongoDB, FluentValidation patterns, Hangfire job patterns, and project-specific conventions from dotnet-template architecture."
applyTo:
  - "**/*.cs"
  - "**/*.csproj"
  - "**/appsettings*.json"
  - "**/Program.cs"
  - "**/Startup.cs"
  - "**/Controllers/**/*"
  - "**/Commands/**/*"
  - "**/Consumers/**/*"
  - "**/Jobs/**/*"
  - "**/Models/**/*"
  - "**/Migrations/**/*"
invokes:
  - "semantic_search"
  - "file_search"
  - "grep_search"
  - "read_file"
  - "vscode_askQuestions"
  - "mcp_io_github_git_get_file_contents"
  - "github-repository-investigator"
---

# .NET Fast Explorer Skill

*Rapid exploration and Q&A for juntossomosmais .NET/C# applications*

## Purpose

This skill provides fast exploration capabilities for .NET/C# applications, quickly answering questions about project structure, identifying components, and providing context for deeper analysis. Designed for initial discovery and rapid understanding of juntossomosmais .NET architecture patterns.

## Core Capabilities

### Project Structure Analysis

- **CliFx Command Discovery**: Identify ApiCommand, WorkerCommand, and SeedCommand patterns
- **Controller Organization**: ASP.NET Core API controllers with versioning (V1, V2)
- **Entity Framework Models**: StandardEntity inheritance patterns and database contexts
- **Background Jobs**: Hangfire job classes and scheduling patterns
- **Messaging Components**: CAP consumers and message handling patterns
- **Validation Structure**: FluentValidation validator organization

### Component Identification

- **API Endpoints**: Controller actions, routing patterns, and versioning
- **Database Models**: Entity relationships, migrations, and database contexts
- **Message Consumers**: CAP/RabbitMQ consumer patterns and message DTOs
- **Background Jobs**: Hangfire job implementations and enqueueing logic
- **Health Checks**: Custom health check implementations and endpoints
- **Configuration**: appsettings.json structure and environment-specific configs

### Quick Analysis

- **Dependencies**: Project references, NuGet packages, and framework versions
- **Architecture Patterns**: Command pattern usage, messaging flows, job processing
- **Database Strategy**: SQL Server vs MongoDB usage, connection string patterns
- **Authentication**: JWT patterns, authorization policies, and security configurations
- **Integration Points**: External service integrations and API patterns

## juntossomosmais .NET Architecture Patterns

### CliFx Command Structure Discovery

#### ApiCommand Pattern (API Host)

```csharp
[Command("api")]
public class ApiCommand : ICommand
{
    public async ValueTask ExecuteAsync(IConsole console)
        => await Program.CreateHostBuilder(Array.Empty<string>()).Build().RunAsync();

    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.ConfigureSharedServices(_configuration);
            // API-specific services: Hangfire, Controllers, Swagger
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            // Health checks: /api/healthcheck/liveness, /readiness, /integrations
            // CORS, Swagger, Auto-migrations
        }
    }
}
```

#### WorkerCommand Pattern (Consumer Host)

```csharp
[Command("worker")]
public class WorkerCommand : ICommand
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.ConfigureSharedServices(_configuration);
            // FluentValidation validators for messages
            // Consumer registration via auto-discovery
        }
    }
}
```

### StandardEntity Pattern Discovery

```csharp
public abstract class StandardEntity
{
    public int Id { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}

public class TodoItem : StandardEntity
{
    public string? Name { get; set; }
    public bool IsComplete { get; set; }
    public Person Person { get; set; }
    public int UserId { get; set; }
}
```

### CAP Messaging Pattern Discovery

#### Consumer Pattern

```csharp
public class OrderCreatedConsumer : ICapSubscribe
{
    private readonly IConsumerService<OrderCreatedMessage> _consumerService;

    public OrderCreatedConsumer(IConsumerService<OrderCreatedMessage> consumerService)
        => _consumerService = consumerService;

    [CapSubscribe(Topics.OrderCreated, Group = Groups.OrderCreated)]
    public async Task HandleAsync(OrderCreatedMessage message)
        => await _consumerService.ProcessMessageAsync(message);

    public class Handler : IConsumerService<OrderCreatedMessage>
    {
        private readonly AppDbContext _context;

        // Business logic implementation
    }
}
```

#### Message DTO Pattern

```csharp
public class OrderCreatedMessage : IMessage
{
    public string OrderId { get; set; }
    public string CustomerId { get; set; }
    public string MessageId { get; set; }
    public string MessageGroup { get; set; }
}
```

### Entity Framework Context Discovery

#### AppDbContext Pattern

```csharp
public class AppDbContext : DbContext
{
    public DbSet<Person> Persons { get; set; }
    public DbSet<TodoItem> TodoItems { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Entity configurations and relationships
        modelBuilder.Entity<Person>(entity =>
        {
            entity.Property(p => p.Name).IsRequired().HasMaxLength(100);
            entity.HasIndex(p => p.Name).IsUnique();
        });

        // CAP message tracking
        modelBuilder.MapMessageTracker();
    }

    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        AutomaticallyAddCreatedAndUpdatedAt();
        return await base.SaveChangesAsync(cancellationToken);
    }
}
```

### Hangfire Job Pattern Discovery

```csharp
namespace DotNetTemplate.Jobs;

public class TodoItemCompletionJob
{
    private readonly AppDbContext _context;

    public TodoItemCompletionJob(AppDbContext context) => _context = context;

    public async Task ExecuteAsync(int todoItemId)
    {
        await _context.TodoItems
            .Where(t => t.Id == todoItemId)
            .ExecuteUpdateAsync(s => s.SetProperty(t => t.IsComplete, true));
    }
}
```

### FluentValidation Pattern Discovery

```csharp
public class CreatePersonValidation : AbstractValidator<CreatePersonDto>
{
    public CreatePersonValidation()
    {
        RuleFor(x => x.Name)
            .NotEmpty()
            .WithMessage("The field [name] cannot be empty or null");
    }
}
```

### Health Check Pattern Discovery

```csharp
public class RabbitMQHealthCheck : IHealthCheck
{
    private readonly Uri _uri;

    public RabbitMQHealthCheck(Uri uri)
    {
        ArgumentNullException.ThrowIfNull(uri);
        _uri = uri;
    }

    public async Task<HealthCheckResult> CheckHealthAsync(
        HealthCheckContext context,
        CancellationToken cancellationToken = default)
    {
        try
        {
            var factory = new ConnectionFactory { Uri = _uri };
            await using var connection = await factory.CreateConnectionAsync(cancellationToken);
            return HealthCheckResult.Healthy();
        }
        catch (Exception ex)
        {
            return new HealthCheckResult(context.Registration.FailureStatus, exception: ex);
        }
    }
}
```

## Fast Discovery Workflows

### Project Structure Exploration

```
1. Identify CliFx commands in src/Commands/
2. Locate API controllers in src/Controllers/V{n}/
3. Find Entity Framework models in src/Models.cs or src/Entities/
4. Discover CAP consumers in src/Consumers/
5. Locate Hangfire jobs in src/Jobs/
6. Identify health checks in src/Infra/HealthChecks/
```

### Component Relationship Mapping

```
1. Map StandardEntity inheritance hierarchy
2. Identify Entity Framework relationships and foreign keys
3. Trace CAP message flow from publishers to consumers
4. Map Hangfire job dependencies and enqueueing patterns
5. Identify validation chains and FluentValidation usage
```

### Configuration Discovery

```
1. Analyze appsettings.json for connection strings and configuration
2. Identify environment-specific settings and Docker configurations
3. Locate shared service registrations in ConfigureSharedServices
4. Map health check endpoints and monitoring configuration
5. Understand CORS policies and security configurations
```

## Quick Analysis Patterns

### Database Strategy Identification

- **SQL Server Pattern**: Entity Framework Core with SqlServer provider
- **MongoDB Pattern**: MongoDB.Driver with document-based models
- **Connection String Analysis**: Database provider detection and configuration
- **Migration Strategy**: EF Core migrations vs MongoDB schema-less approach

### Messaging Architecture Discovery

- **CAP + RabbitMQ**: Transactional outbox with SQL Server storage
- **Topic/Group Naming**: `[source].[domain].[event]` / `[app].[domain].[event]`
- **Consumer Auto-Discovery**: Ziggurat middleware and registration patterns
- **Message Validation**: FluentValidation integration with CAP pipeline

### Background Processing Analysis

- **Hangfire Integration**: SQL Server storage with dashboard configuration
- **Job Patterns**: Single-responsibility ExecuteAsync methods
- **Enqueueing Strategy**: Typed Enqueue<T> patterns in controllers
- **Job Parameters**: Serializable primitive types and DTOs only

### API Architecture Overview

- **Versioning Strategy**: V1, V2 namespaces and route patterns
- **Validation Pipeline**: FluentValidation with ModelValidationActionFilter
- **Response Patterns**: IActionResult with explicit status codes
- **Business Logic Placement**: Direct in controller actions (no service layer)

## Integration with Deeper Analysis

### Handoff to dotnet-analyzer

- **Complex Patterns**: Multi-step transaction flows, advanced Entity Framework queries
- **Performance Issues**: N+1 queries, bulk operations, memory usage
- **Security Analysis**: Authentication flows, authorization boundaries
- **Integration Patterns**: External API integrations, complex messaging flows

### Context for Documentation

- **Architecture Overview**: High-level system component relationships
- **API Documentation**: Controller action patterns and endpoint organization
- **Message Flow Documentation**: CAP consumer relationships and data flows
- **Deployment Architecture**: CliFx command deployment and scaling patterns

### Support for Library Validation

- **Package Discovery**: NuGet package usage and version analysis
- **Framework Identification**: .NET version, AspNetCore version detection
- **Dependency Analysis**: Project reference chains and package conflicts
- **Security Scanning**: Package vulnerability assessment support

---

*"Quickly understand your juntossomosmais .NET architecture and components"*
