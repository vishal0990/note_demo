import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../todo.dart';

class TodoController extends GetxController {
  var todoBox = Hive.box<Todo>('todosBox').obs; // Observable box

  void addTodo(Todo todo) {
    todoBox.value.add(todo);
    update(); // Update the UI when data changes
  }

  void updateTodo(int index, Todo updatedTodo) {
    todoBox.value.putAt(index, updatedTodo);
    update(); // Update UI after editing
  }

  void deleteTodo(int index) {
    todoBox.value.deleteAt(index);
    update(); // Update UI after deleting
  }
}
