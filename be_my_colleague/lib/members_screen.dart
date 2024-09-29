import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

class MembersScreen extends StatefulWidget {
  final Club club;

  const MembersScreen(this.club);

  @override
  State<StatefulWidget> createState() => MembersScreenState();
}

class MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    var club = widget.club;
    return Text('members');
  }
}
