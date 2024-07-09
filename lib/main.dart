import 'package:book_app/model/model.dart';
import 'package:book_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;
  void toggleDarkMode(){
    setState(() {
      isDarkMode =!isDarkMode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode? ThemeData.dark() : ThemeData.light(),
      home: LoginScreen(
        isDarkMode: isDarkMode,
        toggleDarkMode: toggleDarkMode,
      )
    );
  }
}
List<Book> cart = [];