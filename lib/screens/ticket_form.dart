import 'package:flutter/material.dart';
import 'package:its_time/database/dao/ticket_dao.dart';
import 'package:its_time/models/Ticket.dart';

class TicketForm extends StatefulWidget {
  final Ticket ticket;
  TicketForm({this.ticket});

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  TextEditingController _controllerName;
  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.red,
    Colors.brown,
    Colors.purple,
  ];
  Color dropdownValue;

  @override
  void initState() {
    super.initState();
    if (widget.ticket != null) {
      _controllerName = TextEditingController(text: widget.ticket.name);
      dropdownValue = colors[widget.ticket.color];
    } else {
      _controllerName = TextEditingController();
      dropdownValue = Colors.green;
    }
  }

  final TicketDao _ticketDao = TicketDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("It's Time!"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.ticket != null) {
            onUpdateTicket();
          } else {
            onCreateTicket();
          }
        },
        child: const Icon(Icons.check),
      ),
      body: form(),
    );
  }

  void onCreateTicket() {
    final String name = _controllerName.text;
    final int color = colors.indexOf(dropdownValue);
    final Ticket newTicket = Ticket(name: name, color: color);
    _ticketDao.create(newTicket).then((id) => {
          Navigator.pop(context),
        });
  }

  Widget selectColorButton() {
    return DropdownButton<Color>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (Color newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: colors.map<DropdownMenuItem<Color>>(
        (Color value) {
          return DropdownMenuItem(
            value: value,
            child: Container(
              width: 36.0,
              height: 36.0,
              color: value,
            ),
          );
        },
      ).toList(),
    );
  }

  Widget form() {
    return Column(
      children: <Widget>[
        TextField(
          controller: _controllerName,
          decoration: InputDecoration(
            labelText: 'Nome',
          ),
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        selectColorButton(),
      ],
    );
  }

  void onUpdateTicket() {
    widget.ticket.name = _controllerName.text;
    widget.ticket.color = colors.indexOf(dropdownValue);
    final Ticket updatedTicket = Ticket(
        id: widget.ticket.id,
        name: widget.ticket.name,
        color: widget.ticket.color);
    _ticketDao.update(updatedTicket).then((id) => {
          Navigator.pop(context),
        });
  }
}
