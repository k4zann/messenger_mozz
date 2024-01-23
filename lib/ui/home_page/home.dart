import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger Mozz'),
      ),
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

}

