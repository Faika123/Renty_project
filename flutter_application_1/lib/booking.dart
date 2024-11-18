import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  final List<Map<String, String>> reservations = [
    {
      "email": "john.doe@example.com",
      "phone": "+1 234 567 890",
      "startDate": "2024-11-20",
      "endDate": "2024-11-25"
    },
    {
      "email": "jane.smith@example.com",
      "phone": "+1 987 654 321",
      "startDate": "2024-12-01",
      "endDate": "2024-12-05"
    },
    {
      "email": "alice.jones@example.com",
      "phone": "+1 555 666 777",
      "startDate": "2024-12-10",
      "endDate": "2024-12-15"
    },
  ];

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
        child: ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];
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
                              reservation['email']!,
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
                              reservation['phone']!,
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
                    // Start Date and End Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.date_range, color: Colors.blue[800]),
                            SizedBox(width: 10),
                            Text(
                              "Start: ${reservation['startDate']!}",
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
                              "End: ${reservation['endDate']!}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: SizedBox(
                            height: 36, // Reduce button height
                            child: ElevatedButton(
                              onPressed: () {
                                // Approve logic
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
                        SizedBox(width: 2), // Space between buttons
                        Flexible(
                          child: SizedBox(
                            height: 36, // Reduce button height
                            child: ElevatedButton(
                              onPressed: () {
                                // Reject logic
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
        ),
      ),
    );
  }
}
