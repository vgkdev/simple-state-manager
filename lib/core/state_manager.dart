import 'dart:async';

/// A generic StateManager to manage application state efficiently.
class StateManager<T> {
  T _state; // The current state
  final _controller = StreamController<T>.broadcast();

  /// Initialize with a default state.
  StateManager(T initialState) : _state = initialState;

  /// Get the current state.
  T get state => _state;

  /// Stream to listen for state changes.
  Stream<T> get stream => _controller.stream;

  /// Update the state. It triggers state listeners if the state changes.
  void update(T newState) {
    if (_state != newState) {
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
