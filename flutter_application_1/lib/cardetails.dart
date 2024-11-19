import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(16),
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
                    icon: Icon(Icons.favorite_border,
                        color: Colors.red, size: 30),
                    onPressed: () {
                      // Implement favorite action
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              car['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${car['price']} / day',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              car['location'],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            _buildDescriptionSection(),
            _buildAvailabilitySection(),
            Divider(),
            _buildRentalRatesSection(),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _handleBooking(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
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

  Widget _buildDescriptionSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
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
    return Row(
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
        Text(
          'Rental Rates',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Table(
          children: [
            TableRow(
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('1 day'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('\$${car['price']}'),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('2-6 days'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
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
        SnackBar(content: Text('You need to log in to make a reservation.')),
      );
      Navigator.pushNamed(context, '/login');
    }
  }

  void _showReservationForm(BuildContext context) {
  DateTime? startDate;
  DateTime? endDate;
  
  // Déclarez les contrôleurs pour les champs email et téléphone
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 450,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Booking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildCustomTextField(label: 'Email', controller: emailController, icon: Icons.email),
              SizedBox(height: 12),
              _buildCustomTextField(label: 'Phone Number', controller: phoneController, icon: Icons.phone),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  startDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (startDate != null) {
                    startDateController.text = DateFormat('yyyy-MM-dd').format(startDate!);
                  }
                },
                child: AbsorbPointer(
                  child: _buildCustomTextField(
                    label: 'Start Date',
                    controller: startDateController,
                    icon: Icons.calendar_today,
                  ),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  endDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (endDate != null) {
                    endDateController.text = DateFormat('yyyy-MM-dd').format(endDate!);
                  }
                },
                child: AbsorbPointer(
                  child: _buildCustomTextField(
                    label: 'End Date',
                    controller: endDateController,
                    icon: Icons.calendar_today,
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildCustomDropdown(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Passez maintenant email et phone à _submitBooking
                  await _submitBooking(
                    context,
                    startDateController.text,
                    endDateController.text,
                    emailController.text,  // Ajoutez email
                    phoneController.text,   // Ajoutez phone
                  );
                  _showPaymentForm(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _submitBooking(BuildContext context, String startDate, String endDate, String email, String phone) async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    await FirebaseFirestore.instance.collection('bookings').add({
      'userId': user.uid,
      'carId': car['id'],
      'startDate': startDate,
      'endDate': endDate,
      'email': email,  // Assurez-vous d'ajouter l'email
      'phone': phone,  // Assurez-vous d'ajouter le téléphone
      'status': 'Pending',  // Statut de la réservation
    });
  }
}


  void _showPaymentForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Payment',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildCustomTextField(
                  label: 'Card Number', icon: Icons.credit_card),
              SizedBox(height: 12),
              _buildCustomTextField(
                  label: 'Expiry Date', icon: Icons.date_range),
              SizedBox(height: 12),
              _buildCustomTextField(label: 'CVV', icon: Icons.security),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Process payment logic here
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomTextField(
      {required String label,
      IconData? icon,
      TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildCustomDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Service Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: [
        DropdownMenuItem(
            value: 'Without Driver', child: Text('Without Driver')),
        DropdownMenuItem(value: 'With Driver', child: Text('With Driver')),
      ],
      onChanged: (value) {},
    );
  }
}
