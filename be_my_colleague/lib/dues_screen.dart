import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

class DuesScreen extends StatefulWidget {
  final Club club;

  const DuesScreen(this.club);

  @override
  State<StatefulWidget> createState() => DuesScreenState();
}

class DuesScreenState extends State<DuesScreen> {
  @override
  Widget build(BuildContext context) {
    var club = widget.club;
    return Text('dues');
  }
}
