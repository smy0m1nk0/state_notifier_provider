import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_provider/pages/todos_provider_async.dart';

class Todo extends ConsumerWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todos = ref.watch(todoChangeProvider).todos;
    print(todos);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          const AddTodo(),

          const SizedBox(height: 20.0),

          Expanded(
            child: ListView(children: [
              for (final todo in todos)
                ListTile(
                  title: Text(todo.description),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (value){
                      ref.read(todoChangeProvider).toggleTodo(todo.id);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: (){
                      ref.read(todoChangeProvider).removeTodos(todo.id);
                    },
                  ),
                )
            ])
          )
        ],
      )
    );

      

  }
}


class AddTodo extends ConsumerStatefulWidget {
  const AddTodo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'What needs to be done?',
          labelText: 'Add Todo',


        ),
        onSubmitted: (desc){
          if(desc.isNotEmpty){
            ref.read(todoChangeProvider.notifier).addTodos(desc);
            _controller.clear();
          }

        },
      ),
    );
  }
}
