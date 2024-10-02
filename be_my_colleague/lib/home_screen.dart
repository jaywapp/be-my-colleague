import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final Account account;
  final String clubID;

  const HomeScreen(this.account, this.clubID);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {    
    return Text('home');
  }
}
