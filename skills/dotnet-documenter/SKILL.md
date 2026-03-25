---

name: "dotnet-documenter"
description: "**DOTNET TECHNICAL DOCUMENTER** — Specialized skill for creating comprehensive markdown documentation of juntossomosmais .NET/C# applications with integrated Mermaid diagrams. USE FOR: architectural documentation; API documentation with workflow diagrams; CliFx command documentation; Entity Framework model documentation; CAP messaging flow documentation; Hangfire job documentation; integration documentation; onboarding guides; technical specifications; deployment documentation; troubleshooting guides. PROVIDES: professional markdown documentation; integrated Mermaid diagrams (flowcharts, sequence, architecture); code examples and patterns; architectural decision records; comprehensive API documentation; deployment guides. JUNTOSSOMOSMAIS FOCUS: Documents StandardEntity patterns, CliFx command architecture, CAP messaging flows, Entity Framework Core configurations, Hangfire background processing, FluentValidation patterns, and ASP.NET Core security following company documentation standards."
---

# .NET Technical Documenter Skill

*Professional technical documentation with integrated diagrams for juntossomosmais .NET applications*

## Purpose

This skill creates comprehensive, professional documentation for .NET/C# applications, integrating visual diagrams with detailed technical content. Designed to work with `dotnet-explorer` and `dotnet-analyzer` to create complete project documentation following juntossomosmais standards.

## Core Capabilities

### Documentation Types

- **Architectural Documentation**: CliFx command structure, Entity Framework design, CAP messaging architecture
- **API Documentation**: Controller specifications, authentication flows, request/response examples
- **Business Logic Documentation**: Complex workflows, validation rules, background job processing
- **Integration Documentation**: External services, messaging patterns, health check systems
- **Deployment Documentation**: Environment setup, configuration, CliFx command deployment
- **Troubleshooting Guides**: Common issues, debugging procedures, error resolution

### Visual Integration

- **Architecture Diagrams**: CliFx commands, Entity Framework relationships, service interactions
- **Sequence Diagrams**: API request flows, CAP messaging sequences, background job processing
- **Flowcharts**: Business logic, validation chains, error handling flows
- **Mindmaps**: Knowledge organization, troubleshooting guides, feature planning
- **Technical Diagrams**: Database schemas, message flows, deployment architecture

### Content Generation

- **Code Examples**: Controller patterns, Entity Framework usage, CAP consumer implementation
- **Configuration Guides**: appsettings.json setup, connection strings, environment configuration
- **API Specifications**: Complete endpoint documentation with examples and validation rules
- **Architectural Decisions**: ADR format documentation with rationale and implications
- **Onboarding Documentation**: Developer guides, setup procedures, workflow explanations

## juntossomosmais Documentation Patterns

### CliFx Command Architecture Documentation

#### ApiCommand Documentation

````markdown
# API Command Architecture

## Command Structure

The `ApiCommand` serves as the primary entry point for the web API, implementing the CliFx pattern for command-line interface management.

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
            // Shared services registration
            services.ConfigureSharedServices(_configuration);

            // Hangfire for background jobs
            services.AddHangfire(config => config.UseSqlServerStorage(connectionString));
            services.AddHangfireServer();

            // FluentValidation for request validation
            services.AddScoped<IValidator<CreatePersonDto>, CreatePersonValidation>();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            // Health check endpoints
            app.UseHealthChecks("/api/healthcheck/liveness");
            app.UseHealthChecks("/api/healthcheck/readiness");
            app.UseHealthChecks("/api/healthcheck/integrations");
        }
    }
}
```

## Command Flow Architecture
```mermaid
flowchart TD
    A[dotnet run api] --> B[ApiCommand.ExecuteAsync]
    B --> C[Program.CreateHostBuilder]
    C --> D[ApiCommand.Startup]
    D --> E[ConfigureServices]
    D --> F[Configure Pipeline]

    E --> G[ConfigureSharedServices]
    E --> H[Add Hangfire]
    E --> I[Add Controllers]
    E --> J[Add FluentValidation]

    F --> K[Health Checks]
    F --> L[CORS Policy]
    F --> M[Swagger/OpenAPI]
    F --> N[Controller Routing]

    style A fill:#e1f5fe
    style D fill:#e8f5e8
    style G fill:#fff3e0
