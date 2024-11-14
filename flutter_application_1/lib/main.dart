import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login.dart';
import 'signup.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
       // '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),  
        '/signup': (context) => SignupPage(),  
      },
    );
  }
}
