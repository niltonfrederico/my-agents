# GitHub Copilot Agents & Skills System

A comprehensive ecosystem of specialized AI agents and reusable skills designed to accelerate development workflows across multiple technology stacks and project management tasks.

## Table of Contents

- [GitHub Copilot Agents \& Skills System](#github-copilot-agents--skills-system)
  - [Table of Contents](#table-of-contents)
  - [TL;DR Agent Usage](#tldr-agent-usage)
  - [TL;DR Update Script](#tldr-update-script)
  - [Overview](#overview)
    - [Key Features](#key-features)
  - [Available Agents](#available-agents)
    - [🐍 django-dev (Python/Django Developer)](#-django-dev-pythondjango-developer)
    - [⚙️ dotnet-dev (.NET/C# Developer)](#️-dotnet-dev-netc-developer)
    - [🔄 full-stack (Cross-Stack Analyzer)](#-full-stack-cross-stack-analyzer)
    - [📋 task-planner (Task Planning Specialist)](#-task-planner-task-planning-specialist)
    - [📚 doc-writer (Documentation Specialist)](#-doc-writer-documentation-specialist)
    - [🦸 saitama (Meta-Agent)](#-saitama-meta-agent)
  - [Complete Agent Directory](#complete-agent-directory)
    - [Core Agents (Primary Workflow)](#core-agents-primary-workflow)
    - [Specialized Agents (Domain Experts)](#specialized-agents-domain-experts)
  - [Skills Library](#skills-library)
    - [Django/Python Skills](#djangopython-skills)
    - [.NET/C# Skills](#netc-skills)
    - [Visualization Skills](#visualization-skills)
    - [Project Management Skills](#project-management-skills)
    - [Utility Skills](#utility-skills)
  - [How to Use](#how-to-use)
    - [Agent Selection Guidelines](#agent-selection-guidelines)
    - [Invocation Examples](#invocation-examples)
  - [Getting Started](#getting-started)
    - [Quick Start Examples](#quick-start-examples)
      - [1. Django Development Workflow](#1-django-development-workflow)
      - [2. .NET Development Workflow](#2-net-development-workflow)
      - [3. Full-Stack Integration](#3-full-stack-integration)
    - [Best Practices](#best-practices)
  - [Examples](#examples)
    - [Real-World Usage Scenarios](#real-world-usage-scenarios)
      - [Scenario 1: Django REST API Development](#scenario-1-django-rest-api-development)
      - [Scenario 2: .NET Microservices Architecture](#scenario-2-net-microservices-architecture)
      - [Scenario 3: Cross-Platform Integration](#scenario-3-cross-platform-integration)
    - [Agent Combinations](#agent-combinations)
  - [Advanced Features](#advanced-features)
    - [Skill Leveraging](#skill-leveraging)
    - [juntossomosmais Integration](#juntossomosmais-integration)
  - [Contributing](#contributing)

## TL;DR Agent Usage

**Quick Start:** Use `@agent-name` to invoke specialized agents for different tasks.

| Agent | Use Case | Example |
|-------|----------|---------|
| `@django-dev` | Django/Python development | `@django-dev Create a REST API for user management` |
| `@dotnet-dev` | .NET/C# development | `@dotnet-dev Build a microservice with Entity Framework` |
| `@full-stack` | Cross-platform analysis | `@full-stack Compare Django vs .NET for this project` |
| `@task-planner` | Project planning | `@task-planner Analyze this Monday.com task and create refinement` |
| `@doc-writer` | Documentation & diagrams | `@doc-writer Create API docs with Mermaid sequence diagrams` |
| `@saitama` | Complex problem solving | `@saitama Break down this complex architecture challenge` |

**Key Benefits:**

- ✅ **Specialized Expertise**: Each agent knows its domain deeply
- ✅ **Skill Leveraging**: Agents use 19+ specialized skills automatically  
- ✅ **Company Compliance**: Built-in juntossomosmais standards and Brazilian Agile
- ✅ **Cross-Stack**: Seamless Django/Python ↔ .NET/C# integration

## TL;DR Update Script

**One Command Installation:**

```bash
# Full installation with progress (recommended)
./update-copilot-agents.sh

# Quick silent installation  
./update-copilot-agents.sh --quick
```

**What It Does:**

- 🔄 Updates repository automatically
- 📂 Copies **12 agents** + **19 skills** + **10 instructions** to your `.copilot` directory
- 🛡️ Safe: Stashes local changes, handles errors gracefully
- 🌍 Cross-platform: macOS/Linux/Windows support
- ✅ Zero configuration needed

**Result:** Professional AI agent ecosystem ready in VS Code!

## Overview

This system provides a collection of specialized agents, each equipped with domain-specific skills and tools to handle complex development, documentation, and project management tasks. The agents leverage a shared skills library to provide consistent, high-quality assistance across different domains.

### Key Features

- **Specialized Agents**: Each agent is optimized for specific technology stacks or workflow types
- **Reusable Skills**: Modular skill system with 19+ specialized skills leveraged across agents
- **Company Integration**: Built-in compliance with juntossomosmais standards and Brazilian Agile frameworks  
- **Cross-Stack Support**: Seamless integration between Django/Python and .NET/C# environments
- **Professional Documentation**: Comprehensive technical writing and visualization capabilities
- **Complete Agent Ecosystem**: 12 specialized agents covering development, analysis, documentation, and planning

## Available Agents

### 🐍 django-dev (Python/Django Developer)

**Specialization**: Complete Django/Python development lifecycle

**USE FOR:**

- Django application development and architecture
- Python backend development and optimization
- Database modeling and migration strategies
- API development with Django REST Framework
- Performance optimization and debugging

**LEVERAGES:**

- `django-explorer`: Rapid Django project discovery and analysis
- `django-analyzer`: Deep architectural analysis and code quality assessment
- `django-documenter`: Comprehensive Django documentation generation
- `library-checker`: Python package security validation
- `r2d2-compliance-validator`: juntossomosmais standards compliance

**Tools**: Python environment, Django management, database tools, testing frameworks

---

### ⚙️ dotnet-dev (.NET/C# Developer)

**Specialization**: Enterprise .NET/C# development and architecture

**USE FOR:**

- .NET application development (Core, Framework, 5+)
- C# backend services and microservices architecture
- Entity Framework and database design
- ASP.NET Core web APIs and applications
- Performance optimization and enterprise patterns

**LEVERAGES:**

- `dotnet-explorer`: Rapid .NET solution discovery and structure analysis
- `dotnet-analyzer`: Deep architectural analysis and performance assessment
- `dotnet-documenter`: Comprehensive .NET technical documentation
- `dotnet-library-checker`: NuGet package analysis and compatibility validation
- `r2d2-compliance-validator`: Enterprise standards compliance

**Tools**: .NET CLI, NuGet management, Entity Framework tools, testing frameworks

---

### 🔄 full-stack (Cross-Stack Analyzer)

**Specialization**: Multi-technology integration and analysis

**USE FOR:**

- Cross-stack architecture analysis and planning
- Migration strategies between technology stacks
- Integration pattern design and implementation
- Technology stack comparison and evaluation
- Multi-platform development coordination

**LEVERAGES:**

- Both Django and .NET skills for comprehensive analysis
- `github-repository-investigator`: Cross-platform codebase analysis
- Integration analysis and architectural bridging capabilities
- Performance comparison across technology stacks
- `brazilian-agile-framework`: Agile methodology integration

**Tools**: Python environment, .NET CLI, integration testing, architecture analysis

---

### 📋 task-planner (Task Planning Specialist)

**Specialization**: Project management and strategic planning

**USE FOR:**

- Monday.com integration and task management
- Sprint planning and backlog refinement
- User story creation and task breakdown
- Project timeline estimation and resource allocation
- Agile ceremony facilitation and improvement

**LEVERAGES:**

- `monday-task-analyzer`: Advanced Monday.com workflow analysis
- `monday-refinement-generator`: Automated user story and task generation
- `brazilian-agile-framework`: Brazilian Agile methodology implementation
- `github-repository-investigator`: Repository analysis for planning
- Strategic planning and resource optimization skills

**Tools**: Monday.com API, project management interfaces, planning templates

---

### 📚 doc-writer (Documentation Specialist)

**Specialization**: Technical documentation and visual communication

**USE FOR:**

- API documentation with OpenAPI specifications
- System architecture documentation with visual diagrams
- User guides and technical tutorials
- Development onboarding documentation
- Performance analysis and HAR file visualization

**LEVERAGES:**

- `mermaid-flowchart`: System flow and decision tree visualization
- `mermaid-sequence`: API interaction and protocol documentation
- `mermaid-mindmap`: Knowledge organization and system hierarchies
- `har-analysis`: Network performance analysis and optimization guides
- `github-repository-investigator`: Code-based documentation accuracy

**Tools**: Mermaid diagram generation, interactive documentation, multi-format publishing

---

### 🦸 saitama (Meta-Agent)

**Specialization**: Agent creation and complexity management

**USE FOR:**

- Creating new specialized agents
- Complex problem decomposition and solution architecture
- Agent ecosystem optimization and coordination
- Advanced meta-programming and automation
- Breaking through development complexity barriers

**LEVERAGES:**

- All available skills across the ecosystem
- Agent creation patterns and successful templates
- Advanced problem-solving methodologies
- Cross-domain expertise integration
- Meta-analysis and system optimization capabilities

**Tools**: Agent creation templates, ecosystem analysis, meta-programming utilities

---

## Complete Agent Directory

### Core Agents (Primary Workflow)

| Agent | Specialization | Primary Use Case |
|-------|---------------|------------------|
| **@django-dev** | Python/Django Development | Backend APIs, Django architecture, Python optimization |
| **@dotnet-dev** | .NET/C# Development | Enterprise services, Entity Framework, ASP.NET Core |
| **@full-stack** | Cross-Stack Integration | Multi-platform analysis, migration planning, technology comparison |
| **@task-planner** | Project Management | Monday.com integration, sprint planning, agile workflows |
| **@doc-writer** | Technical Documentation | API docs, system documentation, Mermaid diagrams |
| **@saitama** | Meta-Agent & Complexity | Agent creation, complex problem solving, ecosystem management |

### Specialized Agents (Domain Experts)

| Agent | Specialization | Primary Use Case |
|-------|---------------|------------------|
| **@django-analyzer-agent** | Django Deep Analysis | Complex Django codebase investigation and optimization |
| **@django-explorer-agent** | Django Discovery | Fast Django project exploration and structure analysis |
| **@django-documenter-agent** | Django Documentation | Specialized Django technical documentation creation |
| **@dotnet-explorer-agent** | .NET Discovery | Rapid .NET solution exploration and architecture analysis |
| **@monday-analyzer-agent** | Monday.com Analysis | Advanced Monday.com workflow and project analysis |
| **@mermaid-specialist-agent** | Diagram Creation | Specialized Mermaid diagram generation and visualization |

**Total**: 12 agents providing comprehensive coverage across development, analysis, documentation, and project management workflows.

## Skills Library

### Django/Python Skills

| Skill | Purpose | Key Features |
|-------|---------|--------------|
| `django-explorer` | Project discovery | Rapid Django structure analysis, dependency mapping |
| `django-analyzer` | Code analysis | Architecture assessment, performance analysis, code quality |
| `django-documenter` | Documentation | API docs, model documentation, comprehensive guides |
| `library-checker` | Package validation | Python dependency security and compliance analysis |

### .NET/C# Skills

| Skill | Purpose | Key Features |
|-------|---------|--------------|
| `dotnet-explorer` | Solution discovery | Project structure analysis, dependency mapping |
| `dotnet-analyzer` | Code analysis | Architecture assessment, performance optimization |
| `dotnet-documenter` | Documentation | API documentation, architectural guides |
| `dotnet-library-checker` | Package analysis | NuGet compatibility, security analysis |

### Visualization Skills

| Skill | Purpose | Key Features |
|-------|---------|--------------|
| `mermaid-flowchart` | Process visualization | System flows, decision trees, process diagrams |
| `mermaid-sequence` | Interaction diagrams | API interactions, communication protocols |
| `mermaid-mindmap` | Knowledge organization | System hierarchies, concept mapping |

### Project Management Skills

| Skill | Purpose | Key Features |
|-------|---------|--------------|
| `monday-task-analyzer` | Task analysis | Monday.com workflow optimization |
| `monday-refinement-generator` | Story creation | Automated user story and task generation |
| `brazilian-agile-framework` | Agile methodology | Brazilian Agile practices integration |

### Utility Skills

| Skill | Purpose | Key Features |
|-------|---------|--------------|
| `github-repository-investigator` | Repository analysis | Accurate codebase investigation and documentation |
| `har-analysis` | Performance analysis | Network performance analysis and optimization |
| `r2d2-compliance-validator` | Standards compliance | juntossomosmais standards validation |

## How to Use

### Agent Selection Guidelines

**Choose django-dev when:**

- Working primarily with Python/Django applications
- Building REST APIs with Django REST Framework
- Database modeling and migration planning
- Django-specific performance optimization

**Choose dotnet-dev when:**

- Developing .NET applications (Core, Framework, 5+)
- Building enterprise C# applications
- Working with Entity Framework and SQL Server
- Implementing .NET-specific architectural patterns

**Choose full-stack when:**

- Planning integration between Django and .NET systems
- Evaluating technology stack decisions
- Migrating between technology platforms
- Analyzing cross-platform architectural concerns

**Choose task-planner when:**

- Managing projects with Monday.com
- Planning sprints and breaking down epics
- Coordinating team workflows and processes
- Implementing Brazilian Agile methodologies

**Choose doc-writer when:**

- Creating comprehensive technical documentation
- Generating API documentation and guides
- Creating system architecture diagrams
- Analyzing performance and creating optimization guides

**Choose saitama when:**

- Creating new specialized agents
- Solving complex, multi-domain problems
- Breaking through particularly challenging development obstacles
- Need comprehensive analysis across multiple skill domains

### Invocation Examples

```markdown
# Invoke specific agent
@django-dev help me optimize this Django application performance

# Agent with specific task
@dotnet-dev create a microservices architecture for this e-commerce system

# Cross-stack analysis
@full-stack analyze the integration points between our Django API and .NET client applications

# Documentation request
@doc-writer create comprehensive API documentation with interactive examples

# Task planning
@task-planner break down this epic into manageable user stories for our sprint

# Meta-agent for complex problems
@saitama help me architect a solution that bridges our Django backend with .NET services while maintaining optimal performance
```

## Getting Started

### Quick Start Examples

#### 1. Django Development Workflow

```markdown
@django-dev analyze my Django project structure and suggest improvements
@django-dev help me implement JWT authentication with Django REST Framework
@doc-writer create API documentation for my Django REST endpoints
```

#### 2. .NET Development Workflow

```markdown
@dotnet-dev review my ASP.NET Core architecture for scalability issues
@dotnet-dev help me implement Entity Framework Core with PostgreSQL
@doc-writer generate comprehensive documentation for my .NET microservices
```

#### 3. Full-Stack Integration

```markdown
@full-stack analyze the communication patterns between my Django API and .NET client
@doc-writer create integration documentation with sequence diagrams
@task-planner plan the migration of authentication from Django to a shared service
```

### Best Practices

1. **Start Specific**: Choose the most specialized agent for your primary technology stack
2. **Leverage Documentation**: Use `@doc-writer` to document solutions and architectural decisions
3. **Plan First**: Use `@task-planner` for complex projects to break down work appropriately
4. **Cross-Reference**: Use `@full-stack` when working with multiple technology stacks
5. **Meta-Analysis**: Use `@saitama` when facing unprecedented challenges or creating new patterns

## Examples

### Real-World Usage Scenarios

#### Scenario 1: Django REST API Development

```markdown
# Initial analysis
@django-dev analyze this Django project and identify performance bottlenecks

# Implementation
@django-dev help me implement caching and database query optimization

# Documentation
@doc-writer create comprehensive API documentation with OpenAPI specification

# Project management
@task-planner create user stories for the remaining optimization tasks
```

#### Scenario 2: .NET Microservices Architecture

```markdown
# Architecture analysis
@dotnet-dev review this microservices architecture for enterprise patterns

# Cross-service communication
@full-stack analyze the communication patterns between these .NET services

# Performance optimization
@doc-writer analyze the HAR files and create performance optimization recommendations

# Implementation planning
@task-planner break down the microservices refactoring into sprint-sized tasks
```

#### Scenario 3: Cross-Platform Integration

```markdown
# Integration analysis
@full-stack evaluate the integration points between Django and .NET applications

# Implementation strategy
@saitama design a comprehensive solution for authentication across both platforms

# Documentation
@doc-writer create integration documentation with sequence diagrams and flow charts

# Project coordination
@task-planner coordinate the development tasks across Django and .NET teams
```

### Agent Combinations

**For Complex Projects:**

- Use `@full-stack` for initial analysis
- Follow with specialized agents (`@django-dev` or `@dotnet-dev`) for implementation
- Use `@doc-writer` for comprehensive documentation
- Use `@task-planner` for project coordination

**For New Feature Development:**

- Start with `@task-planner` for planning and breakdown
- Use specialized agents for implementation
- Use `@doc-writer` for feature documentation
- Use `@saitama` for complex architectural decisions

**For Performance Optimization:**

- Use `@doc-writer` for performance analysis (HAR files)
- Use specialized agents for platform-specific optimizations
- Use `@full-stack` for cross-platform performance considerations
- Document improvements with `@doc-writer`

## Advanced Features

### Skill Leveraging

Each agent can leverage skills from the shared library, enabling:

- **Code Quality**: Automated code analysis and improvement suggestions
- **Documentation**: Comprehensive technical documentation generation
- **Visualization**: Interactive diagrams and system architecture visualization
- **Integration**: Cross-platform compatibility and integration analysis
- **Compliance**: Built-in compliance with juntossomosmais standards

### juntossomosmais Integration

All agents include built-in support for:

- **r2d2 Compliance**: Automated validation against company standards
- **Brazilian Agile Framework**: Integrated agile methodology support
- **StandardEntity/StandardModelMixin**: Consistent entity modeling across platforms
- **CAP/STOMP Implementation**: Company architectural pattern compliance

## Contributing

When creating new agents or extending existing ones:

1. **Follow Naming Convention**: Use descriptive, function-based names
2. **Include Compliance**: Always integrate `r2d2-compliance-validator` and `brazilian-agile-framework`
3. **Leverage Existing Skills**: Use the shared skills library for consistency
4. **Document Thoroughly**: Include comprehensive USE FOR and LEVERAGES sections
5. **Test Integration**: Ensure new agents work well with the existing ecosystem

---

*Last updated: March 2026*  
*Agent ecosystem designed for comprehensive development workflow acceleration*
