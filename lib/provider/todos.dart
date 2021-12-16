import 'package:flutter/cupertino.dart';
import 'package:nisham/api/firebase_api.dart';
import 'package:nisham/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title) {
    todo.reminder = title;

    FirebaseApi.updateTodo(todo);
  }
}
