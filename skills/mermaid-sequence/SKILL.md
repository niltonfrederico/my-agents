---
skill: true
name: "mermaid-sequence"  
description: "**MERMAID SEQUENCE EXPERT** — Specialized skill for creating tech-focused Mermaid sequence diagrams showing interactions and communications. USE FOR: API call sequences; microservice communications; user authentication flows; database transaction sequences; distributed system interactions; message queue patterns; real-time communication protocols; event-driven architectures; async operation flows; integration patterns. CREATES: syntactically correct sequence diagrams with proper participant definitions; complex interaction patterns with loops, alternatives, and parallel sections; detailed message flows with timing constraints; error scenarios and exception handling. TECH FOCUS: Emphasizes system boundaries, timeouts, retries, failure modes, and scalability considerations."
applyTo:
  - "**/*.md"
  - "**/*.mmd"
  - "**/README.md"
  - "**/docs/**/*"
  - "**/api/**/*"
invokes:
  - "mermaid-diagram-validator"
  - "mermaid-diagram-preview"
  - "vscode_askQuestions"
  - "get-syntax-docs-mermaid"
---

# Mermaid Sequence Diagram Skill

*Tech-focused sequence diagrams for system interactions*

## Purpose

This skill specializes in creating Mermaid sequence diagrams that clearly illustrate complex technical interactions, API communications, and system behaviors over time. Perfect for documenting distributed systems, microservice architectures, and integration patterns.

## Core Capabilities

### Sequence Diagram Types Supported
- **API Interactions**: REST, GraphQL, gRPC communications
- **Microservice Flows**: Service-to-service messaging
- **Authentication Sequences**: OAuth, JWT, SAML flows
- **Database Transactions**: ACID operations, distributed transactions
- **Message Queue Patterns**: Pub/sub, event streaming
- **WebSocket Communications**: Real-time bidirectional flows
- **Integration Patterns**: ESB, event sourcing, CQRS
- **Error Handling**: Timeout scenarios, circuit breaker patterns

### Mermaid Sequence Syntax Mastery

#### Basic Structure
```mermaid
sequenceDiagram
    participant A as Client
    participant B as Server
    A->>B: Request 
    B-->>A: Response
```

#### Participant Types
```mermaid
sequenceDiagram
    participant Client
    actor User
    participant API as API Gateway
    participant Auth as Auth Service
    database DB as PostgreSQL
```

#### Arrow Types & Meanings
- `->>` : Solid arrow (synchronous call)
- `-->>` : Dashed arrow (response/return)
- `-x` : Solid arrow with X (lost message)
- `--x` : Dashed arrow with X (lost response)  
- `-)` : Solid arrow with open circle (async call)
- `--)` : Dashed arrow with open circle (async response)

#### Advanced Features
```mermaid
sequenceDiagram
    participant A
    participant B
    
    Note over A,B: System Initialization
    
    loop Every 5 seconds
        A->>B: Health Check
        B-->>A: OK
    end
    
    alt Success Path
        A->>B: Process Request
        B-->>A: Success Response
    else Error Path  
        A->>B: Process Request
        B-->>A: Error Response
        A->>A: Log Error
    end
    
    par Parallel Processing
        A->>B: Task 1
    and
        A->>B: Task 2
    end
```

### Tech-Specific Patterns

#### REST API Authentication Flow
```mermaid
sequenceDiagram
    participant Client
    participant Gateway as API Gateway
    participant Auth as Auth Service
    participant Resource as Resource Service
    participant DB as Database
    
    Client->>Gateway: POST /auth/login
    Gateway->>Auth: Validate Credentials
    Auth->>DB: Check User
    DB-->>Auth: User Data
    Auth-->>Gateway: JWT Token
    Gateway-->>Client: 200 + JWT
    
    Note over Client: Store JWT Token
    
    Client->>Gateway: GET /api/resource (Bearer Token)
    Gateway->>Auth: Validate JWT
    Auth-->>Gateway: Token Valid
    Gateway->>Resource: Process Request
    Resource->>DB: Query Data
    DB-->>Resource: Result Set
    Resource-->>Gateway: JSON Response
    Gateway-->>Client: 200 + Data
```

#### Microservice Communication with Circuit Breaker
```mermaid
sequenceDiagram
    participant UI as Frontend
    participant Order as Order Service
    participant Payment as Payment Service
    participant Inventory as Inventory Service
    participant CB as Circuit Breaker
    
    UI->>Order: Create Order
    Order->>CB: Check Payment Service Health
    
    alt Circuit Closed (Healthy)
        CB->>Payment: Process Payment
        Payment-->>CB: Payment Success
        CB-->>Order: Payment Confirmed
        Order->>Inventory: Reserve Items
        Inventory-->>Order: Items Reserved
        Order-->>UI: Order Created
    else Circuit Open (Unhealthy)
        CB-->>Order: Service Unavailable
        Order->>Order: Queue for Later Processing
        Order-->>UI: Order Pending (Async Processing)
    end
```

