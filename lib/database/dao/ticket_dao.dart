import 'package:its_time/database/app_database.dart';
import 'package:its_time/models/Ticket.dart';
import 'package:sqflite/sqflite.dart';

class TicketDao {
  Future<int> create(Ticket ticket) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> ticketMap = Map();

    ticketMap['name'] = ticket.name;
    ticketMap['color'] = ticket.color;

    return db.insert('ticket', ticketMap);
  }

  Future<List<Ticket>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('ticket');
    final List<Ticket> tickets = [];

    for (Map<String, dynamic> row in result) {
      final Ticket ticket = Ticket(
        id: row['id'],
        name: row['name'],
        color: row['color'],
      );

      tickets.add(ticket);
    }

    return tickets;
  }
}