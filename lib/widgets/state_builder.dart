import 'package:flutter/widgets.dart';
import '../core/state_manager.dart';

/// A StateBuilder widget provides state updates to UI and listens for changes.
class StateBuilder<T> extends StatefulWidget {
  final StateManager<T> stateManager;
  final Widget Function(BuildContext context, T state) builder;

  const StateBuilder({
    super.key,
    required this.stateManager,
    required this.builder,
  });

  @override
  _StateBuilderState<T> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T> extends State<StateBuilder<T>> {
  late T _state;

  @override
  void initState() {
    super.initState();
    _state = widget.stateManager.state;
    widget.stateManager.stream.listen((newState) {
      if (mounted) {
        setState(() {
          _state = newState;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
