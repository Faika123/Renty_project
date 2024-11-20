import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _commentController = TextEditingController();
  double _rating = 3.0;

  // Fonction pour soumettre le feedback à Firestore
  void _submitFeedback() async {
    if (_commentController.text.isNotEmpty) {
      // Crée un document dans Firestore dans la collection "feedback"
      await FirebaseFirestore.instance.collection('feedback').add({
        'comment': _commentController.text,
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Afficher un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted successfully!')),
      );

      // Effacer le champ de commentaire
      _commentController.clear();
    } else {
      // Si aucun commentaire n'est saisi, afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a comment.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light background for a soft look
      appBar: AppBar(
        title: Text('Submit Your Feedback',
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 54, 131, 245), // Dark blue shade
        elevation: 4.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              // Title
              Text(
                'We value your feedback!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 54, 131, 245), // Blue Accent
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please share your experience with us below.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 30),

              // Rating Section
              Text(
                'Rate your experience:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              SizedBox(height: 12),
              Slider(
                value: _rating,
                min: 1.0,
                max: 5.0,
                divisions: 4,
                label: _rating.toStringAsFixed(1),
                activeColor: Color.fromARGB(255, 54, 131, 245),
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Comment Section
              Text(
                'Your comment:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Write your feedback here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 54, 131, 245)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                maxLines: 5,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 54, 131, 245), // Button color
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Submit Feedback',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // Text color set to white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
