import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProductConfirmationPage extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String category;
  final Uint8List? image;

  // Constructor pour recevoir les données du produit
  ProductConfirmationPage({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Product Confirmation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your product has been successfully added!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 30),
              Text('Title: $title', style: TextStyle(fontSize: 18)),
              Text('Description: $description', style: TextStyle(fontSize: 18)),
              Text('Price: \$ $price', style: TextStyle(fontSize: 18)),
              Text('Category: $category', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              
              // Affichage de l'image si elle est présente
              image != null
                ? Image.memory(image!, fit: BoxFit.cover)
                : Icon(Icons.image, size: 100, color: Colors.blue),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);  // Retour à la page précédente (ProductAddPage)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
