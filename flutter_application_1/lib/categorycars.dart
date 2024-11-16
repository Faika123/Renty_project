import 'package:flutter/material.dart';
import 'cardetails.dart';

class CategoryCarsPage extends StatelessWidget {
  final String category;

  CategoryCarsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    // Example car data
    final cars = [
      {
        'name': 'Mercedes S 580 Coupe (Noir), 2021',
        'price': 333,
        'discountedPrice': 306,
        'image': 'assets/images/image5.jpg', // Replace with real image paths
        'location': '250 km per day · Tunis · Insurance included',
        'available': true,
      },
      {
        'name': 'Mercedes EQS 53 AMG (Blanc), 2023',
        'price': 264,
        'discountedPrice': 250,
        'image': 'assets/images/image3.jpg',
        'location': '250 km per day · Tunis · Insurance included',
        'available': true,
      },
      {
        'name': 'Mercedes EQS 580 (Noir), 2023',
        'price': 236,
        'discountedPrice': 222,
        'image': 'assets/images/image4.jpg',
        'location': '250 km per day · Tunis · Insurance included',
        'available': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Cars'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car image
                  Image.asset(
                    car['image'] as String,
                    width: 120,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  // Car details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car['name'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(car['location'] as String),
                        SizedBox(height: 8),
                        // Display availability status
                        if (car['available'] as bool)
                          Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 16),
                              SizedBox(width: 4),
                              Text('Disponible maintenant',
                                  style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        SizedBox(height: 8),
                        // Display price with discounted price option
                        Text(
                          '\$${car['price']} / jour',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        if (car['discountedPrice'] != null)
                          Text(
                            '3-6 jours: \$${car['discountedPrice']}',
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                  // Action buttons
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(car: car),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Text('Détails Location'),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
