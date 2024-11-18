# **Simple State Manager**

`simple_state_manager` is a lightweight and flexible state management package for Flutter. It is designed to efficiently handle simple and complex application states. With an intuitive API and reactive updates, it helps developers manage state changes seamlessly, ensuring a smooth UI experience.

---

## **Features**

### Core Features

- **Easy State Management**: Supports primitive types like `int`, `double`, `String`, and complex structures like `List`, `Map`, and custom objects.
- **Reactive UI Updates**: Automatically rebuilds UI components when the state changes.
- **Synchronous Updates**: Instantly update states with simple APIs.
- **Asynchronous Support**: Handle state changes triggered by async tasks (e.g., API calls, database queries).
- **State Reset**: Reset your state to its default value easily.
- **Stream-Based Architecture**: Built on `Stream` for lightweight and efficient state updates.
- **Memory Management**: Automatically dispose of resources to prevent memory leaks.
- **Performance Optimization**: Minimizes unnecessary widget rebuilds.

---

## **Installation**

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  simple_state_manager:
    path: ../
```

Then, run:

```bash
flutter pub get
```

---

## **Usage Guide**

### **1. Setting Up StateManager**

`StateManager` is the core class for managing your state. Initialize it with a default value and use its methods to update, reset, or listen to state changes.

```dart
import 'package:simple_state_manager/simple_state_manager.dart';

final counterManager = StateManager<int>(0); // Default state: 0
```

---

### **2. Updating State**

Update the state synchronously using the `update` method. Provide a callback that modifies the current state.

```dart
counterManager.update((currentState) => currentState + 1); // Increment state
```

---

### **3. Resetting State**

Use `reset` to set the state back to a default value.

```dart
counterManager.reset(0); // Reset state to 0
```

---

### **4. Updating UI Reactively**

#### **Using StateWatcher**

`StateWatcher` is a `StatelessWidget` that rebuilds when the state changes. It’s perfect for lightweight use cases.

```dart
import 'package:simple_state_manager/simple_state_manager.dart';
import 'package:flutter/material.dart';

class CounterApp extends StatelessWidget {
  final counterManager = StateManager<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Counter')),
        body: Center(
          child: StateWatcher<int>(
            stateManager: counterManager,
            builder: (context, state) => Text('Counter: $state'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counterManager.update((currentState) => currentState + 1),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

---

#### **Using StateBuilder**

`StateBuilder` is a `StatefulWidget` that gives you more control over state updates. It is useful for scenarios requiring lifecycle management or local state.

```dart
import 'package:simple_state_manager/simple_state_manager.dart';
import 'package:flutter/material.dart';

class CounterApp extends StatelessWidget {
  final counterManager = StateManager<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Counter')),
        body: Center(
          child: StateBuilder<int>(
            stateManager: counterManager,
            builder: (context, state) => Text('Counter: $state'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counterManager.update((currentState) => currentState + 1),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

---

## **API Reference**

### **StateManager**

| Method                                                     | Description                                    |
| ---------------------------------------------------------- | ---------------------------------------------- |
| **`T get state`**                                          | Returns the current state.                     |
| **`Stream<T> get stream`**                                 | A stream that emits state changes.             |
| **`void update(Function(T currentState) updateFunction)`** | Updates the state based on a callback.         |
| **`void reset(T defaultState)`**                           | Resets the state to a given default value.     |
| **`void dispose()`**                                       | Disposes the resources used by `StateManager`. |

---

## **Best Practices**

1. **Dispose Resources**: Always call `dispose` on `StateManager` to clean up resources when they are no longer needed.

   ```dart
   @override
   void dispose() {
     counterManager.dispose();
     super.dispose();
   }
   ```

2. **Use `StateWatcher` for Simplicity**: For straightforward UI updates, prefer `StateWatcher`.

3. **Use `StateBuilder` for Advanced Scenarios**: Use `StateBuilder` when you need lifecycle management or local state handling.

---

## **Example**

Here’s a complete example of a counter app:

```dart
import 'package:flutter/material.dart';
import 'package:simple_state_manager/simple_state_manager.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  final counterManager = StateManager<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Counter App')),
        body: Center(
          child: StateWatcher<int>(
            stateManager: counterManager,
            builder: (context, state) => Text('Counter: $state', style: TextStyle(fontSize: 24)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counterManager.update((state) => state + 1),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

---

## **Contributing**

Contributions are welcome! Feel free to open issues or submit pull requests to improve the package.

---
