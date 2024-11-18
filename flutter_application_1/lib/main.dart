import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';
import 'login.dart';
import 'signup.dart';
import 'homepage.dart';
import 'dashboard.dart';
import 'categories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAz61Gp6H-3VsZUSIHsOqpqXsuruKyuXYQ",
          appId: "com.example.flutter_application_1",
          messagingSenderId: "messagingSenderId",
          projectId: "renty-5a34e"));
  runApp(MyApp());
}

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
          '/homepage': (context) => HomePage(),
        '/dashboard': (context) => DashboardPage(),
        '/categories': (context) => CategoriesPage(),

      },
    );
  }
}
