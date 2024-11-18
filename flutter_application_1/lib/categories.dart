import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<Map<String, String>> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    final categoryRef = FirebaseFirestore.instance.collection('categories');
    try {
      final querySnapshot = await categoryRef.get();
      setState(() {
        categories.clear();
        for (var doc in querySnapshot.docs) {
          categories.add({
            'id': doc.id,
            'name': doc['name'],
            'description': doc['description'],
          });
        }
      });
    } catch (e) {
      print("Error loading categories: $e");
    }
  }

  void _addCategory(String name, String description) async {
    final categoryRef = FirebaseFirestore.instance.collection('categories');

    try {
      await categoryRef.add({
        'name': name,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });

      setState(() {
        categories.add({
          'id': (categories.length + 1).toString(),
          'name': name,
          'description': description,
        });
      });
    } catch (e) {
      print("Error adding category: $e");
    }
  }

  void _editCategory(String id, String name, String description) async {
    final categoryRef = FirebaseFirestore.instance.collection('categories').doc(id);

    try {
      await categoryRef.update({
        'name': name,
        'description': description,
      });

      setState(() {
        // Update the category locally in the list after editing
        final categoryIndex = categories.indexWhere((category) => category['id'] == id);
        if (categoryIndex != -1) {
          categories[categoryIndex] = {
            'id': id,
            'name': name,
            'description': description,
          };
        }
      });
    } catch (e) {
      print("Error editing category: $e");
    }
  }

  void _deleteCategory(String id) async {
    final categoryRef = FirebaseFirestore.instance.collection('categories').doc(id);

    try {
      await categoryRef.delete();

      setState(() {
        categories.removeWhere((category) => category['id'] == id);
      });
    } catch (e) {
      print("Error deleting category: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Category List',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddCategoryDialog(onAdd: _addCategory),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
                child: const Text(
                  'Add Category',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blueAccent.withOpacity(0.8)),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('NAME')),
                    DataColumn(label: Text('DESCRIPTION')),
                    DataColumn(label: Text('ACTIONS')),
                  ],
                  rows: categories.map((category) {
                    return DataRow(
                      cells: [
                        DataCell(Text(category['id']!)),
                        DataCell(Text(category['name']!)),
                        DataCell(Text(category['description']!)),
                        DataCell(
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => EditCategoryDialog(
                                      category: category,
                                      onEdit: (String name, String description) async {
                                        _editCategory(category['id']!, name, description);
                                      },
                                    ),
                                  );
                                },
                                child: const Text('Edit'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () async {
                                  _deleteCategory(category['id']!);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCategoryDialog extends StatefulWidget {
  final Function(String name, String description) onAdd;

  AddCategoryDialog({required this.onAdd});

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Category'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Icons.category),
                filled: true,
                fillColor: Colors.blue.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
                filled: true,
                fillColor: Colors.blue.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onAdd(
                _nameController.text,
                _descriptionController.text,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class EditCategoryDialog extends StatefulWidget {
  final Map<String, String> category;
  final Function(String name, String description) onEdit;

  EditCategoryDialog({required this.category, required this.onEdit});

  @override
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.category['name']!;
    _descriptionController.text = widget.category['description']!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Category'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Icons.category),
                filled: true,
                fillColor: Colors.blue.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                }
                return null; 
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
                filled: true,
                fillColor: Colors.blue.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onEdit(
                _nameController.text,
                _descriptionController.text,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
