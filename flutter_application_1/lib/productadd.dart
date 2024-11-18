import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddPage extends StatefulWidget {
  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final _formKey = GlobalKey<FormState>();
  XFile? _imageFile;
  Uint8List? _imageData;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = pickedFile;
        _imageData = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  // Title above the form
                  Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20), // Space between title and form

                  // Title TextField
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.title, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Phone TextField
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.phone, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),

                  // Description TextField
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.description, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),

                  // Location TextField
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Price and Category fields in a Row
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Price',
                            labelStyle: TextStyle(color: Colors.blue),
                            prefixIcon: Icon(Icons.monetization_on, color: Colors.blue),
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: TextStyle(color: Colors.blue),
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                                child: Text('Luxury cars'), value: 'Luxury cars'),
                            DropdownMenuItem(
                                child: Text('Sports cars'), value: 'Sports cars'),
                            DropdownMenuItem(
                                child: Text('VIP cars'), value: 'VIP cars'),
                            DropdownMenuItem(
                                child: Text('Prestige cars'), value: 'Prestige cars'),
                            DropdownMenuItem(
                                child: Text('Economy cars'), value: 'Economy cars'),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Image picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade50),
                      ),
                      child: _imageData == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo, size: 50, color: Colors.blue),
                                Text('Select a photo',
                                    style: TextStyle(color: Colors.blue)),
                              ],
                            )
                          : Image.memory(
                              _imageData!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Submit button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Add product',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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