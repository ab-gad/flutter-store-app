import 'package:flutter/material.dart';
import 'package:flutter_store_app/resources/string_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        StringManager.settings,
      ),
    );
  }
}
