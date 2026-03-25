# HAR Analysis Template

This template demonstrates how to use the HAR analysis skill for comprehensive network traffic analysis.

## Quick Analysis Commands

### Performance Analysis

```
"Analyze this HAR file for performance bottlenecks"
"What's causing slow load times in this HAR?"
"Show me the critical rendering path from this network data"
"Generate a performance mindmap from this HAR file"
```

### API Debugging  

```
"Find all failed API requests in this HAR"
"Show me the authentication flow sequence"
"What's the pattern of 5xx errors?"
"Create a sequence diagram of the user login process"
```

### Security Audit

```
"Check this HAR file for security issues"
"Are there any insecure cookies or headers?"
"Find mixed content violations"
"Generate a security findings mindmap"
```

### Mermaid Generation

```
"Create a sequence diagram from the main API calls"
"Generate a flowchart showing the error handling patterns"
"Make a mindmap of all third-party services and their performance"
```

## Example Analysis Output

### Performance Summary

- **Total Requests**: 127 requests
- **Total Size**: 8.9 MB  
- **Load Time**: 3.2 seconds
- **Largest Contentful Paint**: 2.1 seconds
- **Critical Path Length**: 4 resources

### Top Issues Found

1. **Render-blocking CSS**: 850ms delay (3 files)
2. **Oversized Images**: 12 images >1MB without compression  
3. **Third-party Scripts**: Google Analytics adding 800ms
4. **Failed Requests**: 8 requests with 504 timeouts
5. **Mixed Content**: 5 HTTP resources on HTTPS page

### Generated Mermaid Diagrams

- Sequence diagram of authentication flow
- Performance bottleneck mindmap
- Error handling flowchart

## HAR File Structure Reference

```json
{
  "log": {
    "version": "1.2",
    "creator": {"name": "Chrome", "version": "120.0"},
    "pages": [
      {
        "startedDateTime": "2024-03-24T10:30:00Z",
        "id": "page_1",
        "title": "Example App",
        "pageTimings": {
          "onContentLoad": 1200,
          "onLoad": 3200
        }
      }
    ],
    "entries": [
      {
        "startedDateTime": "2024-03-24T10:30:00Z",
        "time": 245,
        "request": {
          "method": "GET",
          "url": "https://api.example.com/user",
          "headers": [...],
          "cookies": [...]
        },
        "response": {
          "status": 200,
          "statusText": "OK",
          "headers": [...],
          "content": {...}
        },
        "timings": {
          "dns": 12,
          "connect": 45,
          "ssl": 30,
          "send": 2,
          "wait": 120,
          "receive": 36
        }
      }
    ]
  }
}
```

## Common Analysis Workflows

### 1. Initial Performance Triage

1. Load HAR file and validate structure
2. Calculate basic metrics (total time, requests, size)
3. Identify top 5 slowest requests
4. Generate performance overview mindmap
5. Create recommendations list

### 2. API Error Investigation  

1. Filter for 4xx/5xx status codes
2. Group errors by endpoint and type
3. Analyze error timing patterns
4. Generate sequence diagram of failed flows
5. Create error handling flowchart

### 3. Security Review

1. Check HTTPS usage and mixed content
2. Analyze security headers (HSTS, CSP, etc.)
3. Review cookie security attributes
4. Check for sensitive data in URLs/responses
5. Generate security findings mindmap

### 4. Third-Party Service Audit

1. Identify all external domains
2. Calculate performance impact per service
3. Check for privacy/tracking concerns
4. Analyze blocking vs async loading patterns
5. Create service comparison chart

## Best Practices

### HAR File Collection

- Clear cache before recording
- Record from incognito/private mode
- Include full page load cycle
- Capture both desktop and mobile scenarios
- Record during peak and off-peak times

### Analysis Approach

- Start with high-level metrics first
- Focus on user-impacting issues
- Consider mobile vs desktop differences  
- Cross-reference with real user metrics
- Validate findings with server logs

### Mermaid Diagram Selection

- **Sequence**: For request/response flows, authentication
- **Flowchart**: For error handling, decision trees
- **Mindmap**: For organizing findings, performance metrics

### Reporting Guidelines

- Include both technical details and business impact
- Prioritize issues by user experience impact
- Provide specific, actionable recommendations
- Include before/after metrics when possible
- Document assumptions and limitations

---

*Use this template as a starting point for HAR analysis projects*
