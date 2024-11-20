import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile.dart';
import 'login.dart';
import 'yourbooking.dart';
import 'FeedbackList.dart';

class Personalinfo extends StatelessWidget {
  const Personalinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    // If the user is not logged in, redirect to the login page
    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Info',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
               IconButton(
            icon: Icon(Icons.feedback, color: Colors.black),
            onPressed: () {
                  
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackListPage()),
                );
              
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/images2.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Faika Benzaara',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            PersonalinfoOptionCard(
              icon: Icons.person,
              title: 'Personal info',
              subtitle: 'Provide personal details and how we can reach you',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            PersonalinfoOptionCard(
              icon: Icons.home,
              title: 'Your Booking',
              subtitle: 'Manage and view your current reservations easily',
              onTap: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YourBookingPage()),
                );
              },
            ),
            PersonalinfoOptionCard(
              icon: Icons.verified_user,
              title: 'Verify your account',
              subtitle: 'It\'s simple to get set up and start earning',
              onTap: () {},
            ),
            PersonalinfoOptionCard(
              icon: Icons.bolt,
              title: 'Boost your post',
              subtitle: 'Increase visibility for your listings',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalinfoOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const PersonalinfoOptionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
