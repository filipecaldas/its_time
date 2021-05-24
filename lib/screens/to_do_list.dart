import 'package:flutter/material.dart';
import 'package:its_time/database/dao/to_do_dao.dart';
import 'package:its_time/models/ToDo.dart';
import 'package:its_time/screens/to_do_form.dart';

class ToDoList extends StatefulWidget {
  final int idTicket;

  ToDoList(this.idTicket);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<ToDo> list = [];

  final ToDoDao _toDoDao = ToDoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "It's Time!",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ToDoForm(widget.idTicket),
                ),
              )
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<ToDo>>(
        initialData: List.empty(),
        future: _toDoDao.findAllWithTicketId(widget.idTicket),
        builder: (context, snapshot) {
          List<ToDo> toDos = snapshot.data;
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            print('project snapshot data is: ${snapshot.data}');
            return Text('Erro desconhecido');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Carregando"),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              ToDo toDo = toDos[index];
              return Card(
                key: Key(toDo.id.toString()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Row>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: toDo.conclusion,
                          onChanged: (newValue) {
                            setState(() {
                              toDo.conclusion = newValue;
                            });
                            _toDoDao.update(toDo);
                          },
                        ),
                        Text(toDo.title),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            debugPrint("Botão edit apertado");
                          },
                          child: Icon(Icons.edit),
                        ),
                        TextButton(
                          onPressed: () {
                            debugPrint("Botão delete apertado");
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
