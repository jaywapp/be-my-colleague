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

  Schedule(this.id, this.name, this.description, this.location, this.dateTime, this.content, this.participantMails);
}

