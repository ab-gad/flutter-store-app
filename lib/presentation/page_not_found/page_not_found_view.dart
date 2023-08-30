import 'package:flutter/material.dart';
import 'package:flutter_store_app/resources/string_manager.dart';

class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.pageNotFound),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(StringManager.pageNotFoundMsg),
      ),
    );
  }
}
