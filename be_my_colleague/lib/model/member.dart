import 'package:be_my_colleague/model/enums.dart';
import 'package:flutter/material.dart';

class Member {
  String name = '';
  String mailAddress = '';
  String phoneNumber = '';
  DateTime birth = new DateTime(1000, 1, 1);
  DateTime created = new DateTime(1000, 1, 1);
  Permission permission = Permission.normal;

  Member(this.name, this.mailAddress, this.phoneNumber, this.birth, this.created, this.permission);

  static Permission convert(String permission) {
    switch (permission) {
      case 'president':
        return Permission.president;
      case 'vicePresident':
        return Permission.vicePresident;
      case 'secretary':
        return Permission.secretary;
      case 'normal':
        return Permission.normal;
      default:
        throw Exception('Unknown permission: $permission');
    }
  }
}
