/// Status of one local dependency check (Issue #166, reinterpreted for
/// this local-first app — see PR notes on why the original NestJS
/// `@nestjs/terminus` `/health` endpoint spec doesn't apply here).
enum ServiceHealthStatus { up, degraded, down }
