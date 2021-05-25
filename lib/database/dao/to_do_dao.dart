import 'package:its_time/database/app_database.dart';
import 'package:its_time/models/ToDo.dart';
import 'package:sqflite/sqflite.dart';

class ToDoDao {
  Future<int> create(ToDo toDo) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> toDoMap = Map();

    toDo.convertBooltoInt();

    toDoMap['title'] = toDo.title;
    toDoMap['description'] = toDo.description;
    toDoMap['conclusion'] = toDo.intConclusion;
    toDoMap['alert'] = toDo.intAlert;
    toDoMap['alert_date'] = toDo.alertDate;
    toDoMap['alert_time'] = toDo.alertTime;
    toDoMap['previous'] = toDo.intPrevious;
    toDoMap['previous_date'] = toDo.previousDate;
    toDoMap['previous_time'] = toDo.previousTime;
    toDoMap['repeat'] = toDo.repeat;
    toDoMap['repeat_weekly'] = toDo.repeatWeekly;
    toDoMap['alarm'] = toDo.intAlarm;
    toDoMap['id_ticket'] = toDo.idTicket;

    return db.insert('todo', toDoMap);
  }

  Future<List<ToDo>> findAllWithTicketId(int idTicket) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query('todo', where: 'id_ticket = ?', whereArgs: [idTicket]);
    final List<ToDo> toDos = [];

    for (Map<String, dynamic> row in result) {
      final ToDo toDo = ToDo(
        id: row['id'],
        title: row['title'],
        description: row['description'],
        intConclusion: row['conclusion'],
        intAlert: row['alert'],
        alertDate: row['alert_date'],
        alertTime: row['alert_time'],
        intPrevious: row['previous'],
        previousDate: row['previous_date'],
        previousTime: row['previous_time'],
        repeat: row['repeat'],
        repeatWeekly: row['repeat_weekly'],
        intAlarm: row['alarm'],
        idTicket: row['id_ticket'],
      );

      toDo.convertIntToBool();

      toDos.add(toDo);
    }
    return toDos;
  }

  Future<int> updateCheckConclusion(ToDo toDo) async {
    toDo.convertBooltoInt();

    final Database db = await getDatabase();

    return await db.update('todo', {'conclusion': toDo.intConclusion},
        where: 'id = ?', whereArgs: [toDo.id]);
  }

  Future<int> update(ToDo toDo) async {
    toDo.convertBooltoInt();

    final Database db = await getDatabase();

    return await db.update(
        'todo',
        {
          'title': toDo.title,
          'description': toDo.description,
          'alert': toDo.intAlert,
          'alert_date': toDo.alertDate,
          'alert_time': toDo.alertTime,
          'previous': toDo.intPrevious,
          'previous_date': toDo.previousDate,
          'previous_time': toDo.previousTime,
          'repeat': toDo.repeat,
          'repeat_weekly': toDo.repeatWeekly,
          'alarm': toDo.intAlarm
        },
        where: 'id = ?',
        whereArgs: [toDo.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();

    return await db.delete("todo", where: 'id = ?', whereArgs: [id]);
  }
}
