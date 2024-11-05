import 'package:be_my_colleague/model/member.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    this.id = ConvertToString(row.elementAtOrNull(0));
    var dateStr = ConvertToString(row.elementAtOrNull(1));
    this.name = ConvertToString(row.elementAtOrNull(2));
    this.description = ConvertToString(row.elementAtOrNull(3));
    this.location = ConvertToString(row.elementAtOrNull(4));
    this.content = ConvertToString(row.elementAtOrNull(5));
    var membersStr = ConvertToString(row.elementAtOrNull(6));

    this.dateTime = DateTime.parse(dateStr ?? '');

    if(membersStr.length > 0)
      this.participantMails = membersStr.split(',').map((o) => o.trim()).toList();
  }

  String ConvertToString(Object? obj) {
    if (obj == null) return '';

    try {
      return obj as String;
    } catch (e) {
      return '';
    }
  }

  List<Object> ToRow() {
    List<Object> row = [];
    row.add(id);
    row.add(DateFormat('yyyy-MM-dd').format(dateTime));
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

    row.add(result);

    return row;
  }

  List<Object> ToRowWhenRemove(String remove) {
    List<Object> row = [];

    row.add(id);
    row.add(DateFormat('yyyy-MM-dd').format(dateTime));
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
