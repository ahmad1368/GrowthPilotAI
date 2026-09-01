---
name: network-integration
description: Use this skill when creating API service classes, network clients, interceptors, or handling HTTP requests and responses.
---

When implementing network communication layer for GrowthPilotAI, ensure high reliability:

1. **Dio Client Usage**: Use the centralized `Dio` instance wrapped with custom interceptors for automatic token refreshing, logging, and setting baseline timeouts (e.g., 10 seconds).
2. **Network State Connectivity**: Check for internet availability using connectivity wrappers before dispatching remote calls to prevent long hanging socket errors.
3. **Status Code Mapping**: Parse HTTP status codes systematically. Convert 4xx and 5xx responses into domain-specific failure objects (e.g., `NetworkFailure.unauthorized()`, `NetworkFailure.serverError()`).
4. **Data Deserialization**: Always execute JSON decoding/deserialization safely inside `try-catch` blocks to protect against parsing errors due to unexpected backend schema updates.
