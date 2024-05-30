

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_provider/models/todo_model.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);


  void addTodo(String description) {
    state = [
      ...state,
      Todo.add(description: description),
    ];

    // state.add(Todo.add(description: description));
    // print('in add todo : $state');
  }

  void toogleTodo(String id) {
    // state = state.map((todo) {
    //   return todo.id == id ? todo.copyWith(completed: !todo.completed) : todo;
    // }).toList();
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
    ];
    
  }

  void removeTodo(String id) {
    // state = state.where((todo) => todo.id != id).toList();
    state = [
      for (final todo in state)
        if (todo.id != id) todo
    ];
    
  }


}

final todoProvider = StateNotifierProvider.autoDispose<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});