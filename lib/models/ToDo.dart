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

  ToDo(
      {this.id,
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
      this.idTicket});
}
