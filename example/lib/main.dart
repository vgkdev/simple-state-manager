import 'package:flutter/material.dart';
import 'package:simple_state_manager/simple_state_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final counterState = StateManager<int>(0); //initial

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple State Manager Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the current state
              StateWatcher<int>(
                stateManager: counterState,
                builder: (context, state) => Text(
                  'Counter: $state',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              // Increment and decrement buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      counterState.update(counterState.state - 1);
                    },
                    child: const Text('Decrement'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      counterState.update(counterState.state + 1);
                    },
                    child: const Text('Increment'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Reset counter
              ElevatedButton(
                onPressed: () {
                  counterState.reset(0);
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
