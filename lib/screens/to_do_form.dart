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
          onCreateToDo();
        },
        child: const Icon(Icons.check),
      ),
      body: form(),
    );
  }

  Widget form() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          inputToDoForm('Tarefa', _controllerTitle),
          largeInputToDoForm('Notas', _controllerDescription),
          alertButton(),
        ],
      ),
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
        radioButtonRepeat('diariamente', 1),
        radioButtonRepeatWeekly(),
        radioButtonRepeat('mensalmente', 3),
        radioButtonRepeat('anualmente', 4),
      ],
    );
  }

  void onCreateToDo() {
    final String title = _controllerTitle.text;
    final String description = _controllerDescription.text;

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
  }

  Widget inputToDoForm(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      style: TextStyle(
        fontSize: 18.0,
      ),
    );
  }

  Widget largeInputToDoForm(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      style: TextStyle(
        fontSize: 18.0,
      ),
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: null,
    );
  }

  Widget alarmButton() {
    return Row(
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
    );
  }

  Widget radioButtonRepeatWeekly() {
    return Column(
      children: [
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
              checkboxSunday(),
              checkboxMonday(),
              checkboxTuesday(),
              checkboxWednesday(),
              checkboxThursday(),
              checkboxFriday(),
              checkboxSaturday(),
            ],
          ),
        ),
      ],
    );
  }

  Widget radioButtonRepeat(String label, int radioValue) {
    return RadioListTile(
      title: Text(label),
      value: radioValue,
      groupValue: selectedRadio,
      onChanged: (value) {
        setState(
          () {
            selectedRadio = value;
          },
        );
      },
    );
  }

  Widget previousButton() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget repeatButton() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget alertButton() {
    return Column(
      children: [
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
          child: Column(
            children: <Widget>[
              buttonsDateTimeAlert(context),
              previousButton(),
              repeatButton(),
              alarmButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget checkboxSunday() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: isCheckedSunday,
          onChanged: (newValue) {
            setState(
              () {
                isCheckedSunday = newValue;
              },
            );
          },
        ),
        Text('Domingo')
      ],
    );
  }

  Widget checkboxMonday() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: isCheckedMonday,
          onChanged: (newValue) {
            setState(
              () {
                isCheckedMonday = newValue;
              },
            );
          },
        ),
        Text("Segunda")
      ],
    );
  }

  Widget checkboxTuesday() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: isCheckedTuesday,
          onChanged: (newValue) {
            setState(
              () {
                isCheckedTuesday = newValue;
              },
            );
          },
        ),
        Text("Terça")
      ],
    );
  }

  Widget checkboxWednesday() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: isCheckedWednesday,
          onChanged: (newValue) {
            setState(
              () {
                isCheckedWednesday = newValue;
              },
            );
          },
        ),
        Text("Quarta")
      ],
    );
  }

  Widget checkboxThursday() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: isCheckedThursday,
          onChanged: (newValue) {
            setState(
              () {
                isCheckedThursday = newValue;
              },
            );
          },
        ),
        Text("Quinta")
      ],
    );
  }

  Widget checkboxFriday() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: isCheckedFriday,
          onChanged: (newValue) {
            setState(
              () {
                isCheckedFriday = newValue;
              },
            );
          },
        ),
        Text("Sexta")
      ],
    );
  }

  Widget checkboxSaturday() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: isCheckedSaturday,
          onChanged: (newValue) {
            setState(
              () {
                isCheckedSaturday = newValue;
              },
            );
          },
        ),
        Text("Sábado")
      ],
    );
  }
}
