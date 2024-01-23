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
    final Timestamp timestamp = Timestamp.now();


    Message message = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: userId,
        message: msg,
        timestamp: timestamp
    );

    List<String> ids = [currentUserId, userId];
    ids.sort();
    
  }

  // get message function
}