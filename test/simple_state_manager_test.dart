// import 'package:flutter_test/flutter_test.dart';
// import 'package:simple_state_manager/simple_state_manager.dart';

// void main() {
//   test('StateManager should initialize with default state', () {
//     final manager = StateManager<int>(0);
//     expect(manager.state, 0);
//   });

//   test('StateManager should update state and notify listeners', () async {
//     final manager = StateManager<int>(0);

//     manager.update(5);
//     expect(manager.state, 5);

//     // Test with stream listener
//     manager.stream.listen(expectAsync1((state) {
//       expect(state, 10);
//     }));
//     manager.update(10);
//   });

//   test('StateManager should reset state to default', () {
//     final manager = StateManager<int>(5);
//     manager.reset(0);
//     expect(manager.state, 0);
//   });

//   test('StateManager should not notify listeners if state remains unchanged',
//       () async {
//     final manager = StateManager<int>(5);

//     var notified = false;
//     manager.stream.listen((_) {
//       notified = true;
//     });

//     manager.update(5); // No state change
//     await Future.delayed(Duration.zero);
//     expect(notified, false);
//   });

//   test('Dispose should close the stream', () {
//     final manager = StateManager<int>(0);
//     manager.dispose();
//     expect(() => manager.update(1), throwsA(isA<StateError>()));
//   });
// }
