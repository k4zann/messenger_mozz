import 'dart:math';

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String userName;
  final String initials;
  final Color color;
  const ChatPage({super.key, required this.userId, required this.userName, required this.initials, required this.color});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName
        ),
      ),
    );
  }
}