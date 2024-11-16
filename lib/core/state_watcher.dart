import 'package:flutter/widgets.dart';
import 'state_manager.dart';

/// StateWatcher listens to a StateManager and rebuilds the widget when state changes.
class StateWatcher<T> extends StatelessWidget {
  final StateManager<T> stateManager;
  final Widget Function(BuildContext context, T state) builder;

  const StateWatcher({
    super.key,
    required this.stateManager,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stateManager.stream,
      initialData: stateManager.state,
      builder: (context, snapshot) {
        return builder(context, snapshot.data!);
      },
    );
  }
}
