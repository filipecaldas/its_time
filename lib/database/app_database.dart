import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'itstime.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE ticket('
          'id INTEGER PRIMARY KEY,'
          'color INTEGER,'
          'name TEXT'
          ')');
      db.execute('CREATE TABLE todo('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'description TEXT,'
          'conclusion INTEGER,'
          'alert INTEGER,'
          'alert_date TEXT,'
          'alert_time TEXT,'
          'previous INTEGER,'
          'previous_date TEXT,'
          'previous_time TEXT,'
          'repeat INTEGER,'
          'repeat_weekly TEXT,'
          'alarm INTEGER,'
          'id_ticket INTEGER,'
          'FOREIGN KEY(id_ticket) REFERENCES ticket(id)'
          ')');
    },
    version: 1,
  );
}
