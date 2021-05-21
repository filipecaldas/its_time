import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
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
        body: TicketsList());
  }
}

class TicketsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(25),
          sliver: SliverGrid.count(
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "Família",
                ),
                color: Colors.green,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Trabalho'),
                color: Colors.red,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Casa'),
                color: Colors.blue,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Metas'),
                color: Colors.pink,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Aniversários'),
                color: Colors.yellow,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Supermercado'),
                color: Colors.grey,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Senhas'),
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
