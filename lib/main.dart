import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xekomanagermain/LoginScreen.dart';
Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAAtiStNZVE3pIDKqRG0I8V8xvdLxDTI1c",
        authDomain: "xekoship-a0057.firebaseapp.com",
        databaseURL: "https://xekoship-a0057-default-rtdb.firebaseio.com",
        projectId: "xekoship-a0057",
        storageBucket: "xekoship-a0057.appspot.com",
        messagingSenderId: "865954586917",
        appId: "1:865954586917:web:1dcb5fbae930470986bacc",
        measurementId: "G-XM3W0LBLYG"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xeko manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SCREENLogin(),
      // home: const SCREENlocationbikest1test(),
    );
  }
}