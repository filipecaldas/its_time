import 'package:flutter/material.dart';
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
  List<Color> colors = [
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
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => TicketForm(),
                ),
              )
              .then((value) => setState(() {}));
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
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando"),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Ticket> tickets = snapshot.data;
                return GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    snapshot.data.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ToDoList(tickets[index].id)),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        color: colors[tickets[index].color],
                        width: 32.0,
                        height: 32.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(tickets[index].name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
                break;
            }
            return Text("Erro desconhecido");
          }),
    );
  }
}
