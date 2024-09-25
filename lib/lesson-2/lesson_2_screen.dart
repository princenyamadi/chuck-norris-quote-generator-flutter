import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lesson2Screen extends StatefulWidget {
  const Lesson2Screen({super.key});

  @override
  State<Lesson2Screen> createState() => _Lesson2ScreenState();
}

class _Lesson2ScreenState extends State<Lesson2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson 2'),
      ),
      body: FutureBuilder(
        future: fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData) {
            final body = jsonDecode(snapshot.data!.body) as List<dynamic>;
            return ListView.builder(
                itemCount: body.length,
                itemBuilder: (context, index) {
                  final item = body[index];

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(item['id'].toString()),
                    ),
                    title: Text(item['title']),
                  );
                });
          }

          return const Center(
            child: Text('Error occurred while retrieving files'),
          );
        },
      ),
    );
  }
}

Future<http.Response> fetchPhotos() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
}
