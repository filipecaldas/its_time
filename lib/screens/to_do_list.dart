import 'package:flutter/material.dart';
import 'package:its_time/components/loading.dart';
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
          pushRoute(ToDoForm(widget.idTicket));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<ToDo>>(
        initialData: List.empty(),
        future: _toDoDao.findAllWithTicketId(widget.idTicket),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            print('project snapshot data is: ${snapshot.data}');
            return Text('Erro desconhecido');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          return listViewBuild(snapshot);
        },
      ),
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

  Widget listViewBuild(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        ToDo toDo = snapshot.data[index];
        return eachToDo(toDo);
      },
    );
  }

  Widget eachToDo(ToDo toDo) {
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert(context, 'Apagar',
                          'Deseja apagar essa tarefa?', toDo);
                    },
                  );
                },
                child: Icon(Icons.delete),
              ),
            ],
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

  Widget continueButton(BuildContext context, ToDo toDo) {
    return TextButton(
      child: Text("Continar"),
      onPressed: () {
        _toDoDao.delete(toDo.id).then((value) => setState(() {}));
        Navigator.of(context).pop();
      },
    );
  }

  Widget alert(BuildContext context, String title, String content, ToDo toDo) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton(context),
        continueButton(context, toDo),
      ],
    );
  }
}
