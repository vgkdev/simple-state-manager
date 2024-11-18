import 'dart:async';

/// A generic StateManager to manage any type of state.
class StateManager<T> {
  T _state; // The current state
  final _controller = StreamController<T>.broadcast();

  /// Initialize with a default state.
  StateManager(T initialState) : _state = initialState;

  /// Get the current state.
  T get state => _state;

  /// Stream to listen for state changes.
  Stream<T> get stream => _controller.stream;

  /// Update the state using a callback that modifies the current state.
  /// The callback [updateFunction] takes the current state and returns the modified state.
  void update(Function(T currentState) updateFunction) {
    final newState = updateFunction(_state);

    if (_state is Map || _state is List || _state != newState) {
      _state = newState;
      _controller.add(_state);
    }
  }

  /// Reset the state to a default value.
  void reset(T defaultState) {
    _state = defaultState;
    _controller.add(_state);
  }

  /// Dispose of the resources.
  void dispose() {
    _controller.close();
  }
}
