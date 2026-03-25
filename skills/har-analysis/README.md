# HAR Analysis Skill

Expert HTTP Archive file analysis with automated Mermaid diagram generation.

## Overview

This skill provides comprehensive analysis of HAR (HTTP Archive) files exported from browser developer tools, combining performance analysis, API debugging, security assessment, and visual diagram generation.

## Quick Start

1. **Export HAR file** from Chrome/Firefox/Safari developer tools (Network tab → right-click → Save as HAR)
2. **Load the file** and ask questions like:
   - "Analyze this HAR file for performance issues"
   - "Show me all failed requests and generate a sequence diagram"
   - "Create a mindmap of security findings"

## Key Capabilities

### 🚀 Performance Analysis

- Load time breakdown and critical path identification
- Core Web Vitals calculation (LCP, FID, CLS)
- Resource waterfall analysis
- Third-party service impact assessment

### 🔧 API Debugging  

- Request/response pattern analysis
- Error categorization and root cause identification
- Authentication flow visualization
- Rate limiting and retry pattern detection

### 🔒 Security Assessment

- Security header analysis (HSTS, CSP, etc.)
- Cookie security attribute validation
- Mixed content detection
- Certificate and TLS configuration review

### 📊 Mermaid Integration

- **Sequence Diagrams**: API flows, authentication sequences
- **Flowcharts**: Error handling, decision trees
- **Mindmaps**: Performance insights, security findings

## File Structure

```
har-analysis/
├── SKILL.md              # Main skill definition and capabilities
├── templates/
│   ├── analysis-template.md    # Usage examples and workflows
│   └── example.har            # Sample HAR file for testing
└── README.md             # This file
```

## Example Queries

### General Analysis

```
"What performance issues do you see in this HAR file?"
"Summarize the network activity and key findings"
"Generate a comprehensive analysis report"
```

### Specific Investigation

```
"Show me all requests that took longer than 2 seconds"
"What's causing the 504 errors?"
"Which third-party services are impacting load time?"
"Are there any security vulnerabilities in the headers?"
```

### Mermaid Generation

```
"Create a sequence diagram of the user authentication flow"
"Generate a flowchart showing error handling patterns"
"Make a mindmap organizing all performance bottlenecks"
"Show the API call sequence as a diagram"
```

## Integration with Other Skills

This skill automatically invokes:

- `mermaid-flowchart` for process and decision visualization
- `mermaid-sequence` for request/response flow diagrams  
- `mermaid-mindmap` for organizing complex findings
- Standard validation and preview tools for diagram quality

## Usage Tips

### Best HAR Collection Practices

1. Clear browser cache before recording
2. Use incognito/private mode to avoid cache interference
3. Record complete page load cycles (navigation → onLoad event)
4. Capture both desktop and mobile scenarios when relevant

### Analysis Workflow

1. Start with high-level performance metrics
2. Drill into specific problem areas (errors, slow requests)
3. Generate appropriate visualizations for findings
4. Cross-reference with server logs when available

### Diagram Selection Guide

- **Sequence**: Request/response flows, authentication, API interactions
- **Flowchart**: Error handling logic, decision trees, conditional flows  
- **Mindmap**: Performance breakdown, security findings, service categorization

## Technical Details

### Supported HAR Versions

- HAR 1.2 specification (standard)
- Chrome, Firefox, Safari, Edge exported files
- Handles large files (>100MB) efficiently

### Analysis Metrics

- Timing breakdown (DNS, connect, SSL, send, wait, receive)
- Content analysis (MIME types, compression, sizes)  
- Security headers and cookie attributes
- Cache behavior (before/after request states)
- Certificate and TLS details

### Output Formats

- Structured analysis reports
- Performance recommendations
- Security finding summaries
- Interactive Mermaid diagrams
- Actionable optimization suggestions

---

*Transform network data into actionable insights with automated analysis and visualization*
