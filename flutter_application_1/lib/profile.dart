import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // Add userId to identify the document to update/delete
  final Map<String, dynamic> userData;

  ProfilePage({required this.userId, required this.userData});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController; // Optional: Only if you want to allow password changes
  late TextEditingController confirmPasswordController; // Optional: Only if you want to allow password changes

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData['name']);
    emailController = TextEditingController(text: widget.userData['email']);
    phoneController = TextEditingController(text: widget.userData['phone']);
    passwordController = TextEditingController(); // Clear initially
    confirmPasswordController = TextEditingController(); // Clear initially
  }

  Future<void> updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          // Optionally include password logic if necessary
          // 'password': passwordController.text, 
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User data updated successfully')));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update user: $error')));
      }
    }
  }

  Future<void> deleteUser() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User deleted successfully')));
     // Navigator.of(context).pop(); // Go back after deletion
     Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete user: $error')));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Your Name"),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 16),
              Text("Email"),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              SizedBox(height: 16),
              Text("Phone"),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Your Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              SizedBox(height: 16),
              Text("Password"),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: '********',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Text("Confirm Password"),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: '********',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 32),
              // Buttons for editing and deleting
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: updateUser,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text("Edit", style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog before deleting
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text('Are you sure you want to delete your account?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(), // Cancel
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteUser(); // Call the delete function
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      backgroundColor: Colors.red,
                    ),
                    child: Text("Delete", style: TextStyle(color: Colors.white)),
                    
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
