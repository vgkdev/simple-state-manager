import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_state_manager/simple_state_manager.dart';
import 'package:http/http.dart' as http;

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class PostScreen extends StatelessWidget {
  final postsState = StateManager<List<Post>>([]);

  PostScreen({super.key});

  Future<void> fetchPosts() async {
    print('>>> fetchPosts called');
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('>>>check response: ${response.body}');
      final List<dynamic> json = jsonDecode(response.body);
      final posts = json.map((post) => Post.fromJson(post)).toList();

      postsState.update((_) => posts);
    } else {
      print('>>> Failed to fetch posts: ${response.statusCode}');
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fetch API Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: fetchPosts,
                  child: const Text('Fetch Posts'),
                ),
                ElevatedButton(
                  onPressed: () {
                    postsState.reset([]);
                  },
                  child: const Text('Clean Posts'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            StateWatcher<List<Post>>(
              stateManager: postsState,
              builder: (context, posts) {
                if (posts.isEmpty) {
                  return const Text('No posts available.');
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
