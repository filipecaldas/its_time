import 'package:flutter/material.dart';
import 'package:its_time/components/loading.dart';
import 'package:its_time/database/dao/ticket_dao.dart';
import 'package:its_time/models/Ticket.dart';
import 'package:its_time/screens/ticket_form.dart';
import 'package:its_time/screens/to_do_list.dart';

class TicketList extends StatefulWidget {
  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  final TicketDao _ticketDao = TicketDao();
  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.red,
    Colors.brown,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("It's Time!"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushRoute(TicketForm());
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Ticket>>(
          initialData: List.empty(),
          future: _ticketDao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return loadingScreen();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                return gridViewBuild(snapshot);
                break;
            }
            return Text("Erro desconhecido");
          }),
    );
  }

  void pushRoute(Object screen) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        )
        .then((value) => setState(() {}));
  }

  Widget gridViewBuild(AsyncSnapshot snapshot) {
    final List<Ticket> tickets = snapshot.data;

    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        snapshot.data.length,
        (index) => GestureDetector(
          onTap: () {
            pushRoute(ToDoList(tickets[index].id));
          },
          child: eachTicket(tickets[index]),
        ),
      ),
    );
  }

  Widget eachTicket(Ticket ticket) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: colors[ticket.color],
      width: 32.0,
      height: 32.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(ticket.name),
          ],
        ),
      ),
    );
  }
}
