import 'package:flutter/material.dart';

class ToDoForm extends StatefulWidget {
  @override
  _ToDoFormState createState() => _ToDoFormState();
}

class _ToDoFormState extends State<ToDoForm> {
  bool isSwitchedAlert = false;
  bool isSwitchedPrevious = false;
  bool isSwitchedRepeat = false;
  bool isSwitchedAlarm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("It's Time!"),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Tarefa',
              ),
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Notas',
              ),
              style: TextStyle(
                fontSize: 18.0,
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
            ),
            Row(
              children: <Widget>[
                Switch(
                    value: isSwitchedAlert,
                    onChanged: (value) {
                      setState(() {
                        isSwitchedAlert = value;
                      });
                    }),
                Text("Lembrar"),
              ],
            ),
            Offstage(
              offstage: !isSwitchedAlert,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.date_range),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.access_time),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Switch(
                            value: isSwitchedPrevious,
                            onChanged: (value) {
                              setState(() {
                                isSwitchedPrevious = value;
                              });
                            }),
                        Text("Avisar com antecedência"),
                      ],
                    ),
                    Offstage(
                      offstage: !isSwitchedPrevious,
                      child: Row(
                        children: <Widget>[
                          TextButton(
                            onPressed: () {},
                            child: Icon(Icons.date_range),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Icon(Icons.access_time),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Switch(
                            value: isSwitchedRepeat,
                            onChanged: (value) {
                              setState(() {
                                isSwitchedRepeat = value;
                              });
                            }),
                        Text("Ativar repetição"),
                      ],
                    ),
                    Offstage(
                      offstage: !isSwitchedRepeat,
                      child: Column(
                        children: <Widget>[
                          //repetição diária
                          //repetição semanal
                          //repetição mensal
                          //repetição anul
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Switch(
                            value: isSwitchedAlarm,
                            onChanged: (value) {
                              setState(() {
                                isSwitchedAlarm = value;
                              });
                            }),
                        Text("Ativar alarme"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
