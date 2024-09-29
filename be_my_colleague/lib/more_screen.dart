import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  final Club club;

  const MoreScreen(this.club);

  @override
  State<StatefulWidget> createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    var club = widget.club;
    return Text('more');
  }
}
