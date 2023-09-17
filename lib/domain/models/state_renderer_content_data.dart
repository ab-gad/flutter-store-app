import 'dart:ui';

class StateRendererContentData {
  final VoidCallback? retryFunction;
  final String? imageUrl;
  final String message;
  final String title;

  const StateRendererContentData({
    this.retryFunction,
    this.imageUrl,
    this.title = '',
    this.message = '',
  });
}
