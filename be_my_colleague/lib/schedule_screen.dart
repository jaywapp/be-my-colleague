import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/schedule_block.dart';
import 'package:be_my_colleague/schedule_detail.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  final Account account;
  final Club club;

  const ScheduleScreen(this.account, this.club);

  @override
  State<StatefulWidget> createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  String convert(DateTime now) {
    return "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    var account = widget.account;
    var club = widget.club;

    return ListView.builder(
        itemCount: club.shedules.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ScheduleBlock(
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleDetail(
                          account: account,
                          club: club,
                          schedule: club.shedules[index],
                        ),
                      ),
                    ),
                  },
              schedule: club.shedules[index]);
        });
  }
}
