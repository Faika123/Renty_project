import 'package:flutter/material.dart';
import 'package:flutter_application_1/favoris.dart';
import 'package:flutter_application_1/feedback.dart';
import 'categorycars.dart';
import 'login.dart';
import 'profile.dart';
import 'favoris.dart';
import 'Notification.dart';
import 'feedback.dart';
import 'FeedbackList.dart';
import 'personalinfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation based on index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FavorisPage(
                    favoriteItems: [],
                  )),
        );
        break;
      case 2:
        // Navigate to Messages
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 243, 243),
        elevation: 0,
        title: Text(
          "Renty.com",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage(userId: '',)),
                );
            },
          ),
    
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Personalinfo()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoris'),
              onTap: () {
             
              },
            ),
               ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('feedback'),
              onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  'Location de voitures à Tunis',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Trouvez la voiture de vos rêves en 60 secondes',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Rechercher par marque ou modèle',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Toutes catégories',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 28),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      buildCategoryCard(
                          'Luxury cars', Icons.directions_car, context),
                      SizedBox(width: 10),
                      buildCategoryCard(
                          'Sports cars', Icons.sports_motorsports, context),
                      SizedBox(width: 10),
                      buildCategoryCard('VIP cars', Icons.car_rental, context),
                      SizedBox(width: 10),
                      buildCategoryCard('Prestige cars', Icons.star, context),
                      SizedBox(width: 10),
                      buildCategoryCard(
                          'Economy cars', Icons.car_repair, context),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      buildCarCard("GMC Yukon (Black), 2024", "4.7", "\$167",
                          "assets/images/image2.jpg"),
                      buildCarCard("Nissan Patrol V6 (Beige), 2024", "4.8",
                          "\$136", "assets/images/image4.jpg"),
                      buildCarCard("BMW 430i cabrio (White), 2021", "4.7",
                          "\$278", "assets/images/image3.jpg"),
                      buildCarCard("GMC Denali (Black), 2024", "4.6", "\$208",
                          "assets/images/image5.jpg"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50, // Reduce the height to adjust the footer size
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 20), // Adjust icon size
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 20),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail, size: 20),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 20),
              label: '',
            ),
          ],
          selectedItemColor: const Color.fromARGB(255, 7, 7, 7),
          unselectedItemColor:
              const Color.fromARGB(255, 7, 7, 7).withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 249, 243, 243).withOpacity(0.8),
          elevation: 5,
        ),
      ),
    );
  }

  Widget buildCategoryCard(String text, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryCarsPage(category: text),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            SizedBox(height: 8),
            Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarCard(
      String name, String rating, String price3To6Days, String imagePath) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      // Handle favorite action here
                    },
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red, // Red color for favorite icon
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  Text(' $rating'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "3-6 Days: $price3To6Days",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
