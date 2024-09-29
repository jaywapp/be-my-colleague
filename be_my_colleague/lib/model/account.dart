import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

class Account {
  String name = '';
  String mailAddress = '';
  List<Club> clubs = [];

  Account(String name, String mailAddress, List<Club> clubs) {
    this.name = name;
    this.mailAddress = mailAddress;
    this.clubs = clubs;
  }
}
