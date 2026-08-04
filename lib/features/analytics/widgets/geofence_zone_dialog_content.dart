import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/geofence_zone_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showGeofenceZoneDialog] (Issue #346): when
/// [existing] is provided the fields are pre-filled and its `id` is
/// preserved so saving updates the same zone in place.
class GeofenceZoneDialogContent extends StatefulWidget {
  final GeofenceZoneEntity? existing;

  const GeofenceZoneDialogContent({super.key, this.existing});

  @override
  State<GeofenceZoneDialogContent> createState() => _GeofenceZoneDialogContentState();
}

class _GeofenceZoneDialogContentState extends State<GeofenceZoneDialogContent> {
  late final _featureNameController =
      TextEditingController(text: widget.existing?.featureName);
  late final _centerLatController =
      TextEditingController(text: widget.existing?.centerLatitude.toString());
  late final _centerLngController =
      TextEditingController(text: widget.existing?.centerLongitude.toString());
  late final _radiusKmController =
      TextEditingController(text: widget.existing?.radiusKm.toString());
  late bool _isEnabled = widget.existing?.isEnabled ?? true;

  void _submit() {
    final lat = double.tryParse(_centerLatController.text);
    final lng = double.tryParse(_centerLngController.text);
    final radius = double.tryParse(_radiusKmController.text);
    if (_featureNameController.text.trim().isEmpty ||
        lat == null ||
        lng == null ||
        radius == null ||
        radius <= 0) {
      return;
    }
    Navigator.of(context).pop(GeofenceZoneEntity(
      id: widget.existing?.id ?? 0,
      featureName: _featureNameController.text.trim(),
      centerLatitude: lat,
      centerLongitude: lng,
      radiusKm: radius,
      isEnabled: _isEnabled,
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: Text(widget.existing == null ? 'Add Geofence Zone' : 'Edit Geofence Zone'),
      description: GeofenceZoneFields(
        featureNameController: _featureNameController,
        centerLatController: _centerLatController,
        centerLngController: _centerLngController,
        radiusKmController: _radiusKmController,
        isEnabled: _isEnabled,
        onEnabledChanged: (v) => setState(() => _isEnabled = v),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
