import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:nisham/model/todo.dart';
import 'package:nisham/provider/todos.dart';
import 'package:nisham/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(todo.id),
          actions: [
            if(!todo.isDone)
            IconSlideAction(
              color: Colors.green,
              onTap: (){
                final provider =
                Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);
              },
              caption: 'Done',
              icon: Icons.done,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteTodo(context, todo),
              icon: Icons.delete,
            )
          ],
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        child: Container(
          color: todo.isDone?Colors.transparent:Colors.orange,
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(12.0),
                        child: Stack(
                          children: <Widget>[
                            Text(
                              todo.reminder,
                              style: TextStyle(
                                fontSize: 28
                              ),
                            ),
                            if(todo.isDone)...[
                              Container(
                                child: Text(
                                  todo.reminder,
                                  style: TextStyle(
                                    color: todo.isDone?Colors.grey:Colors.transparent,
                                    decorationColor: Colors.grey,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decoration:
                                    TextDecoration.lineThrough,
                                    fontSize: 28,
                                  ),
                                ),
                              )]
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

}