#### Event-Driven Architecture with Message Queue
```mermaid
sequenceDiagram
    participant Producer as Event Producer
    participant Queue as Message Queue
    participant Consumer1 as Email Service
    participant Consumer2 as Analytics Service  
    participant Consumer3 as Audit Service
    
    Producer->>Queue: Publish User.Registered Event
    
    Note over Queue: Event stored and distributed
    
    par Parallel Consumption
        Queue->>Consumer1: User.Registered Event
        Consumer1->>Consumer1: Send Welcome Email
    and
        Queue->>Consumer2: User.Registered Event  
        Consumer2->>Consumer2: Track Registration Metric
    and
        Queue->>Consumer3: User.Registered Event
        Consumer3->>Consumer3: Log Audit Trail
    end
    
    Consumer1-->>Queue: Ack
    Consumer2-->>Queue: Ack
    Consumer3-->>Queue: Ack
```

#### Database Transaction with Rollback
```mermaid
sequenceDiagram
    participant App as Application
    participant DB as Database
    participant Cache as Redis Cache
    
    App->>DB: BEGIN TRANSACTION
    App->>DB: INSERT user_account
    DB-->>App: Success
    App->>DB: INSERT user_profile
    DB-->>App: Success
    App->>DB: UPDATE account_balance
    
    alt Transaction Success
        DB-->>App: Success
        App->>DB: COMMIT
        DB-->>App: Transaction Committed
        App->>Cache: Update User Cache
        Cache-->>App: Cache Updated
    else Constraint Violation
        DB-->>App: Error: Insufficient Balance
        App->>DB: ROLLBACK
        DB-->>App: Transaction Rolled Back
        App->>App: Log Transaction Failure
    end
```

#### WebSocket Real-time Communication
```mermaid
sequenceDiagram
    participant Client
    participant Server
    participant DB as Database
    participant Queue as Message Queue
    
    Client->>Server: WebSocket Handshake
    Server-->>Client: Connection Established
    
    Note over Client,Server: Real-time communication active
    
    Client->>Server: Subscribe to Channel "orders"
    Server->>Queue: Subscribe to Order Events
    Queue-->>Server: Subscription Confirmed
    
    Note over DB: External order created
    DB->>Queue: Publish Order.Created Event
    Queue->>Server: Order.Created Event
    Server->>Client: WebSocket Message: New Order
    
    Client->>Server: Unsubscribe from "orders"
    Server->>Queue: Unsubscribe from Order Events
    Queue-->>Server: Unsubscription Confirmed
    
    Client->>Server: Close Connection
    Server-->>Client: Connection Closed
```

#### Distributed System with Saga Pattern
```mermaid
sequenceDiagram
    participant Orchestrator as Saga Orchestrator
    participant Order as Order Service
    participant Payment as Payment Service
    participant Inventory as Inventory Service
    participant Shipping as Shipping Service
    
    Orchestrator->>Order: Create Order
    Order-->>Orchestrator: Order Created (ID: 123)
    
    Orchestrator->>Payment: Charge Payment (Order: 123)
    Payment-->>Orchestrator: Payment Success (ID: 456)
    
    Orchestrator->>Inventory: Reserve Items (Order: 123)
    
    alt Inventory Available
        Inventory-->>Orchestrator: Items Reserved (ID: 789)
        Orchestrator->>Shipping: Schedule Delivery (Order: 123)
        Shipping-->>Orchestrator: Delivery Scheduled
    else Inventory Unavailable  
        Inventory-->>Orchestrator: Insufficient Inventory
        Note over Orchestrator: Compensation Required
        Orchestrator->>Payment: Refund Payment (ID: 456)
        Payment-->>Orchestrator: Payment Refunded
        Orchestrator->>Order: Cancel Order (ID: 123)
        Order-->>Orchestrator: Order Cancelled
    end
```

## Best Practices

### Technical Accuracy
- Use proper HTTP status codes and method names
- Include realistic error scenarios and timeouts
- Show both synchronous and asynchronous patterns
- Represent database transactions accurately
- Include security considerations (tokens, encryption)

### Documentation Standards
- Define all participants clearly at the top
- Use meaningful participant aliases
- Add notes for complex logic sections
- Group related interactions with boxes
- Show timing constraints where relevant

### Performance Considerations
- Highlight potential bottlenecks
- Show caching strategies
- Include retry and circuit breaker patterns
- Document async vs sync trade-offs
- Consider scalability implications

## Integration Guidelines

### API Documentation
- Include in OpenAPI/Swagger specifications
- Show complete request/response cycles
- Document error handling patterns
- Illustrate authentication flows

### Architecture Documentation  
- Use in system design documents
- Include in technical specifications
- Add to integration guides
- Document for troubleshooting guides

### Development Workflow
- Include in code reviews for complex features
- Use in debugging sessions
- Add to incident post-mortems
- Document for onboarding new developers

## Validation & Testing

Always validate your sequence diagrams:
1. **Syntax validation**: Ensure proper Mermaid syntax
2. **Logic verification**: Check message flow accuracy  
3. **Error path coverage**: Include failure scenarios
4. **Performance review**: Consider timing implications
5. **Security audit**: Verify no sensitive data exposure

---

*"Sequence diagrams reveal the hidden conversations between systems"*