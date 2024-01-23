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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.color,
              child: Text(
                widget.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Text(
              widget.userName
            ),
          ],
        ),
      ),
    );
  }
}