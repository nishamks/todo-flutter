import 'package:flutter/cupertino.dart';
import 'package:nisham/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String reminder;
  String id;
  bool isDone;

  Todo({
    @required this.createdTime,
    @required this.reminder,
    this.id,
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime']),
        reminder: json['reminder'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'reminder': reminder,
        'id': id,
        'isDone': isDone,
      };
}
