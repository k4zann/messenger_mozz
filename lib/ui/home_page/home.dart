import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger_mozz/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../chat_page/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;


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
            child: SvgPicture.asset(
              'assets/search.svg',
              width: 24,
              height: 24,
            )
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Произошла ошибка');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Нет данных'),
          );
        }

        return ListView(
        children: snapshot.data!.docs
            .map<Widget>((doc) => _buildUserListItem(doc))
            .toList(),
        );
      },
    );
  }
  Color getRandomColor() {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      // Add more colors as needed
    ];

    final Random random = Random();
    return colors[random.nextInt(colors.length)];
  }
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      String initials = _getInitials(data['name']);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  userId: data['uid'],
                  userName: data['name'],
                  initials: initials,
                  color: getRandomColor(),
                ),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundColor: getRandomColor(),
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          title: Text(
            data['name'],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "Уже сделал?",
            style: TextStyle(
              color: Color(0xff5E7A90),
              fontSize: 12,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';

    if (nameParts.isNotEmpty) {
      initials += nameParts[0][0].toUpperCase();

      if (nameParts.length > 1) {
        initials += nameParts[1][0].toUpperCase();
      }
    }

    return initials;
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
          SizedBox(height: 20,),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      )
    );
  }

}

