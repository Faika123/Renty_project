import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'dashboard.dart';
import 'profile.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock, size: 80, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail Address',
                  labelStyle: TextStyle(color: Colors.blue),
                  prefixIcon: Icon(Icons.email, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blue),
                  prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  try {
                    // Authentification Firebase
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Vérifier le type d'utilisateur en fonction de l'email
                    if (email.endsWith('@gmail.com')) {
                      // Redirection vers la page utilisateur
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else if (email.endsWith('@agence.com')) {
                      // Redirection vers la page agence (Dashboard)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Unknown user type")),
                      );
                    }
                  } catch (e) {
                    // Affiche une erreur si l'authentification échoue
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Login failed: $e")),
                    );
                  }
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Ajouter une logique pour "Mot de passe oublié"
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                       Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Create a new account',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
