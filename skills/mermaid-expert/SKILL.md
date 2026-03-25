---
skill: true
name: "mermaid-expert"
description: "**MERMAID DIAGRAM EXPERT** — Comprehensive Mermaid diagram creation skill supporting flowcharts, sequence diagrams, mindmaps, and advanced diagram types. USE FOR: system architecture visualization; process flow documentation; technical communication; knowledge organization; API interaction mapping; decision tree visualization; project planning diagrams; troubleshooting flowcharts; component relationship mapping. CREATES: syntactically correct Mermaid diagrams with proper validation; interactive diagrams with clickable elements; styled diagrams with themes and colors; complex multi-type diagram combinations; technical documentation integration. TECH FOCUS: Always considers technical contexts like APIs, databases, services, error states, authentication flows, system dependencies, and architectural patterns."
applyTo:
  - "**/*.md"
  - "**/*.mmd"
  - "**/README.md"
  - "**/docs/**/*"
  - "**/api/**/*"
  - "**/architecture/**/*"
  - "**/planning/**/*"
invokes:
  - "mermaid-diagram-validator"
  - "mermaid-diagram-preview"
  - "vscode_askQuestions"
  - "get-syntax-docs-mermaid"
---

# Mermaid Diagram Expert Skill

*Comprehensive Mermaid diagram creation with technical focus*

## Purpose

This skill provides complete Mermaid diagramming expertise, combining flowchart, sequence diagram, mindmap, and advanced diagram capabilities into a unified, powerful visualization tool. Designed specifically for technical documentation, system design, and software development workflows with deep understanding of all Mermaid diagram types.

## CRITICAL REQUIREMENTS (March 2026 Anti-Hallucination)

### STOP Conditions (MANDATORY)

```python
# When diagram requirements are unclear, STOP and ask user
if diagram_requirements_unclear():
    questions = [{
        "header": "diagram_clarification",
        "question": "🎨 Requerimentos do diagrama Mermaid não estão claros. Que tipo de diagrama criar?",
        "options": [
            {"label": "Fluxograma de processo/sistema", "value": "flowchart"},
            {"label": "Diagrama de sequência (interações)", "value": "sequence"},
            {"label": "Mapa mental/hierárquico", "value": "mindmap"},
            {"label": "Diagrama customizado", "value": "custom"}
        ],
        "allowFreeformInput": True
    }]
    user_response = vscode_askQuestions(questions)
    diagram_type = user_response["diagram_clarification"]

# When technical context is missing, STOP and gather context
if technical_context_missing():
    raise SkillExecutionStop(
        reason="TECHNICAL_CONTEXT_MISSING",
        message="🚫 STOP: Contexto técnico insuficiente para diagrama preciso.\n\n❓ Favor fornecer: arquitetura, componentes, fluxos ou dados específicos a visualizar.",
        user_action_required=True
    )

# When Mermaid syntax validation fails, STOP and fix
if mermaid_syntax_invalid():
    raise SkillExecutionStop(
        reason="MERMAID_SYNTAX_ERROR",
        message="🚫 STOP: Sintaxe Mermaid inválida detectada.\n\n❓ Revisar sintaxe ou simplificar complexidade do diagrama?",
        user_action_required=True
    )
```

### Ask-User Pattern (MANDATORY)

- **ALWAYS clarify diagram type** when multiple options possible
- **ALWAYS ask for technical context** when system details unclear
- **ALWAYS validate syntax** before finalizing diagrams via mermaid-diagram-validator

## Core Diagram Types

### Flowchart Excellence

- **System Architecture**: Service interactions, component relationships
- **Process Flows**: Algorithm logic, deployment pipelines, CI/CD workflows
- **Decision Trees**: Conditional logic, branching scenarios, error handling
- **User Journeys**: Authentication flows, API request paths, integration patterns
- **Database Operations**: CRUD flows, transaction sequences, optimization paths

### Sequence Diagram Mastery

- **API Communications**: REST/GraphQL interactions, microservice communications
- **Authentication Flows**: OAuth, JWT, multi-factor authentication sequences
- **Database Transactions**: Complex query sequences, transaction management
- **Message Queue Patterns**: STOMP, RabbitMQ, real-time communication protocols
- **Error Scenarios**: Exception handling, retry mechanisms, fallback procedures

### Mindmap Organization

- **Technology Stacks**: Framework selection, tool evaluation hierarchies
- **System Architecture**: Component hierarchies, dependency relationships
- **Feature Planning**: Epic → Story → Task decomposition structures
- **Learning Paths**: Skill progression, certification tracks, knowledge trees
- **Troubleshooting**: Problem → Diagnosis → Solution hierarchies

