import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? userType;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (userType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an account type')),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Update display name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      // Show success message and navigate to login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Specific Firebase error handling
      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email is already in use. Please use a different email.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak. Please use a stronger password.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.blue),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24),
                margin: EdgeInsets.symmetric(horizontal: 30),
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
                  children: [
                    Text(
                      'Create new account',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Name Field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Email Field
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Phone Number Field
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.phone, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Account Type Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Account Type',
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.account_box, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      value: userType,
                      items: ['User', 'Agence'].map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          userType = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Confirm Password Field
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Sign Up Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _register,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // "Already have an account?" Login Link
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
