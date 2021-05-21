import 'package:flutter/material.dart';
import 'package:its_time/models/ToDo.dart';

class ToDoList extends StatelessWidget {
  final List<ToDo> list = [
    ToDo(false, "Tarefa 1"),
    ToDo(true, "Tarefa 2"),
    ToDo(false, "Tarefa 3"),
  ];

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
          debugPrint("Clicou no botão");
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ToDoWidget(list[index].isChecked, list[index].description);
        },
      ),
    );
  }
}

class ToDoWidget extends StatefulWidget {
  bool isChecked;
  final String description;

  ToDoWidget(this.isChecked, this.description);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Row>[
          Row(
            children: <Widget>[
              Checkbox(
                value: widget.isChecked,
                onChanged: (value) {
                  setState(() {
                    widget.isChecked = !widget.isChecked;
                  });
                },
              ),
              Text(widget.description),
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
  }
}
