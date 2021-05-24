import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:its_time/database/dao/to_do_dao.dart';
import 'package:its_time/models/ToDo.dart';

class ToDoForm extends StatefulWidget {
  final int idTicket;

  ToDoForm(this.idTicket);
  @override
  _ToDoFormState createState() => _ToDoFormState();
}

class _ToDoFormState extends State<ToDoForm> {
  final ToDoDao _toDoDao = ToDoDao();

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

  String strDateAlart = "";
  String strTimeAlart = "";

  String strDatePrevious = "";
  String strTimePrevious = "";

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  bool isSelectedWeekly(int value) {
    if (value == 2) {
      return false;
    } else {
      return true;
    }
  }

  String transformStrWeekly() {
    String str = '';
    if (isCheckedSunday) {
      str += 'sun,';
    } else {
      str += ',';
    }
    if (isCheckedMonday) {
      str += 'mon,';
    } else {
      str += ',';
    }
    if (isCheckedTuesday) {
      str += 'tue,';
    } else {
      str += ',';
    }
    if (isCheckedWednesday) {
      str += 'wed,';
    } else {
      str += ',';
    }
    if (isCheckedThursday) {
      str += 'thu,';
    } else {
      str += ',';
    }
    if (isCheckedFriday) {
      str += 'fri,';
    } else {
      str += ',';
    }
    if (isCheckedSaturday) {
      str += 'sat,';
    } else {
      str += ',';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("It's Time!"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final String title = _controllerTitle.text;
          final String description = _controllerDescription.text;
          print(title);
          print(description);

          final String strWeekly = transformStrWeekly();

          final ToDo newToDo = ToDo(
              title: title,
              description: description,
              conclusion: false,
              alert: isSwitchedAlert,
              alertDate: strDateAlart,
              alertTime: strTimeAlart,
              previous: isSwitchedPrevious,
              previousDate: strDatePrevious,
              previousTime: strTimePrevious,
              repeat: selectedRadio,
              repeatWeekly: strWeekly,
              alarm: isSwitchedAlarm,
              idTicket: widget.idTicket);
          _toDoDao.create(newToDo).then((id) => {
                Navigator.pop(context),
              });
        },
        child: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controllerTitle,
              decoration: InputDecoration(
                labelText: 'Tarefa',
              ),
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            TextField(
              controller: _controllerDescription,
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
            alertTask(),
          ],
        ),
      ),
    );
  }

  alertTask() {
    return Column(
      children: <Widget>[
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
                buttonsDateTimeAlert(context),
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
                  child: buttonsDateTimePrevious(context),
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
                  child: buttonsRadioListRepeat(context),
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
    );
  }

  Widget buttonsDateTimeAlert(BuildContext context) {
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(),
                maxTime: DateTime(2100, 1, 1), onConfirm: (date) {
              setState(() {
                strDateAlart = date.day.toString() +
                    "/" +
                    date.month.toString() +
                    "/" +
                    date.year.toString();
              });
            }, currentTime: DateTime.now(), locale: LocaleType.pt);
          },
          child: Icon(Icons.date_range),
        ),
        Text(strDateAlart),
        TextButton(
          onPressed: () {
            DatePicker.showTimePicker(context,
                showTitleActions: true,
                showSecondsColumn: false, onConfirm: (time) {
              setState(() {
                strTimeAlart =
                    time.hour.toString() + ":" + time.minute.toString();
              });
            }, locale: LocaleType.pt);
          },
          child: Icon(Icons.access_time),
        ),
        Text(strTimeAlart),
      ],
    );
  }

  Widget buttonsDateTimePrevious(BuildContext context) {
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(),
                maxTime: DateTime(2100, 1, 1), onConfirm: (date) {
              setState(() {
                strDatePrevious = date.day.toString() +
                    "/" +
                    date.month.toString() +
                    "/" +
                    date.year.toString();
              });
            }, currentTime: DateTime.now(), locale: LocaleType.pt);
          },
          child: Icon(Icons.date_range),
        ),
        Text(strDatePrevious),
        TextButton(
          onPressed: () {
            DatePicker.showTimePicker(context,
                showTitleActions: true,
                showSecondsColumn: false, onConfirm: (time) {
              setState(() {
                strTimePrevious =
                    time.hour.toString() + ":" + time.minute.toString();
              });
            }, locale: LocaleType.pt);
          },
          child: Icon(Icons.access_time),
        ),
        Text(strTimePrevious),
      ],
    );
  }

  Widget buttonsRadioListRepeat(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
