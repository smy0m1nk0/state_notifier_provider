

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_provider/models/todo_model_async.dart';


class TodosChangeNotifier extends ChangeNotifier{

  List<TodoModelAsync> todos = [];

  void addTodos (String description){
    todos.add(TodoModelAsync.add(description: description));
    notifyListeners();
  }

  void toggleTodo(String id){
    final todo = todos.firstWhere((todo) => todo.id == id);
    todo.completed = !todo.completed;

    notifyListeners();
   
  }

  void removeTodos(String id){
    todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

}

final todoChangeProvider = ChangeNotifierProvider.autoDispose<TodosChangeNotifier>((ref) {
  return TodosChangeNotifier();
});