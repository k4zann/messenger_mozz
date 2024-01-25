import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_mozz/services/chat/chat_service.dart';

import '../../widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String userName;
  final String userEmail;
  final String initials;
  final Color color;
  const ChatPage({super.key, required this.userId, required this.userName, required this.userEmail, required this.initials, required this.color});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();
    final ChatService _chatService = ChatService();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    void sendMessage() async {
      if (_messageController.text.isNotEmpty) {
        await _chatService.sendMessage(widget.userId, _messageController.text.toString());

        _messageController.clear();
      }
    }

    Widget _messageItem(DocumentSnapshot document) {
      Map<String, dynamic> message = document.data()! as Map<String, dynamic>;

      var alignment = message['senderId'] == _auth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft;

      return Container(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: (message['senderId'] == _auth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisAlignment: (message['senderId'] == _auth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                MessageBubble(
                  message: message['message'],
                  isMe: message['senderId'] == _auth.currentUser!.uid,
                ),
              ]
            ),
          )
      );
    }

    Widget _messageList() {
      return StreamBuilder(
        stream: _chatService.getMessage(widget.userId, _auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return _messageItem(document);
            }).toList(),
          );
        },
      );
    }


    Widget _messageInput() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () {},
              iconSize: 24, // Set the icon size to a fixed value
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
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
                ),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.send),
              iconSize: 24, // Set the icon size to a fixed value
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.mic),
              iconSize: 24, // Set the icon size to a fixed value
            )
          ],
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.userName
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messageList(),
          ),

          _messageInput(),
        ],
      ),
    );
  }
}

//TODO need to fix the chatting page appbar, and also need to add function: sendMessage, getMessage, attachFile, sendAudi