import 'package:flutter/material.dart';

import '../../../../resources/string_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        StringManager.home,
      ),
    );
  }
}
