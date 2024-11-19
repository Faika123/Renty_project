import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('bookings')
              .where('status', isEqualTo: 'Pending') // Optionally, filter by status
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final reservations = snapshot.data!.docs;

            if (reservations.isEmpty) {
              return Center(child: Text('No bookings available.'));
            }

            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                final data = reservation.data() as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email and Phone in the same row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.blue[800]),
                                SizedBox(width: 10),
                                Text(
                                  "Email: ${data['email']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.blue[800]),
                                SizedBox(width: 10),
                                Text(
                                 "Phone: ${data['phone']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Start Date, End Date, and Service Type
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.date_range, color: Colors.blue[800]),
                                SizedBox(width: 10),
                                Text(
                                  "Start: ${data['startDate']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.date_range, color: Colors.blue[800]),
                                SizedBox(width: 10),
                                Text(
                                  "End: ${data['endDate']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Service Type: ${data['serviceType']}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        // Buttons for Approve/Reject
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 36,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _approveBooking(reservation.id, data['userId']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Approve',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: SizedBox(
                                height: 36,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _rejectBooking(reservation.id, data['userId']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _approveBooking(String bookingId, String userId) async {
    // Update booking status to approved
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(bookingId)
        .update({'status': 'Approved'});

    // Send notification to the user
    await _sendBookingNotification(userId, 'Your booking has been approved.');
  }

  void _rejectBooking(String bookingId, String userId) async {
    // Update booking status to rejected
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(bookingId)
        .update({'status': 'Rejected'});

    // Send notification to the user
    await _sendBookingNotification(userId, 'Your booking has been rejected.');
  }

  Future<void> _sendBookingNotification(String userId, String message) async {
    // Send a notification to the user, e.g., using Firebase Cloud Messaging (FCM)
    // Assuming FCM is set up, you'd call an FCM service to send the notification
    // You can use Firebase Cloud Messaging to send the notification to the user here.

    // For now, let's just print a message
    print("Notification sent to $userId: $message");
  }
}