### Advanced Diagram Types

- **Git Graphs**: Branch strategies, merge patterns, release workflows
- **Gantt Charts**: Project timelines, milestone tracking, resource planning
- **Entity Relationship**: Database schema, relationship modeling
- **Class Diagrams**: Object-oriented design, inheritance patterns
- **State Diagrams**: Application state management, workflow states

## Comprehensive Syntax Mastery

### Flowchart Syntax Excellence

```mermaid
flowchart TD
    %% Modern syntax with advanced features
    A[Start: API Request] --> B{Authentication}
    B -->|Valid Token| C[Process Request]
    B -->|Invalid| D[Return 401]
    C --> E{Data Validation}
    E -->|Valid| F[Business Logic]
    E -->|Invalid| G[Return 400]
    F --> H[Database Operation]
    H --> I{Success?}
    I -->|Yes| J[Return 200]
    I -->|No| K[Return 500]

    %% Styling and theming
    classDef success fill:#d4edda,stroke:#28a745
    classDef error fill:#f8d7da,stroke:#dc3545
    classDef process fill:#cce5ff,stroke:#007bff

    class J success
    class D,G,K error
    class C,F,H process

    %% Clickable elements
    click A "https://api-docs.example.com/auth" "Authentication Documentation"
    click F "https://business-logic.example.com" "Business Logic Guide"
```

### Sequence Diagram Advanced Patterns

```mermaid
sequenceDiagram
    participant C as Client
    participant A as API Gateway
    participant S as Service
    participant D as Database
    participant Q as Message Queue

    Note over C,Q: Authentication & Processing Flow

    C->>+A: POST /api/auth
    A->>+S: Validate Credentials
    S->>+D: Query User
    D-->>-S: User Data
    S-->>-A: JWT Token
    A-->>-C: 200 OK + Token

    rect rgb(240, 248, 255)
        Note over C,Q: Authenticated Request Processing
        C->>+A: GET /api/data (Bearer Token)
        A->>A: Validate JWT

        alt Token Valid
            A->>+S: Process Request
            S->>+D: Query Data
            D-->>-S: Results
            S->>Q: Audit Event
            S-->>-A: Response Data
            A-->>-C: 200 OK + Data
        else Token Invalid
            A-->>C: 401 Unauthorized
        end
    end

    Note over Q: Async processing continues
    Q->>Q: Process Audit Event
```

### Mindmap Hierarchical Excellence

```mermaid
mindmap
  root)Technology Stack Planning(
    Frontend
      Framework
        React
          Next.js
          Vite
        Vue
          Nuxt.js
          Quasar
      State Management
        Redux Toolkit
        Zustand
        Pinia
      UI Components
        Material-UI
        Tailwind CSS
        Ant Design
    Backend
      Python
        Django
          DRF
          Channels
        FastAPI
          Pydantic
          SQLAlchemy
      .NET
        ASP.NET Core
          Minimal APIs
          SignalR
        Entity Framework
          Code First
          Database First
      Node.js
        Express.js
        NestJS
    Database
      SQL
        PostgreSQL
        SQL Server
      NoSQL
        MongoDB
        Redis
      Search
        Elasticsearch
        Solr
```

## Tech-Specific Patterns

### API Architecture Flowchart

```mermaid
flowchart LR
    subgraph "Client Layer"
        WEB[Web Client]
        MOB[Mobile App]  
        API_CLI[API Client]
    end

    subgraph "API Gateway"
        GW[Gateway/LB]
        AUTH[Auth Service]
        RATE[Rate Limiting]
    end

    subgraph "Microservices"
        USER[User Service]
        PROD[Product Service]
        ORDER[Order Service]
        PAY[Payment Service]
    end

    subgraph "Data Layer"
        SQL[(SQL Database)]
        NOSQL[(NoSQL Store)]
        CACHE[(Redis Cache)]
        QUEUE[Message Queue]
    end

    WEB --> GW
    MOB --> GW
    API_CLI --> GW

    GW --> AUTH
    GW --> RATE
    GW --> USER
    GW --> PROD
    GW --> ORDER

    USER --> SQL
    PROD --> NOSQL
    ORDER --> SQL
    PAY --> QUEUE

    USER -.-> CACHE
    PROD -.-> CACHE

    %% Styling
    classDef client fill:#e1f5fe,stroke:#0277bd
    classDef gateway fill:#f3e5f5,stroke:#6a1b9a  
    classDef service fill:#e8f5e8,stroke:#2e7d32
    classDef data fill:#fff3e0,stroke:#ef6c00

    class WEB,MOB,API_CLI client
    class GW,AUTH,RATE gateway
    class USER,PROD,ORDER,PAY service
    class SQL,NOSQL,CACHE,QUEUE data
```

