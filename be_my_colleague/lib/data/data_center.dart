import 'package:be_my_colleague/Service/GoogleHttpClient.dart';
import 'package:be_my_colleague/model/due.dart';
import 'package:be_my_colleague/model/member.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/enums.dart';
import 'package:be_my_colleague/model/schedule.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:google_sign_in/google_sign_in.dart';



class DataCenter {

  GoogleSignInAccount? googleAccount;

  Account account = new Account('', '');
  List<Member> members = [];
  List<String> participants = [];
  List<Schedule> schedules = [];
  List<Club> clubs = [];

  DataCenter(GoogleSignInAccount? googleUser){

    googleAccount= googleUser;

    var name = googleUser?.displayName ?? '';
    var mailAddress = googleUser?.email ?? '';

    account = new Account(name, mailAddress);
    members = [
      new Member('박준영', 'jaywapp16@gmail.com', '01076549816', new DateTime(1991, 8, 16), new DateTime(2010, 1, 1), Permission.president),
      new Member('김총무', 'satgot@gmail.com', '01012345678',new DateTime(1993, 1, 12), new DateTime(2013, 1, 1), Permission.secretary),
      new Member('홍회원', 'gildon@gmail.com', '01056781234',new DateTime(1997, 2, 26), new DateTime(2014, 1, 1), Permission.normal),
    ];

     participants = ['jaywapp16@gmail.com', 'satgot@gmail.com'];

     schedules = [
      new Schedule('1', '정규일정', '정규일정 입니다.', '경기 광주시 오포로171번길 17-19', new DateTime(2024, 09, 29), '정규 풋살 일정입니다.', participants)
    ];

    clubs = [
      new Club('1Op1lymJ1oDr8IazasJpq3UDUtUTfysVzGsa-sJlQIPI', '경충FC', '풋살을 즐겁게 하자', new DateTime(2011, 08, 16), 1, '신한', '110-152-149740')
    ];
  }



  Future<List<Member>> GetMembers(String clubID) async{
    if(googleAccount == null)
      return List.empty();

    List<Member> result  = [];

    final headers = await googleAccount?.authHeaders ?? new Map<String, String>();
    final authenticatedClient = GoogleHttpClient(headers);

    final sheetsApi = sheets.SheetsApi(authenticatedClient);
    var spreadsheetId = clubID;
    var range = '회원!A2:F30';

    try {

      var sheets = sheetsApi.spreadsheets;
      var response = await sheets.values.get(spreadsheetId, range);
      var values = response.values;

      if (values != null) {
        for (var row in values) {

          var name = (row.elementAtOrNull(0) as String) ?? '';
          var mail = (row.elementAtOrNull(1) as String) ?? '';
          var number = (row.elementAtOrNull(2) as String) ?? '';
          var birth = (row.elementAtOrNull(3) as String) ?? '';
          var join = (row.elementAtOrNull(4)  as String)?? '';
          var per = (row.elementAtOrNull(5) as String) ?? '';

          var birthDate = DateTime.parse(birth ?? '');
          var joinDate = DateTime.parse(join ?? '');
          var permission = Parse(per);

          var member = new Member(name, mail, number, birthDate, joinDate, permission);

          result.add(member);
        }
      }
    } catch (e) {}

    return result;
  }

  List<Schedule> GetSchedules(String clubID){
    return schedules;
  }

  List<Club> GetClubs(){
    return clubs;
  } 

  Club GetClub(String clubID){
    return clubs.firstWhere((c) => c.id == clubID);
  }

  List<Due> GetDues(String clubID, String mailAddress){
    List<Due> dues= [
      new Due(new DateTime(2024, 7, 1), true),
      new Due(new DateTime(2024, 8, 1), false),
      new Due(new DateTime(2024, 9, 1), true),
    ];

    return dues;
  }

  Future<DateTime> GetJoinTime(String clubId) async{
    
    var time = await GetMembers(clubId);
    return time.firstWhere((m) => m.mailAddress == account.mailAddress).created;

  }

  void Absent(String scheduleID, String mailAddress){
    var schedule = schedules.firstWhere((s) =>  s.id == scheduleID);
    schedule.participantMails.remove(mailAddress);
  }

  
  void Attend(String scheduleID, String mailAddress){
    var schedule = schedules.firstWhere((s) =>  s.id == scheduleID);
    schedule.participantMails.add(mailAddress);
  }

  static Permission Parse(String permission) {
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