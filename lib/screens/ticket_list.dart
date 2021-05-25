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
      child: Wrap(
        runSpacing: 40.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, size: 40.0),
                onSelected: (String result) {
                  if (result == 'delete') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert(context, 'Apagar',
                            'Deseja apagar essa etiqueta?', ticket);
                      },
                    );
                  } else {
                    pushRoute(TicketForm(ticket: ticket));
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Editar'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Apagar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Text(
              ticket.name,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget continueButton(BuildContext context, Ticket ticket) {
    return TextButton(
      child: Text("Continar"),
      onPressed: () {
        _ticketDao.delete(ticket.id).then((value) => setState(() {}));
        Navigator.of(context).pop();
      },
    );
  }

  Widget alert(
      BuildContext context, String title, String content, Ticket ticket) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton(context),
        continueButton(context, ticket),
      ],
    );
  }
}