```
````

#### WorkerCommand Documentation

````markdown
# Worker Command Architecture

## Consumer Host Pattern

The `WorkerCommand` hosts CAP message consumers, implementing auto-discovery and registration patterns.

```csharp
[Command("worker")]
public class WorkerCommand : ICommand
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.ConfigureSharedServices(_configuration);

            // FluentValidation for message DTOs
            services.AddScoped<IValidator<OrderCreatedMessage>, OrderCreatedMessageValidation>();

            // Auto-discovered consumer registration
            CurrentEntry?.Register(services);
        }
    }
}
```

## Consumer Auto-Discovery Flow
```mermaid
sequenceDiagram
    participant CLI as dotnet run worker
    participant WC as WorkerCommand
    participant AD as Auto-Discovery
    participant ZM as Ziggurat Middleware
    participant CH as Consumer Handler

    CLI->>WC: Start with --topic-name
    WC->>AD: Scan assembly for consumers
    AD->>AD: Find IConsumerService<T> implementations
    AD->>WC: Register matched consumer
    WC->>ZM: Configure pipeline middlewares
    Note over ZM: 1. MessageValidation<br/>2. EntityFrameworkIdempotency
    ZM->>CH: Route validated message
    CH->>CH: Process business logic
```
````

### CAP Messaging Documentation

#### Transactional Outbox Pattern Documentation

````markdown
# CAP Messaging - Transactional Outbox Pattern

## Implementation

The CAP framework provides transactional outbox pattern implementation, ensuring message delivery guarantees alongside database operations.

```csharp
public class OrderService
{
    private readonly AppDbContext _context;
    private readonly ICapPublisher _capBus;

    public async Task CreateOrderAsync(CreateOrderDto dto)
    {
        using var transaction = await _context.Database.BeginTransactionAsync();

        // Create order in database
        var order = new Order { /* properties */ };
        _context.Orders.Add(order);

        // Publish message within same transaction
        await _capBus.PublishAsync("order.created", new OrderCreatedMessage
        {
            OrderId = order.Id.ToString(),
            CustomerId = order.CustomerId,
            MessageId = Guid.NewGuid().ToString(),
            MessageGroup = "order-processing"
        });

        await _context.SaveChangesAsync();
        await transaction.CommitAsync();
    }
}
```

## Transactional Outbox Flow
```mermaid
sequenceDiagram
    participant API as API Controller
    participant DB as SQL Server Database
    participant CAP as CAP Outbox Table
    participant RMQ as RabbitMQ
    participant Consumer as Message Consumer

    API->>DB: BEGIN TRANSACTION
    API->>DB: INSERT Order
    API->>CAP: INSERT Message (same transaction)
    API->>DB: COMMIT TRANSACTION

    Note over CAP: Background Publisher Process
    CAP->>RMQ: Publish Message
    CAP->>CAP: Mark as Published

    RMQ->>Consumer: Deliver Message
    Consumer->>Consumer: Process via Ziggurat Pipeline
```
````

#### Consumer Pattern Documentation

````markdown
# CAP Consumer Implementation Pattern

## Consumer Structure

All CAP consumers follow a standardized pattern with rigid outer class and flexible handler implementation.

```csharp
public class OrderCreatedConsumer : ICapSubscribe
{
    private readonly IConsumerService<OrderCreatedMessage> _consumerService;

    public OrderCreatedConsumer(IConsumerService<OrderCreatedMessage> consumerService)
        => _consumerService = consumerService;

    [CapSubscribe(Topics.OrderCreated, Group = Groups.OrderProcessing)]
    public async Task HandleAsync(OrderCreatedMessage message)
        => await _consumerService.ProcessMessageAsync(message);

    public class Handler : IConsumerService<OrderCreatedMessage>
    {
        private readonly AppDbContext _context;
        private readonly ICapPublisher _capBus;

        public Handler(AppDbContext context, ICapPublisher capBus)
        {
            _context = context;
            _capBus = capBus;
        }

        public async Task ProcessMessageAsync(OrderCreatedMessage message)
        {
            // Idempotency handled by Ziggurat middleware
            var order = await _context.Orders
                .FirstOrDefaultAsync(o => o.Id == message.OrderId);

            if (order == null) return; // Already processed

            // Complex business logic
            await ProcessOrderValidation(order);
            await PublishSubsequentEvents(order);

            await _context.SaveChangesAsync();
        }
    }
}
```

## Consumer Middleware Pipeline
```mermaid
flowchart TD
    A[Message Received] --> B[MessageValidationMiddleware]
    B --> C{Validation Passed?}
    C -->|No| D[Log Error & Reject]
    C -->|Yes| E[EntityFrameworkIdempotency]
    E --> F{Already Processed?}
    F -->|Yes| G[Skip Processing]
    F -->|No| H[Consumer.Handler.ProcessMessageAsync]
    H --> I[Business Logic Execution]
    I --> J[Mark as Processed]

    style A fill:#e1f5fe
    style B fill:#fff3e0
    style E fill:#e8f5e8
    style H fill:#f3e5f5
