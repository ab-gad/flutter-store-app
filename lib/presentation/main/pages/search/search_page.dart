import 'package:flutter/material.dart';

import '../../../../resources/string_manager.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        StringManager.search,
      ),
    );
  }
}
