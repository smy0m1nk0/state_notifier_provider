import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_provider/pages/todos_provider.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todos = ref.watch(todoProvider);
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
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index){
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.description),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (value){
                      ref.read(todoProvider.notifier).toogleTodo(todo.id);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: (){
                      ref.read(todoProvider.notifier).removeTodo(todo.id);
                    },
                  ),
                );
              },
            ),
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
            ref.read(todoProvider.notifier).addTodo(desc);
            _controller.clear();
          }

        },
      ),
    );
  }
}