```
````

### Entity Framework Documentation

#### StandardEntity Pattern Documentation

````markdown
# Entity Framework - StandardEntity Pattern

## Base Entity Implementation

All entities inherit from `StandardEntity`, providing consistent audit fields and automatic timestamp management.

```csharp
public abstract class StandardEntity
{
    public int Id { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}

public class Order : StandardEntity
{
    public string CustomerName { get; set; }
    public decimal Amount { get; set; }
    public OrderStatus Status { get; set; }

    // Navigation properties
    public ICollection<OrderItem> Items { get; set; }
}
```

## DbContext Configuration

```csharp
public class AppDbContext : DbContext
{
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Entity configurations
        modelBuilder.Entity<Order>(entity =>
        {
            entity.Property(e => e.CustomerName)
                .IsRequired()
                .HasMaxLength(100);

            entity.HasMany(e => e.Items)
                .WithOne(e => e.Order)
                .HasForeignKey(e => e.OrderId);
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

## Entity Lifecycle Diagram
```mermaid
flowchart LR
    A[Entity Created] --> B[Set CreatedAt]
    B --> C[Set UpdatedAt]
    C --> D[Save to Database]

    E[Entity Modified] --> F[Update UpdatedAt]
    F --> G[Save Changes]

    H[Entity Queried] --> I{Include .AsNoTracking()?}
    I -->|Yes| J[No Change Tracking]
    I -->|No| K[Track for Updates]

    style A fill:#e8f5e8
    style E fill:#fff3e0
    style H fill:#e1f5fe
```
````

### Hangfire Job Documentation

#### Background Job Pattern Documentation

````markdown
# Hangfire Background Jobs

## Job Implementation Pattern

All Hangfire jobs follow a consistent pattern with single responsibility and dependency injection.

```csharp
namespace DotNetTemplate.Jobs;

public class OrderProcessingJob
{
    private readonly AppDbContext _context;
    private readonly ICapPublisher _capBus;
    private readonly ILogger<OrderProcessingJob> _logger;

    public OrderProcessingJob(
        AppDbContext context,
        ICapPublisher capBus,
        ILogger<OrderProcessingJob> logger)
    {
        _context = context;
        _capBus = capBus;
        _logger = logger;
    }

    public async Task ExecuteAsync(int orderId, OrderProcessingOptions options)
    {
        try
        {
            var order = await _context.Orders
                .Include(o => o.Items)
                .FirstOrDefaultAsync(o => o.Id == orderId);

            if (order == null)
            {
                _logger.LogWarning("Order {OrderId} not found for processing", orderId);
                return;
            }

            await ProcessOrderLogic(order, options);

            // Publish completion event
            await _capBus.PublishAsync("order.processed", new OrderProcessedMessage
            {
                OrderId = order.Id.ToString(),
                ProcessedAt = DateTime.UtcNow,
                MessageId = Guid.NewGuid().ToString()
            });

            await _context.SaveChangesAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to process order {OrderId}", orderId);
            throw; // Hangfire will handle retries
        }
    }
}
```

## Job Enqueueing Pattern

```csharp
[ApiController]
[Route("v1/[controller]")]
public class OrderController : ControllerBase
{
    private readonly IBackgroundJobClient _backgroundJobs;

    [HttpPost("{id}/process")]
    public async Task<IActionResult> ProcessOrderAsync(int id, [FromBody] ProcessOrderRequest request)
    {
        // Enqueue background job
        var jobId = _backgroundJobs.Enqueue<OrderProcessingJob>(
            job => job.ExecuteAsync(id, request.ToOptions()));

        return Accepted(new { jobId });
    }
}
```

## Job Processing Flow
```mermaid
sequenceDiagram
    participant Client as API Client
    participant Controller as OrderController
    participant Hangfire as Hangfire Queue
    participant Job as OrderProcessingJob
    participant DB as Database
    participant CAP as CAP Publisher

    Client->>Controller: POST /v1/orders/123/process
    Controller->>Hangfire: Enqueue OrderProcessingJob
    Controller-->>Client: 202 Accepted {jobId}

    Note over Hangfire: Background Processing
    Hangfire->>Job: Execute job with DI resolution
    Job->>DB: Load order and items
    Job->>Job: Process business logic
    Job->>CAP: Publish order.processed event
    Job->>DB: Save changes
    Job-->>Hangfire: Job completed
```
````

## Advanced Documentation Features

### CliFx Command Deployment Documentation

````markdown
# Deployment Architecture

## Command Deployment Strategy

Each CliFx command is deployed independently, allowing for scalable and maintainable service architecture.

```bash
# API Server Deployment
dotnet DotNetTemplate.dll api

# Consumer Worker Deployment (per topic)
dotnet DotNetTemplate.dll worker --topic-name order.created
dotnet DotNetTemplate.dll worker --topic-name payment.completed

# Data Seeding
dotnet DotNetTemplate.dll seed --environment Production
```

## Deployment Architecture Diagram
```mermaid
flowchart TD
    subgraph "Load Balancer"
        LB[NGINX/ALB]
    end

    subgraph "API Tier"
        API1[API Instance 1<br/>dotnet app.dll api]
        API2[API Instance 2<br/>dotnet app.dll api]
    end

    subgraph "Worker Tier"
        W1[Worker 1<br/>topic: order.created]
        W2[Worker 2<br/>topic: payment.completed]
        W3[Worker 3<br/>topic: notification.send]
    end

    subgraph "Infrastructure"
        DB[(SQL Server Database)]
        RMQ[RabbitMQ Message Broker]
        REDIS[(Redis Cache)]
    end

    LB --> API1
    LB --> API2

    API1 --> DB
    API2 --> DB
    API1 --> RMQ
    API2 --> RMQ

    RMQ --> W1
    RMQ --> W2
    RMQ --> W3

    W1 --> DB
    W2 --> DB
    W3 --> DB

    style API1 fill:#e1f5fe
    style API2 fill:#e1f5fe
    style W1 fill:#e8f5e8
    style W2 fill:#e8f5e8
    style W3 fill:#e8f5e8
```
````

### Health Check System Documentation

````markdown
# Health Check System

## Health Check Endpoints

The application provides multiple health check endpoints for different monitoring scenarios.

### Liveness Check
- **Endpoint**: `/api/healthcheck/liveness`
- **Purpose**: Determines if the application is running
- **Checks**: Basic application responsiveness
- **Usage**: Kubernetes liveness probes, basic monitoring

### Readiness Check  
- **Endpoint**: `/api/healthcheck/readiness`
- **Purpose**: Determines if the application can handle requests
- **Checks**: Critical dependencies (database, essential services)
- **Usage**: Kubernetes readiness probes, load balancer health

### Integration Check
- **Endpoint**: `/api/healthcheck/integrations`
- **Purpose**: Complete dependency health assessment
- **Checks**: All external dependencies (database, RabbitMQ, external APIs)
- **Usage**: Comprehensive monitoring, troubleshooting

## Custom Health Check Implementation

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
            await using var channel = await connection.CreateChannelAsync(cancellationToken: cancellationToken);
            return HealthCheckResult.Healthy("RabbitMQ connection successful");
        }
        catch (Exception ex)
        {
            return new HealthCheckResult(
                context.Registration.FailureStatus,
                exception: ex,
                description: "RabbitMQ connection failed");
        }
    }
}
```

## Health Check Flow Diagram
```mermaid
flowchart TD
    A[Health Check Request] --> B{Check Type}

