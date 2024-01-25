import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/Message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // send message function
  Future<void> sendMessage(String userId, String msg) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final String currentUserName = _firebaseAuth.currentUser!.displayName.toString();
    final Timestamp timestamp = Timestamp.now();


    Message message = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        senderName: currentUserName,
        receiverId: userId,
        message: msg,
        timestamp: timestamp
    );

    List<String> ids = [currentUserId, userId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toMap());
  }

  // get message function

  Stream<QuerySnapshot> getMessage(String userId, String secondUserId) {
    List<String> ids = [userId, secondUserId];

    ids.sort();
    String chatRoomId = ids.join('_');
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

}