import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'favoris.dart';
import 'ReservationPage.dart';

class CarDetailsPage extends StatelessWidget {
  final Map<String, dynamic> car;

  CarDetailsPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['name']),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  car['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border,
                        color: Colors.red, size: 30),
                    onPressed: () async {
                      final User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await _addToFavorites(user.uid, car);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to favorites')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please log in to add favorites.')),
                        );
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              car['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${car['price']} / day',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              car['location'],
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildDescriptionSection(),
            _buildAvailabilitySection(),
            const Divider(),
            _buildRentalRatesSection(),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _handleBooking(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addToFavorites(String userId, Map<String, dynamic> car) async {
    final favoritesRef =
        FirebaseFirestore.instance.collection('favorites').doc(userId);

    try {
      await favoritesRef.set({
        'items': FieldValue.arrayUnion([car])
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error adding to favorites: $e");
    }
  }

  Widget _buildDescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'This car is perfect for city drives and long trips, offering a smooth ride, excellent fuel efficiency, and luxurious features.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySection() {
    return const Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 8),
        Text('Available Now', style: TextStyle(color: Colors.green)),
      ],
    );
  }

  Widget _buildRentalRatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rental Rates',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Table(
          children: [
            const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Rental Duration',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Price per day',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('1 day'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('\$${car['price']}'),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('2-6 days'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('\$${car['discountedPrice']}'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _handleBooking(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _showReservationForm(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need to log in to make a reservation.')),
      );
      Navigator.pushNamed(context, '/login');
    }
  }

  void _showReservationForm(BuildContext context) {
    Navigator.pushNamed(context, '/reservation', arguments: car);
  }
}
