import 'package:its_time/database/app_database.dart';
import 'package:its_time/models/ToDo.dart';
import 'package:sqflite/sqflite.dart';

class ToDoDao {
  Future<int> create(ToDo toDo) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> toDoMap = Map();

    toDoMap['title'] = toDo.title;
    toDoMap['description'] = toDo.description;
    toDoMap['conclusion'] = toDo.conclusion;
    toDoMap['alert'] = toDo.alert;
    toDoMap['alett_date'] = toDo.alertDate;
    toDoMap['alert_time'] = toDo.alertTime;
    toDoMap['previous'] = toDo.previous;
    toDoMap['previous_date'] = toDo.previousDate;
    toDoMap['previous_time'] = toDo.previousTime;
    toDoMap['repeat'] = toDo.repeat;
    toDoMap['repeat_weekly'] = toDo.repeatWeekly;
    toDoMap['alarm'] = toDo.alarm;

    return db.insert('todo', toDoMap);
  }

  Future<List<ToDo>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('todo');
    final List<ToDo> toDos = [];

    for (Map<String, dynamic> row in result) {
      final ToDo toDo = ToDo(
        id: row['id'],
        title: row['title'],
        description: row['description'],
        alert: row['alert'],
        alertDate: row['alert_date'],
        alertTime: row['alert_time'],
        previous: row['previous'],
        previousDate: row['previous_date'],
        previousTime: row['previous_time'],
        repeat: row['repeat'],
        repeatWeekly: row['repeat_weekly'],
        alarm: row['alarm'],
      );

      toDos.add(toDo);
    }

    return toDos;
  }
}
