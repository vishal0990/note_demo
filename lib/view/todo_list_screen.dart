import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:note_demo/todo.dart';

import '../controllers/todo_controller.dart';
import 'todo_create_screen.dart';
import 'todo_edit_screen.dart';

class TodoListScreen extends StatelessWidget {
  final TodoController todoController =
      Get.put(TodoController()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Obx(() {
        if (todoController.todoBox.value.isEmpty) {
          return const Center(child: Text('No to-do items.'));
        } else {
          return ListView.builder(
            itemCount: todoController.todoBox.value.length,
            itemBuilder: (context, index) {
              Todo todo = todoController.todoBox.value.getAt(index)!;
              return ListTile(
                leading: todo.image != null
                    ? Image.memory(todo.image!) // Display image from Uint8List
                    : const Icon(Icons.image),
                title: Text(todo.title),
                subtitle: Text(todo.description),
                onTap: () {
                  // Navigate to edit screen with the selected todo
                  Get.to(() => TodoEditScreen(todo: todo, index: index));
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    todoController.deleteTodo(index);
                  },
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add todo screen
          Get.to(() => TodoCreateScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
