import 'package:be_my_colleague/model/member.dart';
import 'package:flutter/material.dart';

class Schedule {
  String name = '';
  String description = '';
  String location = '';
  String locationName = '';
  DateTime dateTime = new DateTime(1000, 1, 1, 0, 0, 0, 0, 0);
  List<String> participantMails = [];

  Schedule(String name, String description, String locationName, String location, DateTime dateTime,
      List<String> participantMails) {
    this.name = name;
    this.description = description;
    this.locationName = locationName;
    this.location = location;
    this.dateTime = dateTime;
    this.participantMails = participantMails;
  }
}

