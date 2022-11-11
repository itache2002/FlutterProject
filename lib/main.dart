import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loginform.dart';
import 'Splashpage.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key ? key}) : super(key: key);

  static const String _title = 'Food Wasteage Reduction';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.lime
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body:  LoginForm(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

