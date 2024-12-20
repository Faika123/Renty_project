import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ReservationPage.dart';
import 'splash_screen.dart';
import 'login.dart';
import 'signup.dart';
import 'homepage.dart';
import 'dashboard.dart';
import 'categories.dart';
import 'booking.dart';
import 'productadd.dart';
import 'FeedbackList.dart';
import 'feedback.dart';
import 'profile.dart';




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
       '/homepage': (context) => HomePage(),
        '/login': (context) => LoginPage(),  
        '/signup': (context) => SignupPage(),  
        '/dashboard': (context) => DashboardPage(),
        '/categories': (context) => CategoriesPage(),
        '/productadd': (context) => ProductAddPage(),
        '/booking': (context) => BookingPage(),
        '/feedback': (context) => FeedbackPage(),
        '/listfeedback': (context) => FeedbackListPage(),
        '/profile': (context) => ProfilePage(),
        '/reservation': (context) => ReservationPage(car: {},),
        
       

      },
    );
  }
}
