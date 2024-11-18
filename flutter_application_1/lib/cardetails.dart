import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                    icon: Icon(Icons.favorite_border, color: Colors.red, size: 30),
                    onPressed: () {
                      // Implémenter l'action favori
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              car['location'],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Container(
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
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('Available Now', style: TextStyle(color: Colors.green)),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
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
                      child: Text('Rental Duration', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('Price per day', style: TextStyle(fontWeight: FontWeight.bold)),
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
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showReservationForm(context);
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

  void _showReservationForm(BuildContext context) {
    DateTime? startDate;
    DateTime? endDate;

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
          height: 400, // Réduisez la taille du modal
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
                _buildCustomTextField(label: 'Email', icon: Icons.email),
                SizedBox(height: 12),
                _buildCustomTextField(label: 'Phone Number', icon: Icons.phone),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () async {
                    startDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    startDateController.text = DateFormat('yyyy-MM-dd').format(startDate!);
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
                    endDateController.text = DateFormat('yyyy-MM-dd').format(endDate!);
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
                  onPressed: () {
                    // Implémenter la soumission de la réservation
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

  Widget _buildCustomTextField({
    required String label,
    TextEditingController? controller,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          prefixIcon: icon != null ? Icon(icon, color: Colors.blue) : null,
        ),
      ),
    );
  }

  Widget _buildCustomDropdown() {
    return Container(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Service Type',
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
        ),
        items: ['Without Driver', 'With Driver']
            .map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
            .toList(),
        onChanged: (value) {
          // Handle service type selection
        },
      ),
    );
  }
}
