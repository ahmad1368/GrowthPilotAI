import 'package:objectbox/objectbox.dart';

/// One text fragment's vector representation (Issue #198) — stored so
/// [RetrieveTopKContext] can search it later. This repo's pinned
/// `objectbox` version (2.5.1) has no native HNSW vector index yet, so
/// [embedding] is a plain, unindexed float array; search is a
/// brute-force in-memory cosine comparison (see PR notes).
@Entity()
class EmbeddingEntity {
  @Id()
  int id = 0;

  String sourceRefType; // e.g. 'Transaction'
  String sourceRefId;
  String sourceText;

  @Property(type: PropertyType.floatVector)
  List<double> embedding;

  EmbeddingEntity({
    this.id = 0,
    required this.sourceRefType,
    required this.sourceRefId,
    required this.sourceText,
    required this.embedding,
  });
}
