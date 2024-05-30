

import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class TodoModelAsync {
  String id;
  String description;
  bool completed;
  TodoModelAsync({
    required this.id,
    required this.description,
    this.completed = false,
  });


  factory TodoModelAsync.add({required String description}) {
    return TodoModelAsync(
      id: uuid.v4(),
      description: description,
    );
  }




  @override
  String toString() => 'TodoModelAsync(id: $id, description: $description, completed: $completed)';
}
