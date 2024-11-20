import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationPage extends StatelessWidget {
  final Map<String, dynamic> car;

  ReservationPage({required this.car});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime? startDate;
    DateTime? endDate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Complete Your Reservation",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            _buildCustomTextField(
                label: 'Email',
                controller: emailController,
                icon: Icons.email),
            const SizedBox(height: 16),
            _buildCustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                icon: Icons.phone),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            _buildCustomDropdown(),
            const SizedBox(height: 24),
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
                backgroundColor: Colors.blue.shade700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Confirm Reservation',
                style: TextStyle(fontSize: 18, color: Colors.white),
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
        'carId': car['id'],
        'startDate': startDate,
        'endDate': endDate,
        'email': email,
        'phone': phone,
        'status': 'Pending',
      });
    }
  }

  Widget _buildCustomTextField(
      {required String label,
      IconData? icon,
      TextEditingController? controller}) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue.shade700),
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
        ),
      ),
    );
  }

  Widget _buildCustomDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Service Type',
        labelStyle: TextStyle(color: Colors.blue.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      items: const [
        DropdownMenuItem(
            value: 'Without Driver', child: Text('Without Driver')),
        DropdownMenuItem(value: 'With Driver', child: Text('With Driver')),
      ],
      onChanged: (value) {},
    );
  }

  void _showPaymentForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Payment Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildCustomTextField(
                  label: 'Card Number', icon: Icons.credit_card),
              const SizedBox(height: 16),
              _buildCustomTextField(
                  label: 'Expiry Date', icon: Icons.date_range),
              const SizedBox(height: 16),
              _buildCustomTextField(label: 'CVV', icon: Icons.security),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
