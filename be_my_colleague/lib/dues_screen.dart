import 'package:be_my_colleague/data/data_center.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

class DuesScreen extends StatefulWidget {
  
  final DataCenter dataCenter;
  final String clubID;

  const DuesScreen(this.dataCenter, this.clubID);

  @override
  State<StatefulWidget> createState() => DuesScreenState();
}

class DuesScreenState extends State<DuesScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('dues');
  }
}
