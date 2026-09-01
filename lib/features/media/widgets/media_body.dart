import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';
import 'package:growth_pilot_ai/features/media/widgets/media_actions.dart';
import 'package:growth_pilot_ai/features/media/widgets/media_repos.dart';
import 'package:growth_pilot_ai/features/media/widgets/media_view.dart';

/// Owns the image optimization demo state (Issue #139) — this app has
/// no NestJS/sharp/S3/CDN, so this is a local, genuinely-computed
/// resize + JPEG re-encode instead of a fake pipeline claim.
class MediaBody extends StatefulWidget {
  const MediaBody({super.key});
  @override
  State<MediaBody> createState() => _MediaBodyState();
}

class _MediaBodyState extends State<MediaBody> {
  final _actions = MediaActions(MediaRepos());
  late List<ImageVariantEntity> _variants = _actions.all;

  void _process() {
    _actions.processDemoImage();
    setState(() => _variants = _actions.all);
  }

  @override
  Widget build(BuildContext context) {
    return MediaView(variants: _variants, onProcess: _process);
  }
}