### Database Migration Sequence

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant CLI as Migration CLI
    participant DB as Database
    participant APP as Application
    participant MON as Monitoring

    Note over Dev,MON: Database Migration Process

    Dev->>CLI: Create Migration
    CLI->>DB: Analyze Current Schema
    DB-->>CLI: Schema Information
    CLI->>CLI: Generate Migration Script
    CLI-->>Dev: Migration File Created

    Dev->>Dev: Review Migration
    Dev->>CLI: Run Migration (Dry Run)
    CLI->>DB: Simulate Changes
    DB-->>CLI: Validation Results
    CLI-->>Dev: Preview Output

    rect rgb(255, 248, 220)
        Note over Dev,MON: Production Deployment
        Dev->>CLI: Deploy Migration
        CLI->>APP: Stop Application
        CLI->>DB: Create Backup
        DB-->>CLI: Backup Complete

        CLI->>DB: Execute Migration
        DB-->>CLI: Migration Success
        CLI->>DB: Verify Schema
        DB-->>CLI: Verification OK

        CLI->>APP: Start Application
        APP->>DB: Test Connections
        DB-->>APP: Connections OK

        CLI->>MON: Send Success Event
    end

    Note over MON: Post-deployment monitoring
```

### System Planning Mindmap

```mermaid
mindmap
  root))Microservices Architecture((
    Design Patterns
      API Gateway
        Load Balancing
        Rate Limiting
        Authentication
      Service Discovery
        Consul
        Eureka
        Kubernetes DNS
      Circuit Breaker
        Hystrix
        Resilience4j
        Istio
    Communication
      Synchronous
        REST APIs
          OpenAPI/Swagger
          GraphQL
        gRPC
          Protocol Buffers
          Streaming
      Asynchronous
        Message Queues
          RabbitMQ
          Apache Kafka
        Event Sourcing
          Event Store
          CQRS
    Data Management
      Database per Service
        SQL Databases
        NoSQL Stores
      Data Consistency
        Saga Pattern
        Two-Phase Commit
        Event-Driven
      Caching Strategy
        Application Cache
        Distributed Cache
        CDN
    Deployment
      Containerization
        Docker
        Container Orchestration
      Cloud Platforms
        Kubernetes
        Docker Swarm
        Cloud Services
      CI/CD Pipeline
        Source Control
        Build Automation
        Testing Strategy
```

## Integration Guidelines

### For Django Applications

```python
# Django view with Mermaid documentation
class APIEndpointView(APIView):
    """
    API endpoint with comprehensive Mermaid documentation.

    Flow Diagram:
    ```mermaid
    flowchart TD
        A[HTTP Request] --> B{Authentication}
        B -->|Valid| C[Validate Input]
        B -->|Invalid| D[Return 401]
        C -->|Valid| E[Process Business Logic]
        C -->|Invalid| F[Return 400]
        E --> G[Database Query]
        G --> H[Return Response]
    ```
    """

    def post(self, request):
        # Implementation with documented flow
        pass
```

### For .NET Applications

```csharp
/// <summary>
/// Order processing command with sequence diagram documentation.
///
/// Sequence Diagram:
/// ```mermaid
/// sequenceDiagram
///     participant C as Client
///     participant A as API
///     participant S as OrderService  
///     participant D as Database
///  
///     C->>A: CreateOrder Request
///     A->>S: ProcessOrder Command
///     S->>D: Save Order
///     D-->>S: Order Saved
///     S-->>A: Success Response
///     A-->>C: 201 Created
/// ```
/// </summary>
[Command("order create")]
public class CreateOrderCommand : ICommand
{
    // Command implementation
}
```

### For Documentation Integration

```markdown
# System Architecture

## Overview Diagram

The following flowchart shows our system architecture:

```mermaid
flowchart TB
    Users --> WebApp
    Users --> MobileApp
    WebApp --> API
    MobileApp --> API
    API --> Database
    API --> MessageQueue
```

## Authentication Flow

User authentication follows this sequence:

```mermaid
sequenceDiagram
    User->>Frontend: Login Request
    Frontend->>Backend: POST /auth/login
    Backend->>Database: Validate User
    Database-->>Backend: User Data
    Backend-->>Frontend: JWT Token
    Frontend-->>User: Login Success
```

## Feature Planning

Current development priorities:

```mermaid
mindmap
  root)Sprint Planning(
    Current Sprint
      User Authentication
      API Security  
      Database Migration
    Next Sprint
      Payment Integration
      Email Notifications
      Performance Optimization
    Backlog
      Mobile App
      Admin Dashboard
      Analytics Integration
```

## Best Practices

### Diagram Organization

- **Single Responsibility**: Each diagram focuses on one concept or flow
- **Clear Naming**: Participants and nodes have descriptive names
- **Consistent Styling**: Use consistent colors and themes across projects
- **Interactive Elements**: Add click events for navigation to detailed documentation
- **Comments**: Use notes and comments to clarify complex interactions

### Technical Integration

- **Code Documentation**: Embed diagrams in code comments and docstrings
- **README Integration**: Use diagrams to explain project structure and flows
- **API Documentation**: Include sequence diagrams for API interaction patterns
- **Architecture Documentation**: Maintain up-to-date system architecture diagrams

### Advanced Features

- **Subgraphs**: Group related components for complex systems
- **Styling**: Apply consistent visual themes across diagram types
- **Linking**: Connect diagrams to external documentation and resources
- **Validation**: Always validate syntax before including in documentation

## Common Use Cases

### Development Workflow

1. **Planning Phase**: Create mindmaps for feature breakdown
2. **Design Phase**: Use flowcharts for algorithm design  
3. **Implementation**: Add sequence diagrams for API interactions
4. **Documentation**: Generate comprehensive visual documentation
5. **Maintenance**: Update diagrams as system evolves

### Team Communication

- **Architecture Reviews**: Visual system overviews
- **Code Reviews**: Flow diagrams for complex logic
- **Sprint Planning**: Feature breakdown mindmaps
- **Incident Response**: Error flow diagrams for troubleshooting
- **Onboarding**: System overview for new team members

### Quality Assurance

- **Test Planning**: Flow diagrams for test scenarios
- **Bug Analysis**: Sequence diagrams for error reproduction
- **Performance Analysis**: System load flow visualization
- **Security Review**: Authentication and authorization flows
- **Deployment Planning**: Infrastructure and deployment workflows

## Validation & Testing

All diagrams created by this skill are automatically validated using:

- **Syntax Validation**: `mermaid-diagram-validator` for syntax correctness
- **Visual Preview**: `mermaid-diagram-preview` for rendering verification
- **Integration Testing**: Verification in target documentation systems
- **Accessibility**: Proper alt-text and screen reader compatibility
- **Performance**: Optimized rendering for complex diagrams

## Advanced Examples

### Complex Enterprise Architecture

```mermaid
graph TB
    subgraph "External Systems"
        EXT1[Payment Gateway]
        EXT2[Email Service]
        EXT3[Analytics Platform]
    end

    subgraph "Load Balancer Layer"
        LB[Load Balancer]
    end

    subgraph "API Gateway Layer"
        GW1[API Gateway 1]
        GW2[API Gateway 2]
    end

    subgraph "Application Layer"
        APP1[App Server 1]
        APP2[App Server 2]
        APP3[App Server 3]
    end

    subgraph "Service Layer"
        SVC1[User Service]
        SVC2[Order Service]
        SVC3[Payment Service]
        SVC4[Notification Service]
    end

    subgraph "Data Layer"
        DB1[(Primary DB)]
        DB2[(Read Replica)]
        CACHE[(Redis Cache)]
        QUEUE[Message Queue]
    end

    Users --> LB
    LB --> GW1
    LB --> GW2
    GW1 --> APP1
    GW1 --> APP2
    GW2 --> APP2
    GW2 --> APP3

    APP1 --> SVC1
    APP2 --> SVC2
    APP3 --> SVC3
    APP1 --> SVC4

    SVC1 --> DB1
    SVC2 --> DB1
    SVC1 --> DB2
    SVC2 --> DB2
    SVC1 --> CACHE
    SVC2 --> CACHE

    SVC3 --> EXT1
    SVC4 --> EXT2
    SVC4 --> QUEUE

    QUEUE --> EXT3

    classDef external fill:#ffebee,stroke:#c62828
    classDef infrastructure fill:#e8f5e8,stroke:#2e7d32
    classDef application fill:#e3f2fd,stroke:#1565c0
    classDef data fill:#fff8e1,stroke:#ef6c00

    class EXT1,EXT2,EXT3 external
    class LB,GW1,GW2 infrastructure
    class APP1,APP2,APP3,SVC1,SVC2,SVC3,SVC4 application
    class DB1,DB2,CACHE,QUEUE data
```

This comprehensive Mermaid Expert skill consolidates all diagram types into a single, powerful visualization capability while maintaining the specialized knowledge and technical focus that makes each diagram type effective for software development and system design.
