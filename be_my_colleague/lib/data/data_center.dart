import 'package:be_my_colleague/model/Member.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/enums.dart';
import 'package:be_my_colleague/model/schedule.dart';
import 'package:flutter/material.dart';

class DataCenter {

  Account account = new Account('', '');
  List<Member> members = [];
  List<String> participants = [];
  List<Schedule> schedules = [];
  List<Club> clubs = [];

  DataCenter(String name, String mailAddress){
    account = new Account(name, mailAddress);
    members = [
      new Member('박준영', 'jaywapp16@gmail.com', '01076549816', Permission.president),
      new Member('김총무', 'satgot@gmail.com', '01012345678', Permission.secretary),
      new Member('홍회원', 'gildon@gmail.com', '01056781234', Permission.normal),
    ];

     participants = ['jaywapp16@gmail.com', 'satgot@gmail.com'];

     schedules = [
      new Schedule('1', '정규일정', '정규일정 입니다.', '경기 광주시 오포로171번길 17-19', new DateTime(2024, 09, 29), participants)
    ];

    clubs = [
      new Club('1234', '경충FC', '풋살을 즐겁게 하자', new DateTime(2011, 08, 16))
    ];
  }

  List<Member> GetMembers(String clubID){
    return members;
  }

  List<Schedule> GetSchedules(String clubID){
    return schedules;
  }

  List<Club> GetClubs(){
    return clubs;
  } 
}
