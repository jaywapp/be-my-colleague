import 'package:be_my_colleague/model/enums.dart';
import 'package:flutter/material.dart';

class Member {
  String name = '';
  String mailAddress = '';
  String phoneNumber = '';
  Permission permission = Permission.normal;

  Member(String name, String mailAddress, String phoneNumber, Permission permission) {
    this.name = name;
    this.mailAddress = mailAddress;
    this.phoneNumber = phoneNumber;
    this.permission = permission;
  }
}
