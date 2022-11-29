import 'dart:io';

import 'package:firebase/DataAdd/employydata.dart';
import 'package:firebase/Registarion/sign%20in%20screen.dart';
import 'package:firebase/DataAdd/firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp();
  }else {
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyAZN87Xn5zAMBkkPt07ZNLlbQKM4M-SFa0",
        appId: "1:650783352822:web:f6d1f5312eef9dc70c49d7",
        messagingSenderId: "650783352822",
        projectId: "fir-70998"));
  }
    runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SignInscreen(),
      home: firestorescreen(),
      // home: Employydata(),
    );
  }
}
