import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger_mozz/services/auth/auth.dart';
import 'package:messenger_mozz/services/auth/auth_service.dart';
import 'package:messenger_mozz/ui/registration_page/registration.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBX8xxHB3X7MyMQX8zEN6PdKZi_xWIM_QA",
      appId: "1:952874351110:android:0e3c4d6a7abe67b58ce187",
      messagingSenderId: "952874351110",
      projectId: "messengermozz",
    ),
  );
  runApp(ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger MOZZ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Authenticate(),
    );
  }
}



