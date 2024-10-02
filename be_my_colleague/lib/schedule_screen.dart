import 'package:be_my_colleague/data/data_center.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/schedule.dart';
import 'package:be_my_colleague/schedule_block.dart';
import 'package:be_my_colleague/schedule_detail.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {

  // 불변
  final Account account;
  final Club club;

  const ScheduleScreen(this.account, this.club);

  @override
  State<StatefulWidget> createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  
  // 가변
  List<Schedule> _schedules = [];
  
  String convert(DateTime now) {
    return "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    _schedules =  DataCenter.GetSchedules(widget.club);
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: _schedules.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ScheduleBlock(
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleDetail(
                          account: widget.account,
                          club: widget.club,
                          schedule: _schedules[index],
                        ),
                      ),
                    ),
                  },
              schedule: _schedules[index]);
        });
  }
}
