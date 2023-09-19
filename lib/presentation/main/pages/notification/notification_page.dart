import 'package:flutter/material.dart';

import '../../../../resources/string_manager.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        StringManager.notification,
      ),
    );
  }
}
