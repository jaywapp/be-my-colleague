import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  final Club club;
  
  const ScheduleScreen(this.club);

  @override
  State<StatefulWidget> createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen>{
  @override
  Widget build(BuildContext context) {
      var club = widget.club;

     return ListView.builder(
        itemCount: club.shedules.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ListTile(
            title: Text(club.shedules[index].name),
            );
        });
    }
  }

