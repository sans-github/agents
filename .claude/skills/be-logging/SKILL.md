---
name: be-logging
description: Backend logging conventions for Java/Spring Boot -- structured JSON output, MDC correlation IDs, access vs application log separation, Splunk/Datadog compatible format, and per-layer logging guidance. Use when implementing or reviewing any logging in the backend.
---

# Backend Logging Conventions

## Logging stack

- **Abstraction:** SLF4J (`org.slf4j.Logger`) -- always code against the abstraction, never against the implementation directly.
- **Implementation:** Logback (Spring Boot default) or Log4j2. Do not use log4j v1 -- it is deprecated and unsupported.
- **Format:** Structured JSON. JSON is natively parsed by Splunk HEC, Datadog, Cloudwatch Logs Insights, and Loki without custom extraction rules. Do not use plain-text appenders in non-local environments.

## Log output separation

Two distinct log outputs, each with its own file and appender:

| Log | What it captures | File |
|-----|-----------------|------|
| **Access log** | HTTP layer -- every inbound request/response (method, URI, status, duration, remote IP) | `logs/access.log` |
| **Application log** | Everything else -- service logic, errors, DB calls, external calls | `logs/app.log` |

Never mix access and application events into the same file.

### Access log pattern (Tomcat/embedded)

Configure in `application.properties`:

```properties
server.tomcat.accesslog.enabled=true
server.tomcat.accesslog.directory=logs
server.tomcat.accesslog.prefix=access
server.tomcat.accesslog.suffix=.log
server.tomcat.accesslog.rotate=true
server.tomcat.accesslog.pattern=time=%t remote_ip=%h request_method=%m url_path="%U" query_string="%q" response_code=%s time_millis=%{msec}T bytes_sent=%b Referrer="%{Referer}i" UserAgent="%{User-Agent}i" traceId=%{X-Trace-Id}i
```

A sample line:

```
time=[20/Apr/2026:10:23:01 +0000] remote_ip=192.168.1.42 request_method=POST url_path="/api/checkout" query_string="" response_code=201 time_millis=342 bytes_sent=892 Referrer="-" UserAgent="Mozilla/5.0 ..." traceId=f4a2c891-3b1d
```

Include `traceId` at the end so HTTP-layer logs can be joined to application logs in Splunk with a single field.

## Correlation IDs (MDC)

The frontend generates a `traceId` and sends it as `X-Trace-Id` on every request. The backend accepts it and propagates it through all downstream logs. If no header is present (service-to-service calls without FE instrumentation, health checks, etc.), the backend generates a UUID as fallback.

**Filter (runs on every request):**

```java
public class TraceIdFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) {
        String traceId = Optional
            .ofNullable(((HttpServletRequest) req).getHeader("X-Trace-Id"))
            .orElse(UUID.randomUUID().toString());
        MDC.put("traceId", traceId);
        ((HttpServletResponse) res).setHeader("X-Trace-Id", traceId);
        try {
            chain.doFilter(req, res);
        } finally {
            MDC.clear(); // always clear -- thread pool reuse
        }
    }
}
```

Include `traceId` in the JSON appender pattern so it appears on every log line without manual effort.

## Structured JSON format

Every application log line must be valid JSON with at least these fields:

```json
{
  "timestamp": "2026-04-20T10:23:01.456Z",
  "level": "INFO",
  "traceId": "abc-123",
  "logger": "com.example.order.OrderService",
  "message": "order_created orderId=ORD-9981 customerId=C-42 amount=149.99",
  "thread": "http-nio-8080-exec-3"
}
```

Use `logstash-logback-encoder` (Logback) or `log4j2-ecs-layout` (Log4j2) to emit JSON without manual formatting.

## Splunk / Datadog key-value pairs in message

Within the `message` field, use `key=value` pairs for structured data. This lets Splunk `rex` and Datadog attribute extraction work without JSON path queries:

```java
log.info("order_created orderId={} customerId={} amount={}", order.getId(), order.getCustomerId(), order.getAmount());
// → "message": "order_created orderId=ORD-9981 customerId=C-42 amount=149.99"
```

Rules:
- Lead with an **event name** in `snake_case` (e.g. `order_created`, `payment_failed`, `user_login`).
- Follow with `key=value` pairs for all relevant context.
- No free-form prose in structured log lines -- parsers rely on predictable tokens.

## Log levels

| Level | When to use |
|-------|-------------|
| `ERROR` | Unhandled exceptions, system failures, data integrity violations. Always include the exception object. |
| `WARN` | Recoverable issues, degraded behavior, retries, unexpected but non-fatal state. |
| `INFO` | Business touchpoints (see layer guidance below). Default production level. |
| `DEBUG` | Developer detail: SQL, serialized payloads, branch decisions. Off in production. |
| `TRACE` | Loop internals, raw bytes. Never enabled outside local dev. |

Environment defaults: `INFO` in staging/prod, `DEBUG` in local dev only.

## Per-layer logging (what to log and where)

### Controller layer

Log at the boundary -- request in, response out.

```java
log.info("request_received method={} uri={} remoteIp={}", request.getMethod(), request.getRequestURI(), request.getRemoteAddr());
// ... handle ...
log.info("request_completed status={} durationMs={}", status, duration);
```

Log `WARN` on 4xx, `ERROR` on 5xx (with exception).

### Service layer

Log business operations -- not every line, but every meaningful state transition.

```java
log.info("order_processing orderId={} stage=validation", orderId);
log.info("order_processing orderId={} stage=payment_authorized paymentRef={}", orderId, paymentRef);
log.info("order_created orderId={} customerId={}", orderId, customerId);
```

### Repository / data layer

Log query intent at `DEBUG`, never log result sets or row counts at `INFO` (volume).

```java
log.debug("db_query table=orders filter=customerId:{} limit={}", customerId, limit);
```

Log `ERROR` on `DataAccessException` with the exception attached.

### External service calls

Log every outbound call with intent, target, and outcome:

```java
log.info("external_call service=payment-gateway action=charge amount={}", amount);
log.info("external_call_complete service=payment-gateway action=charge status={} durationMs={}", status, duration);
```

Log `ERROR` on non-2xx responses or timeouts, with response status and body excerpt (truncated to 500 chars max).

## Hard constraints

- **Never log PII.** No email addresses, names, passwords, tokens, card numbers, SSNs in any log at any level.
- **Never log secrets.** No API keys, DB credentials, JWT payloads.
- **Never log full request/response bodies** unless behind a `TRACE` guard and explicitly opt-in per endpoint.
- `MDC.clear()` must always run in a `finally` block -- failure to clear leaks context across thread pool reuse.
- Do not construct log strings with `+` concatenation. Use SLF4J parameterized logging (`{}`) to avoid string allocation when the level is disabled.

## When to apply

Load `logging-checklist.md` before declaring any backend logging implementation complete -- new endpoints, new service layers, or changes to existing logging config. Items that genuinely do not apply must be noted as out of scope, not silently skipped. EM verifies the checklist was run during PR approval.
