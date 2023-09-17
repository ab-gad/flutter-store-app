import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../domain/models/state_renderer_data.dart';
import 'state_renderer.dart';

class StateRendererStream extends StatelessWidget {
  final Stream<StateRendererData> stateRendererStream;
  final Widget content;

  const StateRendererStream({
    super.key,
    required this.stateRendererStream,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: StateRendererData.content(),
      stream: stateRendererStream,
      builder: (context, snapshot) {
        if (ModalRoute.of(context)?.isCurrent != true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop(true);
          });
        }
        return StateRenderer(
          stateRendererData: snapshot.data!,
          content: content,
        );
      },
    );
  }
}
