import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'listproduct.dart'; // Importez votre page ListProductPage

class ProductAddPage extends StatefulWidget {
  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  String? _category;
  String? _availability;

  // Fonction pour ajouter un produit dans Firestore
  Future<void> _addProductToFirestore() async {
    try {
      final product = {
        'title': _titleController.text,
        'phone': _phoneController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'price': double.tryParse(_priceController.text),
        'category': _category,
        'imageUrl': _imageUrlController.text,
        'availability': _availability,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('products').add(product);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully!')),
      );

      // Réinitialiser le formulaire après l'ajout
      _formKey.currentState?.reset();
      _titleController.clear();
      _phoneController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _priceController.clear();
      _imageUrlController.clear();
      setState(() {
        _category = null;
        _availability = null;
      });

      // Naviguer vers la page ListProductPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListProductPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Add Product', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titre
                  Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Champ Titre
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.title, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Champ Téléphone
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone, color: Colors.blue),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),

                  // Champ Description
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.description, color: Colors.blue),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),

                  // Champ Localisation
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Ligne : Prix et Catégorie
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: 'Price',
                            prefixIcon:
                                Icon(Icons.monetization_on, color: Colors.blue),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Category',
                          ),
                          items: [
                            DropdownMenuItem(
                                child: Text('Luxury cars'), value: 'Luxury cars'),
                            DropdownMenuItem(
                                child: Text('Sports cars'), value: 'Sports cars'),
                            DropdownMenuItem(
                                child: Text('VIP cars'), value: 'VIP cars'),
                            DropdownMenuItem(
                                child: Text('Prestige cars'),
                                value: 'Prestige cars'),
                            DropdownMenuItem(
                                child: Text('Economy cars'), value: 'Economy cars'),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Champ URL de l'image
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      prefixIcon: Icon(Icons.link, color: Colors.blue),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: 20),

                  // Dropdown Disponibilité
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Availability',
                      prefixIcon: Icon(Icons.check_circle, color: Colors.blue),
                    ),
                    items: [
                      DropdownMenuItem(
                          child: Text('Available Now'), value: 'Available Now'),
                      DropdownMenuItem(
                          child: Text('Not Available'), value: 'Not Available'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _availability = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),

                  // Bouton Ajouter
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addProductToFirestore();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
