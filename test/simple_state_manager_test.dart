import 'package:flutter_test/flutter_test.dart';
import 'package:simple_state_manager/simple_state_manager.dart';

void main() {
  group('StateManager - Basic Functionality', () {
    test('should initialize with default state (simple state)', () {
      final manager = StateManager<int>(0);
      expect(manager.state, 0);
    });

    test('should initialize with default state (complex state)', () {
      final manager = StateManager<List<String>>([]);
      expect(manager.state, []);
    });

    test('should update state (simple state)', () {
      final manager = StateManager<int>(0);
      manager.update((state) => state + 1);
      expect(manager.state, 1);
    });

    test('should update state (complex state)', () {
      final manager = StateManager<List<int>>([]);
      manager.update((state) {
        state.add(1);
        return state;
      });
      expect(manager.state, [1]);
    });

    test('should reset state to default', () {
      final manager = StateManager<int>(5);
      manager.reset(0);
      expect(manager.state, 0);
    });
  });

  group('StateManager - Reactive Updates', () {
    test('should notify listeners when state changes', () async {
      final manager = StateManager<int>(0);

      final streamValues = <int>[];
      final subscription = manager.stream.listen((state) {
        streamValues.add(state);
      });

      manager.update((state) => state + 1);
      manager.update((state) => state + 2);

      await Future.delayed(Duration.zero);

      expect(streamValues, [1, 3]);

      await subscription.cancel();
    });

    test('should not notify listeners if state remains unchanged', () async {
      final manager = StateManager<int>(5);

      var notified = false;
      final subscription = manager.stream.listen((_) {
        notified = true;
      });

      manager.update((state) => state); // No actual change
      await Future.delayed(Duration.zero);

      expect(notified, false);

      await subscription.cancel();
    });

    test('should only rebuild UI for relevant changes', () async {
      final manager = StateManager<Map<String, dynamic>>({'counter': 0});

      final streamValues = <Map<String, dynamic>>[];
      final subscription = manager.stream.listen((state) {
        streamValues.add(state);
      });

      // Update the state
      manager.update((state) {
        state['counter'] = state['counter'] + 1;
        return state;
      });

      // Allow Stream to emit the value
      await Future.delayed(Duration.zero);

      // Ensure that the state was updated and the stream emitted the correct value
      expect(streamValues.isNotEmpty, true); // Ensure the list is not empty
      expect(streamValues.last['counter'], 1);

      await subscription.cancel();
    });
  });

  group('StateManager - Asynchronous Support', () {
    test('should support asynchronous updates', () async {
      final manager = StateManager<int>(0);

      Future<void> asyncUpdate() async {
        await Future.delayed(Duration(milliseconds: 10));
        manager.update((state) => state + 5);
      }

      await asyncUpdate();
      expect(manager.state, 5);
    });

    test('should notify listeners after asynchronous updates', () async {
      final manager = StateManager<int>(0);

      final streamValues = <int>[];
      final subscription = manager.stream.listen((state) {
        streamValues.add(state);
      });

      Future<void> asyncUpdate() async {
        await Future.delayed(Duration(milliseconds: 10));
        manager.update((state) => state + 5);
      }

      await asyncUpdate();
      await Future.delayed(Duration.zero);

      expect(manager.state, 5);
      expect(streamValues, [5]);

      await subscription.cancel();
    });
  });

  group('StateManager - Performance and Memory Management', () {
    test('should manage multiple states efficiently', () async {
      final managers = List.generate(100, (index) => StateManager<int>(index));

      // Update all states
      for (var i = 0; i < 100; i++) {
        managers[i].update((state) => state + 1);
      }

      // Check updated values
      for (var i = 0; i < 100; i++) {
        expect(managers[i].state, i + 1);
      }

      // Dispose all managers
      for (var manager in managers) {
        manager.dispose();
      }
    });

    test('should not cause memory leaks when disposed', () {
      final manager = StateManager<int>(0);
      manager.dispose();

      expect(() => manager.update((state) => state + 1),
          throwsA(isA<StateError>()));
    });
  });
}
