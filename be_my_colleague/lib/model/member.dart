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
