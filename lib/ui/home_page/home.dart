import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_mozz/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger Mozz'),
        actions: [
          IconButton(
            onPressed: () {
              final authService = Provider.of<AuthService>(context, listen: false);
              authService.signOut();
            },
            icon: Icon(Icons.logout),
          )
        ],
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

