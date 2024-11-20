import 'package:flutter/material.dart';
import 'favoris.dart'; 
import 'cardetails.dart';

class CategoryCarsPage extends StatefulWidget {
  final String category;

  CategoryCarsPage({required this.category});

  @override
  _CategoryCarsPageState createState() => _CategoryCarsPageState();
}

class _CategoryCarsPageState extends State<CategoryCarsPage> {
  List<Map<String, dynamic>> favoriteCars = []; // Holds favorite cars

  final cars = [
    {
      'name': 'Mercedes S 580 Coupe (Noir), 2021',
      'price': 333,
      'discountedPrice': 306,
      'image': 'assets/images/image5.jpg',
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

  // Add or remove car from favorites
  void toggleFavorite(Map<String, dynamic> car) {
    setState(() {
      if (favoriteCars.contains(car)) {
        favoriteCars.remove(car); // Remove from favorites
      } else {
        favoriteCars.add(car); // Add to favorites
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Cars'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () async {
              // Navigate to FavorisPage and get the updated list
              final updatedFavorites = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavorisPage(favoriteItems: favoriteCars),
                ),
              );

              // Update the favoriteCars list with the returned data
              if (updatedFavorites != null) {
                setState(() {
                  favoriteCars = List<Map<String, dynamic>>.from(updatedFavorites);
                });
              }
            },
          ),
        ],
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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          car['image'] as String,
                          width: 120,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            favoriteCars.contains(car)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 24,
                          ),
                          onPressed: () => toggleFavorite(car),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car['name'] as String,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(car['location'] as String),
                        SizedBox(height: 8),
                        if (car['available'] as bool)
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 16),
                              SizedBox(width: 4),
                              Text('Disponible maintenant', style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        SizedBox(height: 8),
                        Text(
                          '\$${car['price']} / jour',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        if (car['discountedPrice'] != null)
                          Text(
                            '3-6 jours: \$${car['discountedPrice']}',
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
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