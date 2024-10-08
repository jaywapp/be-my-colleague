import 'package:be_my_colleague/Styles.dart';
import 'package:be_my_colleague/data/data_center.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/schedule.dart';
import 'package:be_my_colleague/schedule_block.dart';
import 'package:be_my_colleague/schedule_detail.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {

  final DataCenter dataCenter;
  final String clubID;

  const ScheduleScreen(this.dataCenter, this.clubID);

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
    _schedules =  widget.dataCenter.GetSchedules(widget.clubID);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Styles.CreateHeader(Icons.calendar_month, '일정정보'),
      ),

      body: ListView.builder(
        itemCount: _schedules.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ScheduleBlock(
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleDetail(
                          dataCenter: widget.dataCenter,
                          clubID: widget.clubID,
                          scheduleID: _schedules[index].id,
                        ),
                      ),
                    ),
                  },
              schedule: _schedules[index]);
        })
      );
  }
}
