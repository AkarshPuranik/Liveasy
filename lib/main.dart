import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liveasy/screens/language_selection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liv Easy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LanguageSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
