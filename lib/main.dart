import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quote = '';
  String image = 'https://api.chucknorris.io/img/avatar/chuck-norris.png';
  String id = '';

  Map<String, dynamic> random = {'value': "Paa Kofi on flutter"};
  @override
  Widget build(BuildContext context) {
    print('rebuilding page');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuckies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(image),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quote,
                style: const TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Text(id),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final response = await fetchQuote();
                  log(response.body);
                  final body =
                      jsonDecode(response.body) as Map<String, dynamic>;

                  final chuckQuote = ChuckQuote.fromJson(body);
                  // final chuckQuote = ChuckQuote(value: body['value']);

                  setState(() {
                    quote = chuckQuote.value;
                    image = chuckQuote.image;
                    id = chuckQuote.id;

                    // quote = response.body;
                  });
                },
                child: const Text('Generate Quote'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuckies'),
      ),
    );
  }
}

// Future<http.Response> fetchAlbum() {
//   return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
// }

Future<http.Response> fetchQuote() {
  return http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
}

class ChuckQuote {
  final String value;
  final String id;
  final String image;

  ChuckQuote({required this.value, required this.id, required this.image});

  factory ChuckQuote.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'value': String value,
        'id': String id,
        'icon_url': String image,
      } =>
        ChuckQuote(value: value, id: id, image: image),
      _ => throw const FormatException('Failed to load Quote.'),
    };
  }
}



//  factory Album.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'userId': int userId,
//         'id': int id,
//         'title': String title,
//       } =>
//         Album(
//           userId: userId,
//           id: id,
//           title: title,
//         ),
//       _ => throw const FormatException('Failed to load album.'),
//     };
//   }