    B -->|liveness| C[Basic Application Status]
    B -->|readiness| D[Critical Dependencies]
    B -->|integrations| E[All Dependencies]

    D --> F[SQL Server Check]
    E --> F
    E --> G[RabbitMQ Check]
    E --> H[External API Check]

    F --> I{All Critical Healthy?}
    G --> J{All Integration Healthy?}
    H --> J

    C --> K[200 OK - Healthy]
    I -->|Yes| K
    I -->|No| L[503 Service Unavailable]
    J -->|Yes| K
    J -->|No| L

    style A fill:#e1f5fe
    style K fill:#e8f5e8
    style L fill:#ffebee
```
````

## Documentation Templates

### API Controller Template

````markdown
# [Controller Name] API Documentation

## Controller Overview
- **Route**: `v1/[controller]`
- **Authentication**: Required
- **Authorization**: [Specify policies]

## Endpoints

### Create [Resource]
- **Method**: `POST`
- **Route**: `/v1/[controller]`
- **Request Body**: `Create[Resource]Dto`
- **Response**: `201 Created` with created resource
- **Validation**: `Create[Resource]Validation`

#### Request Example
```json
{
  "name": "Example Resource",
  "description": "Resource description",
  "amount": 100.50
}
```

#### Response Example
```json
{
  "id": 123,
  "name": "Example Resource",
  "description": "Resource description",
  "amount": 100.50,
  "createdAt": "2024-03-24T10:30:00Z",
  "updatedAt": "2024-03-24T10:30:00Z"
}
```

## Implementation Flow
```mermaid
sequenceDiagram
    participant Client
    participant Controller as [Resource]Controller
    participant Validator as FluentValidation
    participant DbContext as AppDbContext
    participant CAP as CAP Publisher

