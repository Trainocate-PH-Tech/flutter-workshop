# HTTP Requests

Allow making an HTTP request from client to server to fetch or post data.

## Getting Data

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SimpleHttpWidget extends StatefulWidget {
  const SimpleHttpWidget({super.key});

  @override
  State<SimpleHttpWidget> createState() => _SimpleHttpWidgetState();
}

class _SimpleHttpWidgetState extends State<SimpleHttpWidget> {
  String _response = "Press the button to fetch data";

  Future<void> _fetchData() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/todos/1");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        setState(() {
          _response = res.body;
        });
      } else {
        setState(() {
          _response = "Error: ${res.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "Failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: _fetchData,
            child: const Text("Fetch Data"),
          ),
          const SizedBox(height: 20),
          Text(
            _response,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
```

## Posting Data

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimplePostWidget extends StatefulWidget {
  const SimplePostWidget({super.key});

  @override
  State<SimplePostWidget> createState() => _SimplePostWidgetState();
}

class _SimplePostWidgetState extends State<SimplePostWidget> {
  final TextEditingController _controller = TextEditingController();
  String _response = "Enter text and press POST";

  Future<void> _postData() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final uri = Uri.parse(url);

    try {
      final body = {
        "title": _controller.text,
        "userId": 1,
      };

      final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      if (res.statusCode == 201) {
        setState(() {
          _response = "Success:\n${res.body}";
        });
      } else {
        setState(() {
          _response = "Error: ${res.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "Failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Enter title",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _postData,
            child: const Text("Send POST"),
          ),
          const SizedBox(height: 20),
          Text(
            _response,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
```
