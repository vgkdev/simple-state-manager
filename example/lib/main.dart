import 'package:example/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:simple_state_manager/simple_state_manager.dart';

/// Define Address (nested in User)
class Address {
  final String city;
  final String country;

  Address({required this.city, required this.country});

  Address copyWith({String? city, String? country}) {
    return Address(
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  @override
  String toString() => '$city, $country';
}

/// Define User
class User {
  final String name;
  final Address address;

  User({required this.name, required this.address});

  User copyWith({String? name, int? age, Address? address}) {
    return User(
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  @override
  String toString() => '$name, Address: $address';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Simple state management
  final counterState = StateManager<int>(0);

  // Complex state: list
  final listState = StateManager<List<String>>([]);

  // Complex state: map
  final mapState = StateManager<Map<String, dynamic>>({
    'name': 'John Doe',
    'age': 30,
  });

  // Complex state: nested object
  final userState = StateManager<User>(
    User(
      name: 'Jane Doe',
      address: Address(city: 'New York', country: 'USA'),
    ),
  );

  final TextEditingController mapNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userCityController = TextEditingController();
  final TextEditingController userCountryController = TextEditingController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('State Manager Example')),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Manage simple State
                  const Text('Counter State:', style: TextStyle(fontSize: 18)),
                  StateWatcher<int>(
                    stateManager: counterState,
                    builder: (context, state) => Text(
                      'Counter: $state',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          counterState.update((current) => current + 1);
                        },
                        child: const Text('Increment'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          counterState.update((current) => current - 1);
                        },
                        child: const Text('Decrement'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Manage complex State (list)
                  const Text('List State:', style: TextStyle(fontSize: 18)),
                  StateWatcher<List<String>>(
                    stateManager: listState,
                    builder: (context, state) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.map((item) => Text('- $item')).toList(),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Update list (Add a new item)
                          listState.update((currentList) {
                            return [
                              ...currentList,
                              'Item ${currentList.length + 1}'
                            ];
                          });
                        },
                        child: const Text('Add Item'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Update list (Remove the last item)
                          listState.update((currentList) {
                            return currentList.isNotEmpty
                                ? currentList.sublist(0, currentList.length - 1)
                                : currentList;
                          });
                        },
                        child: const Text('Remove Item'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Manage complex State (map)
                  const Text('Map State:', style: TextStyle(fontSize: 18)),
                  StateWatcher<Map<String, dynamic>>(
                    stateManager: mapState,
                    builder: (context, state) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.entries
                          .map((entry) => Text('${entry.key}: ${entry.value}'))
                          .toList(),
                    ),
                  ),
                  TextField(
                    controller: mapNameController,
                    decoration:
                        const InputDecoration(labelText: 'Enter Name for Map'),
                    onSubmitted: (value) {
                      mapState.update((currentMap) {
                        return {...currentMap, 'name': value};
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      mapState.update((currentMap) {
                        return {
                          ...currentMap,
                          'age': (currentMap['age'] as int) + 1
                        };
                      });
                    },
                    child: const Text('Increment Age'),
                  ),
                  const SizedBox(height: 20),

                  // Manage complex State (nested object)
                  const Text('Nested Object State:',
                      style: TextStyle(fontSize: 18)),
                  StateWatcher<User>(
                    stateManager: userState,
                    builder: (context, state) => Text(
                      state.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextField(
                    controller: userNameController,
                    decoration:
                        const InputDecoration(labelText: 'Enter User Name'),
                    onSubmitted: (value) {
                      userState.update((currentUser) {
                        return currentUser.copyWith(name: value);
                      });
                    },
                  ),
                  TextField(
                    controller: userCityController,
                    decoration: const InputDecoration(labelText: 'Enter City'),
                    onSubmitted: (value) {
                      userState.update((currentUser) {
                        return currentUser.copyWith(
                          address: currentUser.address.copyWith(city: value),
                        );
                      });
                    },
                  ),
                  TextField(
                    controller: userCountryController,
                    decoration:
                        const InputDecoration(labelText: 'Enter Country'),
                    onSubmitted: (value) {
                      userState.update((currentUser) {
                        return currentUser.copyWith(
                          address: currentUser.address.copyWith(country: value),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Reset all states
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          counterState.reset(0);
                          listState.reset([]);
                          mapState.reset({
                            'name': 'John Doe',
                            'age': 30,
                          });
                          userState.reset(User(
                            name: 'Jane Doe',
                            address: Address(city: 'New York', country: 'USA'),
                          ));
                          mapNameController.clear();
                          userNameController.clear();
                          userCityController.clear();
                          userCountryController.clear();
                        },
                        child: const Text('Reset All'),
                      ),
                    ],
                  ),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PostScreen()),
                        );
                      },
                      child: const Text('Go to Post Screen'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
