import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/service_restriction_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showServiceRestrictionDialog] (Issue #337):
/// owns the text controllers and blocked toggle for the new restriction.
class ServiceRestrictionDialogContent extends StatefulWidget {
  const ServiceRestrictionDialogContent({super.key});

  @override
  State<ServiceRestrictionDialogContent> createState() =>
      _ServiceRestrictionDialogContentState();
}

class _ServiceRestrictionDialogContentState
    extends State<ServiceRestrictionDialogContent> {
  final _merchantNameController = TextEditingController();
  final _serviceNameController = TextEditingController();
  final _reasonMessageController = TextEditingController();
  bool _isBlocked = true;

  void _submit() {
    if (_merchantNameController.text.trim().isEmpty ||
        _serviceNameController.text.trim().isEmpty) {
      return;
    }
    Navigator.of(context).pop(ServiceRestrictionEntity(
      merchantName: _merchantNameController.text.trim(),
      serviceName: _serviceNameController.text.trim(),
      isBlocked: _isBlocked,
      reasonMessage: _reasonMessageController.text.trim(),
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Service Restriction'),
      description: ServiceRestrictionFields(
        merchantNameController: _merchantNameController,
        serviceNameController: _serviceNameController,
        reasonMessageController: _reasonMessageController,
        isBlocked: _isBlocked,
        onBlockedChanged: (v) => setState(() => _isBlocked = v),
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
