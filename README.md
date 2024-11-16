# StateManager

**StateManager** is a lightweight and flexible state management package for Flutter, designed to handle simple and complex states efficiently. With support for both synchronous and asynchronous state updates, it provides an intuitive API for developers to manage application states with ease.

---

## Features

- **Simple State Management**: Manage primitive states like `int`, `double`, `String`.
- **Complex State Management**: Manage `List`, `Map`, and nested objects effortlessly.
- **Reactive Updates**: Automatically rebuild UI when state changes.
- **Synchronous and Asynchronous Updates**: Supports both instant updates and updates from asynchronous tasks (like API calls).
- **State Reset**: Reset any state back to its initial value.
- **Memory Safety**: Dispose of resources when no longer needed to avoid memory leaks.
- **Performance Optimized**: Ensures only relevant parts of the UI rebuild, reducing unnecessary renders.

---

## Getting Started

### **Installation**

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  simple_state_manager:
    path: ../
```
