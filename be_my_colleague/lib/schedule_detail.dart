import 'package:be_my_colleague/model/Member.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ScheduleDetail extends StatefulWidget {
  final Account account;
  final Club club;
  final Schedule schedule;  

  const ScheduleDetail({super.key, required this.account, required this.club, required this.schedule});
  
  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail>{
  
  Schedule _schedule = new Schedule('', '', '', new DateTime(1000, 00, 00), []);
  bool _include = false;

  String convert(DateTime now) {
    return "${now.year.toString()}년 ${now.month.toString().padLeft(2, '0')}월 ${now.day.toString().padLeft(2, '0')}일 ${now.hour.toString().padLeft(2, '0')}시${now.minute.toString().padLeft(2, '0')}분";
  }

  void Load() {
    // 서버에서 최신 schedule 정보 로드
    _schedule = widget.schedule;    
    _include = widget.schedule.participantMails.contains(widget.account.mailAddress);
  }
  
  @override
  void initState() {
    super.initState();
    Load();
  }

  @override
  Widget build(BuildContext context) {

     var members = widget.club.members
      .where((member) =>  _schedule.participantMails.contains(member.mailAddress))
      .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text( _schedule.name)),
      body: 
        Padding(
            padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
            child: Column(
              children: [
                CreateHeader(Icons.access_time, '언제'),
                CreateContent(convert(_schedule.dateTime)),
                CreateHeader(Icons.map_outlined, '어디서'),
                CreateHeader(Icons.supervised_user_circle, '누가'),
                CreateParticipants(context, widget.account, members),
              ],
            ),
          ),

      floatingActionButton: FloatingActionButton.extended(
        icon: _include ? const Icon(Icons.cancel) : const Icon(Icons.check),
        label: Text(_include ? '이번 일정은 불참합니다.' : '이번 일정은 참석합니다.'),
        backgroundColor:  _include ? Colors.red : Colors.blue,
        foregroundColor: _include ? Colors.black : Colors.white,
        onPressed: () {

          if(_include){
            // 일정에 포함된 경우 -> 불참으로 변경
            Absent();
          }
          else{
            // 일정에 미포함된 경우 -> 참석으로 변경
            Attend();
          }

          setState(() {
            Load();  
          });
        }
      ),
    );
  }

  void Absent(){
    // TODO : 서버에 데이터 제거 요청
    widget.schedule.participantMails.remove(widget.account.mailAddress);
  }

  void Attend(){
    // TODO : 서버에 데이터 추가 요청
    widget.schedule.participantMails.add(widget.account.mailAddress);
  }

  Padding CreateHeader(IconData iconData, String text) {
    var style = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 10.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: Icon(iconData),
          ),
          Text(text, style: style)
        ],
      ),
    );
  }

  Padding CreateContent(String text) {
    var style = TextStyle(
      fontSize: 24,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 10.0),
      child: Row(
        children: [Text(text, style: style)],
      ),
    );
  }

  Widget CreateParticipants(BuildContext context, Account account,List<Member> members) {


    return  Expanded(
      child: ListView.builder(
        itemCount: members.length,
        itemBuilder: (BuildContext ctx, int index) {

          var member = members[index];
          var color = member.mailAddress == account.mailAddress
            ? Theme.of(context).colorScheme.primary
            : Colors.black;

          var style = TextStyle(
            fontSize: 20,
            color:  color,
          );

          return Card(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(member.name, style: style,)
            )
          );
        }),
    );
  }
}