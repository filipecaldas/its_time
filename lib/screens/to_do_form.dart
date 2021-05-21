import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ToDoForm extends StatefulWidget {
  @override
  _ToDoFormState createState() => _ToDoFormState();
}

class _ToDoFormState extends State<ToDoForm> {
  bool isSwitchedAlert = false;
  bool isSwitchedPrevious = false;
  bool isSwitchedRepeat = false;
  bool isSwitchedAlarm = false;

  int selectedRadio = 0;

  bool isCheckedSunday = false;
  bool isCheckedMonday = false;
  bool isCheckedTuesday = false;
  bool isCheckedWednesday = false;
  bool isCheckedThursday = false;
  bool isCheckedFriday = false;
  bool isCheckedSaturday = false;

  isSelectedWeekly(int value) {
    if (value == 2) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("It's Time!"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2100, 1, 1),
                                onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.pt);
                          },
                          child: Icon(Icons.date_range),
                        ),
                        TextButton(
                          onPressed: () {
                            DatePicker.showTimePicker(context,
                                showTitleActions: true,
                                showSecondsColumn: false, onChanged: (time) {
                              print('change $time');
                            }, onConfirm: (time) {
                              print('confirm $time');
                            }, locale: LocaleType.pt);
                          },
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
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2100, 1, 1),
                                  onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.pt);
                            },
                            child: Icon(Icons.date_range),
                          ),
                          TextButton(
                            onPressed: () {
                              DatePicker.showTimePicker(context,
                                  showTitleActions: true,
                                  showSecondsColumn: false, onChanged: (time) {
                                print('change $time');
                              }, onConfirm: (time) {
                                print('confirm $time');
                              }, locale: LocaleType.pt);
                            },
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
                          RadioListTile(
                            title: Text("diariamente"),
                            value: 1,
                            groupValue: selectedRadio,
                            onChanged: (value) {
                              setState(
                                () {
                                  selectedRadio = value;
                                },
                              );
                            },
                          ),
                          Column(
                            children: <Widget>[
                              RadioListTile(
                                title: Text("semanalmente"),
                                value: 2,
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedRadio = value;
                                    },
                                  );
                                },
                              ),
                              Offstage(
                                offstage: isSelectedWeekly(selectedRadio),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isCheckedSunday,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                isCheckedSunday = value;
                                              },
                                            );
                                          },
                                        ),
                                        Text("Domingo")
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isCheckedMonday,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                isCheckedMonday = value;
                                              },
                                            );
                                          },
                                        ),
                                        Text("Segunda")
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isCheckedTuesday,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                isCheckedTuesday = value;
                                              },
                                            );
                                          },
                                        ),
                                        Text("Terça")
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isCheckedWednesday,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                isCheckedWednesday = value;
                                              },
                                            );
                                          },
                                        ),
                                        Text("Quarta")
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isCheckedThursday,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                isCheckedThursday = value;
                                              },
                                            );
                                          },
                                        ),
                                        Text("Quinta")
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isCheckedFriday,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                isCheckedFriday = value;
                                              },
                                            );
                                          },
                                        ),
                                        Text("Sexta")
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isCheckedSaturday,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                isCheckedSaturday = value;
                                              },
                                            );
                                          },
                                        ),
                                        Text("Sábado")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              RadioListTile(
                                title: Text("mensalmente"),
                                value: 3,
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedRadio = value;
                                    },
                                  );
                                },
                              ),
                              RadioListTile(
                                title: Text("anualmente"),
                                value: 4,
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedRadio = value;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
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
        ),
      ),
    );
  }
}
