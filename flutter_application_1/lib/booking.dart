import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final Map<String, dynamic> car;

  BookingPage({required this.car});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? startDate;
  DateTime? endDate;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking ${widget.car['name']}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCustomTextField(
                label: 'Email', controller: emailController, icon: Icons.email),
            SizedBox(height: 12),
            _buildCustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                icon: Icons.phone),
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
                  startDateController.text =
                      DateFormat('yyyy-MM-dd').format(startDate!);
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
                  endDateController.text =
                      DateFormat('yyyy-MM-dd').format(endDate!);
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
                await _submitBooking(
                  context,
                  startDateController.text,
                  endDateController.text,
                  emailController.text,
                  phoneController.text,
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
  }

  Future<void> _submitBooking(BuildContext context, String startDate,
      String endDate, String email, String phone) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance.collection('bookings').add({
        'userId': user.uid,
        'carId': widget.car['id'],
        'startDate': startDate,
        'endDate': endDate,
        'email': email,
        'phone': phone,
        'status': 'Pending',
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
                label: 'Card Number',
                icon: Icons.credit_card,
              ),
              SizedBox(height: 12),
              _buildCustomTextField(
                label: 'Expiry Date',
                icon: Icons.date_range,
              ),
              SizedBox(height: 12),
              _buildCustomTextField(
                label: 'CVV',
                icon: Icons.security,
              ),
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
