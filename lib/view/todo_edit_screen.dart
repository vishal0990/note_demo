import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:note_demo/todo.dart';
import '../controllers/todo_controller.dart';


class TodoEditScreen extends StatefulWidget {
  final Todo todo;
  final int index;

  TodoEditScreen({required this.todo, required this.index});

  @override
  _TodoEditScreenState createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _contactController;
  late TextEditingController _linkController;
  late List<String> _multipleLinks;

  final TodoController todoController = Get.find(); // Access the controller

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController = TextEditingController(text: widget.todo.description);
    _contactController = TextEditingController(text: widget.todo.contact);
    _linkController = TextEditingController();
    _multipleLinks = widget.todo.multipleLinks;
  }

  void _updateTodo() {
    final updatedTodo = Todo(
      title: _titleController.text,
      description: _descriptionController.text,
      contact: _contactController.text,
      link: _linkController.text,
      multipleLinks: _multipleLinks,
      image: widget.todo.image,
    );

    todoController.updateTodo(widget.index, updatedTodo); // Update todo using GetX controller
    Get.back(); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit To-Do')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            TextField(controller: _contactController, decoration: const InputDecoration(labelText: 'Contact')),
            TextField(controller: _linkController, decoration: const InputDecoration(labelText: 'Link')),
            ElevatedButton(onPressed: _updateTodo, child: const Text('Update To-Do')),
          ],
        ),
      ),
    );
  }
}
