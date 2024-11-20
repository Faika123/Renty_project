import 'package:flutter/material.dart';
import 'reservationlist.dart';

class YourBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Booking',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ReservationListPage(
              status: 'Pending',
              reservations: [
                Reservation(
                  date: '2024/08/01 - 2024/08/08',
                  location: 'tozeur',
                  client: 'faika benzaara',
                  titre: 'mercedes',
                  price: 250,
                  imageUrl: 'assets/images/image2.jpg',
                ),
                Reservation(
                  date: '2024/09/01 - 2024/12/01',
                  location: 'tunis',
                  client: 'mariem charfi',
                  titre: 'range rover',
                  price: 450,
                  imageUrl: 'assets/images/image3.jpg',
                ),
              ],
            ),
            ReservationListPage(
              status: 'Accepted',
              reservations: [
                Reservation(
                  date: '2024/06/01 - 2024/06/10',
                  location: 'tozeur',
                  client: 'nour lassaid',
                  titre: 'mercedes',
                  price: 350,
                  imageUrl: 'assets/images/image4.jpg',
                ),
              ],
            ),
            ReservationListPage(
              status: 'Canceled',
              reservations: [
                Reservation(
                  date: '2024/05/01 - 2024/05/08',
                  location: 'gafsa',
                  client: 'nourhene saidi',
                   titre: 'mercedes',
                  price: 350,
                  imageUrl: 'assets/images/image5.jpg',
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
