---
skill: true
name: "mermaid-flowchart"
description: "**MERMAID FLOWCHART EXPERT** — Specialized skill for creating tech-focused Mermaid flowcharts and process diagrams. USE FOR: system architecture diagrams; code flow visualization; decision trees; deployment workflows; CI/CD pipelines; user journey mapping; algorithm visualization; microservices interactions; error handling flows; database relationships. CREATES: syntactically correct Mermaid flowchart code with proper validation; interactive diagrams with clickable elements; styled diagrams with colors and themes; complex multi-directional flows; subgraphs for modular design. TECH FOCUS: Always considers technical contexts like APIs, databases, services, error states, authentication flows, and system dependencies."
applyTo:
  - "**/*.md"
  - "**/*.mmd" 
  - "**/README.md"
  - "**/docs/**/*"
invokes:
  - "mermaid-diagram-validator"
  - "mermaid-diagram-preview"
---

# Mermaid Flowchart Skill

*Tech-focused flowchart creation with official Mermaid syntax*

## Purpose

This skill specializes in creating Mermaid flowcharts specifically for technical documentation, system design, and software development workflows. It combines official Mermaid syntax with best practices for visualizing complex technical processes.

## Core Capabilities

### Flowchart Types Supported
- **System Architecture**: Service interactions, component relationships
- **Code Flow**: Algorithm logic, function call sequences  
- **Decision Trees**: Conditional logic, branching scenarios
- **Deployment Pipelines**: CI/CD workflows, release processes
- **User Journeys**: Authentication flows, API request paths
- **Error Handling**: Exception flows, fallback mechanisms
- **Database Operations**: CRUD flows, transaction sequences

### Mermaid Syntax Mastery

#### Basic Structure
```mermaid
flowchart TD
    A[Start] --> B{Decision?}
    B -->|Yes| C[Process A]
    B -->|No| D[Process B]
    C --> E[End]
    D --> E
```

#### Direction Options
- `TD` / `TB` - Top to Bottom
- `BT` - Bottom to Top  
- `LR` - Left to Right
- `RL` - Right to Left

#### Node Shapes & Meanings
```mermaid
flowchart LR
    A[Rectangle - Process/Action]
    B(Rounded - Start/End Points)
    C{Diamond - Decision Point}
    D[(Database)]
    E[[Subroutine/Module]]
    F[/Parallelogram - Input\/]/
    G[\Inverted Parallelogram - Output\]
    H((Circle - Connector))
```

#### Advanced Features
- **Subgraphs**: Group related components
- **Styling**: Colors, themes, custom CSS
- **Links**: Clickable elements with URLs
- **Icons**: FontAwesome integration
- **Comments**: Documentation within diagrams

### Tech-Specific Patterns

#### API Request Flow
```mermaid
flowchart TD
    Client[Client App] --> API[API Gateway]
    API --> Auth{Authentication}
    Auth -->|Valid| Service[Microservice]
    Auth -->|Invalid| Error401[401 Unauthorized]
    Service --> DB[(Database)]
    DB --> Response[JSON Response]
    Response --> Client
    Error401 --> Client
```

#### CI/CD Pipeline
```mermaid
flowchart LR
    subgraph "Development"
        Code[Code Commit] --> PR[Pull Request]
    end
    
    subgraph "CI Pipeline"
        PR --> Tests[Run Tests]
        Tests --> Build[Build Artifact]
        Build --> Security[Security Scan]
    end
    
    subgraph "Deployment"
        Security --> Staging[Deploy Staging]
        Staging --> Approve{Manual Approval}
        Approve -->|Yes| Prod[Deploy Production]
        Approve -->|No| Rollback[Rollback]
    end
```

#### Error Handling Flow
```mermaid
flowchart TD
    Request[API Request] --> Validate{Valid Input?}
    Validate -->|No| BadRequest[400 Bad Request]
    Validate -->|Yes| Process[Process Request]
    Process --> DBCall{Database Call}
    DBCall -->|Success| Success[200 OK]
    DBCall -->|Connection Error| Retry{Retry < 3?}
    DBCall -->|Data Error| ServerError[500 Internal Error]
    Retry -->|Yes| Process
    Retry -->|No| Timeout[408 Timeout]
```

## Best Practices

### Technical Accuracy
- Use standard HTTP status codes in error flows
- Include proper authentication/authorization steps
- Show database transactions and rollback scenarios
- Represent async operations clearly
- Include monitoring and logging touchpoints

### Visual Design
- Group related processes in subgraphs
- Use consistent color schemes for similar components
- Add meaningful labels to decision points
- Include timing information for critical paths
- Show both happy path and error scenarios

### Documentation Integration
- Always validate syntax before sharing
- Include diagram descriptions in surrounding text
- Link to related technical documentation
- Version control diagram sources
- Consider accessibility in color choices

## Common Use Cases

### 1. Microservices Architecture
```mermaid
flowchart TB
    subgraph "Client Layer"
        Web[Web App]
        Mobile[Mobile App]
    end
    
    subgraph "API Gateway"
        Gateway[Kong/Nginx]
    end
    
    subgraph "Services"
        Auth[Auth Service]
        User[User Service] 
        Order[Order Service]
        Payment[Payment Service]
    end
    
    subgraph "Data Layer"
        UserDB[(User DB)]
        OrderDB[(Order DB)]
        Cache[(Redis Cache)]
    end
    
    Web --> Gateway
    Mobile --> Gateway
    Gateway --> Auth
    Gateway --> User
    Gateway --> Order
    Order --> Payment
    User --> UserDB
    Order --> OrderDB
    Auth --> Cache
```

### 2. Authentication Flow
```mermaid
flowchart TD
    User[User Login] --> Credentials{Valid Credentials?}
    Credentials -->|No| LoginError[Login Failed]
    Credentials -->|Yes| MFA{MFA Enabled?}
    MFA -->|No| JWT[Generate JWT]
    MFA -->|Yes| MFAPrompt[MFA Challenge]
    MFAPrompt --> MFAValid{MFA Valid?}
    MFAValid -->|No| MFAError[MFA Failed]
    MFAValid -->|Yes| JWT
    JWT --> Success[Login Success]
    LoginError --> User
    MFAError --> User
```

### 3. Database Migration Process
```mermaid
flowchart LR
    Start[Migration Start] --> Backup[Create Backup]
    Backup --> Lock[Lock Tables]
    Lock --> Validate{Schema Valid?}
    Validate -->|No| Unlock[Unlock Tables]
    Validate -->|Yes| Apply[Apply Migration]
    Apply --> Test{Migration Test}
    Test -->|Fail| Rollback[Rollback Changes]
    Test -->|Pass| Unlock2[Unlock Tables]
    Unlock --> Start
    Rollback --> Restore[Restore Backup]
    Restore --> Start
    Unlock2 --> Complete[Migration Complete]
```

## Validation & Preview

Always use the built-in Mermaid tools:
1. **Validate syntax**: Ensure error-free diagrams
2. **Preview rendering**: Check visual appearance  
3. **Test interactivity**: Verify clickable elements
4. **Accessibility check**: Confirm proper contrast and labeling

## Integration Guidelines

- Place flowcharts in technical documentation alongside code examples
- Use in architecture decision records (ADRs)
- Include in API documentation for request flows
- Add to runbooks for operational procedures
- Embed in code reviews for complex logic explanation

---

*"Clear diagrams prevent unclear implementations"*