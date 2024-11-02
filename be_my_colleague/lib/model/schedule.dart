import 'package:be_my_colleague/model/member.dart';
import 'package:flutter/material.dart';

class Schedule {
  String id = '';
  String name = '';
  String description = '';
  String location = '';
  String content = '';
  DateTime dateTime = new DateTime(1000, 1, 1, 0, 0, 0, 0, 0);
  List<String> participantMails = [];

  Schedule(this.id, this.name, this.description, this.location, this.dateTime,
      this.content, this.participantMails);

  Schedule.FromRow(List<Object?> row) {
    this.id = (row.elementAtOrNull(0) as String) ?? '';
    var dateStr = (row.elementAtOrNull(1) as String) ?? '';
    this.name = (row.elementAtOrNull(2) as String) ?? '';
    this.description = (row.elementAtOrNull(3) as String) ?? '';
    this.location = (row.elementAtOrNull(4) as String) ?? '';
    this.content = (row.elementAtOrNull(5) as String) ?? '';
    var membersStr = (row.elementAtOrNull(6) as String) ?? '';

    this.dateTime = DateTime.parse(dateStr ?? '');
    this.participantMails = membersStr.split(',').map((o) => o.trim()).toList();
  }

  List<Object> ToRowWhenRemove(String remove) {
    List<Object> row = [];

    row.add(id);
    row.add('${dateTime.year}-${dateTime.month}-${dateTime.day}');
    row.add(name);
    row.add(description);
    row.add(location);
    row.add(content);

    var result = '';

    var targets = participantMails.where((m) => m != remove).toList();

    for (int i = 0; i < targets.length; i++) {
      result += targets[i];
      if (i != targets.length - 1) {
        result += ', ';
      }
    }

    row.add(result);

    return row;
  }

  List<Object> ToRowWhenAdd(String add) {
    List<Object> row = [];
    row.add(id);
    row.add('${dateTime.year}-${dateTime.month}-${dateTime.day}');
    row.add(name);
    row.add(description);
    row.add(location);
    row.add(content);

    var result = '';

    var targets = participantMails.toList();

    for (int i = 0; i < targets.length; i++) {
      result += targets[i];
      if (i != targets.length - 1) {
        result += ', ';
      }
    }

    result += ', ';
    result += add;

    row.add(result);

    return row;
  }
}
