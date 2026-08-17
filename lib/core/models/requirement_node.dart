import 'package:flutter/foundation.dart';

/// One node in a requirement hierarchy (Issue #219) — [parentId] is
/// explicit, caller-supplied; automatic parent-child inference from raw
/// text (the issue's server-side "Logic Layer") isn't implemented here
/// (see PR notes).
@immutable
class RequirementNode {
  final String id;
  final String label;
  final String? parentId;

  const RequirementNode({required this.id, required this.label, this.parentId});
}
