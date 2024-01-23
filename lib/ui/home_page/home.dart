import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_mozz/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Поиск',
          hintStyle: const TextStyle(
            color: Color(0xff9DB7CB),
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image(
              image: AssetImage('assets/search_s.png'),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Text(
              'Чаты',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 32
            )
          ),
        ),
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
      body: Column(
        children: [
          _searchField(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Чат $index'),
                  subtitle: Text('Последнее сообщение'),
                  onTap: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

