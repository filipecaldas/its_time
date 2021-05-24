class ToDo {
  int id;
  String title;
  bool conclusion;
  String description;
  bool alert;
  String alertDate;
  String alertTime;
  bool previous;
  String previousDate;
  String previousTime;
  int repeat;
  String repeatWeekly;
  bool alarm;
  int idTicket;
  int intConclusion;
  int intAlert;
  int intPrevious;
  int intAlarm;

  ToDo({
    this.id,
    this.title,
    this.conclusion,
    this.description,
    this.alert,
    this.alertDate,
    this.alertTime,
    this.previous,
    this.previousDate,
    this.previousTime,
    this.repeat,
    this.repeatWeekly,
    this.alarm,
    this.idTicket,
    this.intConclusion,
    this.intAlert,
    this.intPrevious,
    this.intAlarm,
  });

  void convertBooltoInt() {
    this.alert ? this.intAlert = 1 : this.intAlert = 0;
    this.previous ? this.intPrevious = 1 : this.intPrevious = 0;
    this.conclusion ? this.intConclusion = 1 : this.intConclusion = 0;
    this.alarm ? this.intAlarm = 1 : this.intAlarm = 0;
  }

  void convertIntToBool() {
    this.intAlert == 1 ? this.alert = true : this.alert = false;
    this.intConclusion == 1 ? this.conclusion = true : this.conclusion = false;
    this.intPrevious == 1 ? this.previous = true : this.previous = false;
    this.intAlarm == 1 ? this.alarm = true : this.alarm = false;
  }
}
