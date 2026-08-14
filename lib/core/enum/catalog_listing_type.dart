/// Discriminator between a physical Product and an intangible Service
/// catalog listing (Issue #138, acceptance criterion 2) — this app
/// has no NestJS/Mongoose backend, so the "discriminator" is a plain
/// ObjectBox relation to [ProductListingDetailsEntity] or
/// [ServiceListingDetailsEntity] instead of a Mongoose discriminator
/// key.
enum CatalogListingType { product, service }
