import 'package:flutter/material.dart';
import 'listproduct.dart';
import 'productadd.dart';
import 'categories.dart';

class DashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> cards = [
    {
      "title": "Number of Products",
      "value": 19,
      "icon": Icons.shopping_bag,
      "color": Colors.purple
    },
    {
      "title": "Number of Bookings",
      "value": 10,
      "icon": Icons.calendar_today,
      "color": Colors.blue
    },
    {
      "title": "Number of category",
      "value": 13,
      "icon": Icons.person_add,
      "color": Colors.green
    },
    {
      "title": "Total Monthly Profit",
      "value": 55,
      "icon": Icons.attach_money,
      "color": Colors.red
    },
  ];

  final List<Map<String, String>> items = [
    {
      "name": "Product 1",
      "description": "Description of Product 1",
      "price": "\$20",
      "image": "assets/images/image2.jpg",
    },
    {
      "name": "Product 2",
      "description": "Description of Product 2",
      "price": "\$30",
      "image": "assets/images/image3.jpg",
    },
    {
      "name": "Product 3",
      "description": "Description of Product 2",
      "price": "\$30",
      "image": "assets/images/image4.jpg",
    },
    {
      "name": "Product 4",
      "description": "Description of Product 2",
      "price": "\$30",
      "image": "assets/images/image5.jpg",
    },
    {
      "name": "Product 5",
      "description": "Description of Product 2",
      "price": "\$30",
      "image": "assets/images/image6.jpg",
    },
    {
      "name": "Product 6",
      "description": "Description of Product 2",
      "price": "\$30",
      "image": "assets/images/image7.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Product List', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListProductPage(items: items),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Booking List', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductAddPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category List', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barre de recherche centrée
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
            // GridView des cartes
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cards[index]['title'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                cards[index]['value'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor:
                                cards[index]['color'].withOpacity(0.1),
                            child: Icon(
                              cards[index]['icon'],
                              color: cards[index]['color'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures the height is smaller
        iconSize: 24, // Adjust icon size to reduce the height further
        backgroundColor: Colors.white.withOpacity(0.9), // Set a transparent white background to match AppBar
        selectedItemColor: Colors.blue, // Change the selected item color
        unselectedItemColor: Colors.grey, // Change the unselected item color
        elevation: 5, // Optional, to add a subtle shadow
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
            backgroundColor: Colors.green,
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to Home Page (if you have one)
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListProductPage(items: items)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductAddPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoriesPage()),
            );
          }
        },
      ),
    );
  }
}
