import 'package:chatapp/chat_page.dart';
import 'package:chatapp/chat_screen.dart';
import 'package:chatapp/login.dart';
import 'package:chatapp/signup.dart';
import 'package:chatapp/tabbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyBcAjnXiv0LNM0WlU2xfhWlRdGeoYwOs5A",
            appId: "1:1037705955292:web:3694fe606f9d5325237119",
            messagingSenderId: "1037705955292",
            projectId: "chatapp-be355",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var storage = FlutterSecureStorage();
  var alreadyLogin = '';

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: alreadyLogin.toString().isEmpty
          ? LoginPage()
          : Home(
              myEmail: alreadyLogin.toString(),
            ),
    );
  }

  Future<String?> getEmail() async {
    return await storage.read(key: 'email');
  }

  checkLogin() async {
    String? emailToken = await getEmail();
    if (emailToken != null) {
      setState(() {
        alreadyLogin = emailToken.toString();
      });
    }
  }
}
