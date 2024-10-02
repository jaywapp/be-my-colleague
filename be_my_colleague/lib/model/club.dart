import 'package:be_my_colleague/model/Member.dart';
import 'package:be_my_colleague/model/schedule.dart';

class Club {
  String id = '';
  String name = '';
  String description = '';  
  DateTime created = new DateTime(1000, 1, 1, 0, 0, 0, 0, 0);

  List<Member> members = [];
  List<Schedule> shedules = [];

  Club(String id, String name, String description, DateTime created, List<Member> members, List<Schedule> shedules){
    this.id = id;
    this.name = name;
    this.description = description;
    this.created = created;
    this.members = members;
    this.shedules = shedules;
  }
}
