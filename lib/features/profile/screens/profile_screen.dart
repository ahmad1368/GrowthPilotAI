import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/profile_controller.dart';
import 'package:growth_pilot_ai/features/profile/widgets/profile_form.dart';

/// [Issue #826] Profile screen reachable from the drawer — editable
/// display name, birth date, and business type. Profile-picture upload
/// and app-wide business-type-driven behavior are explicitly out of
/// scope here; see the issue's Notes.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ProfileController _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ProfileController());
    _controller.load().then((_) {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile_screen_title'.tr)),
      body: !_ready
          ? const Center(child: CircularProgressIndicator())
          : ProfileForm(
              formKey: _formKey,
              controller: _controller,
              onSaved: () => Navigator.of(context).pop(),
            ),
    );
  }
}
