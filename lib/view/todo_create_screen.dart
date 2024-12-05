import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:image_picker/image_picker.dart';

import '../controllers/todo_controller.dart';
import '../todo.dart';

class TodoCreateScreen extends StatefulWidget {
  @override
  _TodoCreateScreenState createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends State<TodoCreateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();
  final _linkController = TextEditingController();
  final _multipleLinks = <String>[];
  Uint8List? _image;

  final TodoController todoController = Get.find(); // Access the controller

  void _addMultipleLinks(String link) {
    if (link.isNotEmpty) {
      setState(() {
        _multipleLinks.add(link);
        _linkController.clear();
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  void _saveTodo() {
    final todo = Todo(
      title: _titleController.text,
      description: _descriptionController.text,
      contact: _contactController.text,
      link: _linkController.text,
      multipleLinks: _multipleLinks,
      image: _image,
    );

    todoController.addTodo(todo); // Add todo using GetX controller
    Get.back(); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New To-Do')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title')),
              TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description')),
              TextField(
                  controller: _contactController,
                  decoration: const InputDecoration(labelText: 'Contact')),
              TextField(
                controller: _linkController,
                decoration: const InputDecoration(labelText: 'Link'),
                onSubmitted: (_) => _addMultipleLinks(_linkController.text),
              ),
              ElevatedButton(
                  onPressed: _pickImage, child: const Text('Pick Image')),
              if (_image != null)
                Image.memory(_image!, width: 100, height: 100),
              ElevatedButton(
                  onPressed: _saveTodo, child: const Text('Save To-Do')),
            ],
          ),
        ),
      ),
    );
  }
}