    Client->>Controller: POST /v1/[controller]
    Controller->>Validator: Validate Create[Resource]Dto
    Validator-->>Controller: Validation Result
    Controller->>DbContext: Create new entity
    Controller->>CAP: Publish [resource].created event
    Controller->>DbContext: SaveChangesAsync
    Controller-->>Client: 201 Created
```

## Error Responses

### Validation Errors (400)
```json
{
  "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
  "title": "One or more validation errors occurred.",
  "status": 400,
  "errors": {
    "Name": ["The field [name] cannot be empty or null"]
  }
}
```
````

### CAP Consumer Template

````markdown
# [Event] Consumer Documentation

## Consumer Overview
- **Topic**: `[source].[domain].[event]`
- **Group**: `[app].[domain].[event]`
- **Auto-Discovery**: ✅ Enabled
- **Validation**: `[Event]MessageValidation`

## Message Schema

### [Event]Message
```csharp
public class [Event]Message : IMessage
{
    public string EntityId { get; set; }
    public DateTime EventTime { get; set; }
    public [EventData] Data { get; set; }

    // Required by IMessage
    public string MessageId { get; set; }
    public string MessageGroup { get; set; }
}
```

## Business Logic

### Handler Implementation
```csharp
public class Handler : IConsumerService<[Event]Message>
{
    private readonly AppDbContext _context;
    private readonly ICapPublisher _capBus;

    public async Task ProcessMessageAsync([Event]Message message)
    {
        // Idempotency automatically handled by Ziggurat

        // Load related entities
        var entity = await _context.[Entities]
            .FirstOrDefaultAsync(e => e.Id == message.EntityId);

        if (entity == null)
        {
            _logger.LogWarning("Entity {EntityId} not found", message.EntityId);
            return;
        }

        // Process business logic
        await ProcessBusinessRule(entity, message.Data);

        // Publish subsequent events if needed
        await _capBus.PublishAsync("subsequent.event", new SubsequentEventMessage
        {
            // Event data
        });

        await _context.SaveChangesAsync();
    }
}
```

## Processing Flow
```mermaid
flowchart TD
    A[Message Received] --> B[MessageValidationMiddleware]
    B --> C{Valid?}
    C -->|No| D[Log & Reject]
    C -->|Yes| E[IdempotencyMiddleware]
    E --> F{Already Processed?}
    F -->|Yes| G[Skip Processing]
    F -->|No| H[Handler.ProcessMessageAsync]
    H --> I[Load Entity]
    I --> J[Apply Business Logic]
    J --> K[Publish Events]
    K --> L[Save Changes]
    L --> M[Mark Processed]

    style A fill:#e1f5fe
    style H fill:#e8f5e8
    style M fill:#e8f5e8
```
````

## Integration with juntossomosmais Infrastructure

### Documentation Standards

- **Consistent Structure**: Hierarchical organization with standardized section headers
- **Code Examples**: Real implementation patterns from dotnet-template
- **Visual Diagrams**: Mermaid integration for complex flow documentation
- **Troubleshooting**: Common issues and resolution procedures
- **Deployment Guidance**: CliFx command deployment and scaling strategies

### Quality Assurance

- **Technical Accuracy**: Code examples validated against working implementations
- **Visual Clarity**: Mermaid diagrams for complex architectural concepts
- **Practical Examples**: Real-world scenarios and usage patterns
- **Maintenance Process**: Version control integration and regular updates
- **Cross-Reference Validation**: Consistent linking between related documentation

---

*"Transform complex juntossomosmais .NET architecture into clear, actionable documentation"*
