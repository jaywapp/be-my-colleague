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
  List<Club> clubs = [];

  DataCenter(GoogleSignInAccount? googleUser) {
    googleAccount = googleUser;

    var name = googleUser?.displayName ?? '';
    var mailAddress = googleUser?.email ?? '';

    account = new Account(name, mailAddress);

    clubs = [
      new Club('1Op1lymJ1oDr8IazasJpq3UDUtUTfysVzGsa-sJlQIPI', '경충FC',
          '풋살을 즐겁게 하자', new DateTime(2011, 08, 16), 1, '신한', '110-152-149740')
    ];
  }

  Future<List<Member>> GetMembers(String clubID) async {
    if (googleAccount == null) return List.empty();

    List<Member> result = [];

    final headers =
        await googleAccount?.authHeaders ?? new Map<String, String>();
    final authenticatedClient = GoogleHttpClient(headers);

    final sheetsApi = sheets.SheetsApi(authenticatedClient);
    var spreadsheetId = clubID;
    var sheetName = '회원';

    try {
      var sheets = sheetsApi.spreadsheets;

      final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);
      final sheet = spreadsheet.sheets!
          .firstWhere((sheet) => sheet.properties!.title == sheetName);
      final int rowCount = sheet.properties!.gridProperties!.rowCount!;

      final range = '$sheetName!A2:F$rowCount';

      var response = await sheets.values.get(spreadsheetId, range);
      var values = response.values;

      if (values != null) {
        for (var row in values) {
          var name = (row.elementAtOrNull(0) as String) ?? '';
          var mail = (row.elementAtOrNull(1) as String) ?? '';
          var number = (row.elementAtOrNull(2) as String) ?? '';
          var birth = (row.elementAtOrNull(3) as String) ?? '';
          var join = (row.elementAtOrNull(4) as String) ?? '';
          var per = (row.elementAtOrNull(5) as String) ?? '';

          var birthDate = DateTime.parse(birth ?? '');
          var joinDate = DateTime.parse(join ?? '');
          var permission = Parse(per);

          var member =
              new Member(name, mail, number, birthDate, joinDate, permission);

          result.add(member);
        }
      }
    } catch (e) {}

    return result;
  }

  Future<Schedule> GetSchedule(String clubID, String scheduleID) async
  {
      var schedules =  await GetSchedules(clubID);
      var schedule = schedules.firstWhere((o) => o.id == scheduleID);

      return schedule;
  }

  Future<List<Schedule>> GetSchedules(String clubID) async {
    if (googleAccount == null) return List.empty();

    List<Schedule> result = [];

    final headers =
        await googleAccount?.authHeaders ?? new Map<String, String>();
    final authenticatedClient = GoogleHttpClient(headers);

    final sheetsApi = sheets.SheetsApi(authenticatedClient);
    var spreadsheetId = clubID;
    var sheetName = '일정';

    try {
      var sheets = sheetsApi.spreadsheets;

      final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);
      final sheet = spreadsheet.sheets!
          .firstWhere((sheet) => sheet.properties!.title == sheetName);
      final int rowCount = sheet.properties!.gridProperties!.rowCount!;

      final range = '$sheetName!A2:G$rowCount';

      var response = await sheets.values.get(spreadsheetId, range);
      var values = response.values;

      if (values != null) {
        for (var row in values) {
          var id = (row.elementAtOrNull(0) as String) ?? '';
          var dateStr = (row.elementAtOrNull(1) as String) ?? '';
          var name = (row.elementAtOrNull(2) as String) ?? '';
          var desc = (row.elementAtOrNull(3) as String) ?? '';
          var location = (row.elementAtOrNull(4) as String) ?? '';
          var content = (row.elementAtOrNull(5) as String) ?? '';
          var membersStr = (row.elementAtOrNull(6) as String) ?? '';

          var date = DateTime.parse(dateStr ?? '');
          var members = membersStr.split(',').map((o) => o.trim()).toList();

          var schedule = new Schedule(id, name, desc, location, date, content, members);

          result.add(schedule);
        }
      }
    } catch (e) {}

    return result;
  }

  List<Club> GetClubs() {
    return clubs;
  }

  Club GetClub(String clubID) {
    return clubs.firstWhere((c) => c.id == clubID);
  }

  Future<List<Due>> GetDues(String clubID, String mailAddress) async {
    if (googleAccount == null) return List.empty();

    List<Due> result = [];

    final headers =
        await googleAccount?.authHeaders ?? new Map<String, String>();
    final authenticatedClient = GoogleHttpClient(headers);

    final sheetsApi = sheets.SheetsApi(authenticatedClient);
    var spreadsheetId = clubID;
    var sheetName = '회비';

    try {
      var sheets = sheetsApi.spreadsheets;

      final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);
      final sheet = spreadsheet.sheets!
          .firstWhere((sheet) => sheet.properties!.title == sheetName);
      final int rowCount = sheet.properties!.gridProperties!.rowCount!;
      final int columnCount = sheet.properties!.gridProperties!.columnCount!;

      final range = '$sheetName!A1:${columnLetter(columnCount)}$rowCount';

      var response = await sheets.values.get(spreadsheetId, range);
      var values = response.values;

      if (values != null) {
        List<Object?> headers = values.elementAtOrNull(0) ?? List.empty();

        for (var row in values) {
          var name = (row.elementAtOrNull(0) as String) ?? '';

          if (name == account.name) {
            for (int j = 1; j < columnCount; j++) {
              var dateStr = (headers[j] as String) ?? '';
              var value = (row[j] as String) ?? '';
              var date = DateTime.parse(dateStr ?? '');
              var due = new Due(date, value == '납부');

              result.add(due);
            }
          }
        }
      }
    } catch (e) {}

    return result;
  }

  Future<DateTime> GetJoinTime(String clubId) async {
    var time = await GetMembers(clubId);
    return time.firstWhere((m) => m.mailAddress == account.mailAddress).created;
  }

  Future<void> Absent(
      String clubID, Schedule? schedule, String mailAddress) async {
    final headers =
        await googleAccount?.authHeaders ?? new Map<String, String>();
    final authenticatedClient = GoogleHttpClient(headers);

    final sheetsApi = sheets.SheetsApi(authenticatedClient);
    var spreadsheetId = clubID;
    var sheetName = '일정';

    try {
      var idx = await GetIndex(clubID, schedule?.id ?? null);
      if (idx == -1) 
        return;

      final range = '$sheetName!A${idx}:G${idx}';

      var row = schedule?.ToRowWhenRemove(mailAddress) ?? List.empty();
      List<List<Object>> values = [];
      values.add(row);

      var valueRange = sheets.ValueRange(
        range: range,
        values: values,
      );
      await sheetsApi.spreadsheets.values
          .update(valueRange, spreadsheetId, range, valueInputOption: 'RAW');
    } catch (e) {}
  }

  Future<void> Attend(
      String clubID, Schedule? schedule, String mailAddress) async {
    final headers =
        await googleAccount?.authHeaders ?? new Map<String, String>();
    final authenticatedClient = GoogleHttpClient(headers);

    final sheetsApi = sheets.SheetsApi(authenticatedClient);
    var spreadsheetId = clubID;
    var sheetName = '일정';

    try {
    var idx = await GetIndex(clubID, schedule?.id ?? null);
      if (idx == -1) 
        return;

      final range = '$sheetName!A${idx}:G${idx}';

      var row = schedule?.ToRowWhenAdd(mailAddress) ?? List.empty();
      List<List<Object>> values = [];
      values.add(row);

      var valueRange = sheets.ValueRange(
        range: range,
        values: values,
      );
      await sheetsApi.spreadsheets.values
          .update(valueRange, spreadsheetId, range, valueInputOption: 'RAW');
    } catch (e) {}
  }

  Future<int> GetIndex(String clubID, String? scheduleID) async{
    if (scheduleID == null || googleAccount == null) 
      return -1;

    final headers = await googleAccount?.authHeaders ?? new Map<String, String>();
    final authenticatedClient = GoogleHttpClient(headers);

    final sheetsApi = sheets.SheetsApi(authenticatedClient);
    var spreadsheetId = clubID;
    var sheetName = '일정';

    try {
      var sheets = sheetsApi.spreadsheets;

      final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);
      final sheet = spreadsheet.sheets!
          .firstWhere((sheet) => sheet.properties!.title == sheetName);
      final int rowCount = sheet.properties!.gridProperties!.rowCount!;

      final range = '$sheetName!A2:G$rowCount';

      var response = await sheets.values.get(spreadsheetId, range);
      var values = response.values;

      if (values != null) {
        int idx = 2;

        for (var row in values) {
          var id = (row.elementAtOrNull(0) as String) ?? '';

          if(id == scheduleID)
            return idx;

          idx++;
        }
      }
    } catch (e) {}

    return -1;
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

  String columnLetter(int columnNumber) {
    String columnLetter = '';
    while (columnNumber > 0) {
      final int remainder = (columnNumber - 1) % 26;
      columnLetter = String.fromCharCode(65 + remainder) + columnLetter;
      columnNumber = (columnNumber - remainder - 1) ~/ 26;
    }
    return columnLetter;
  }
}
