import 'dart:convert';
import 'dart:ffi';
import 'package:be_my_colleague/dues_screen.dart';
import 'package:be_my_colleague/home_screen.dart';
import 'package:be_my_colleague/members_screen.dart';
import 'package:be_my_colleague/model/Member.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/enums.dart';
import 'package:be_my_colleague/model/schedule.dart';
import 'package:be_my_colleague/more_screen.dart';
import 'package:be_my_colleague/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; // 로컬 assets를 읽기 위해 필요


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const _navItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_filled),
    label: '홈',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.supervised_user_circle_sharp),
    label: '회원정보',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month),
    label: '일정',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.attach_money),
    label: '회비',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.more_horiz),
    label: '더보기',
  ),
];

class _MyHomePageState extends State<MyHomePage> {
  
  int _bottomItemIndex = 0;
  Account _account = new Account('', '', []);
  Club _selectedClub = new Club('', '', '', new DateTime(2011, 08, 16), [], []);

  void changeClub(Club club) {
    setState(() {
      _selectedClub = club;
    });
    Navigator.pop(context); // Drawer 닫기
  }

  @override
  void initState() {
    super.initState();
    _account = Load();
  }

  Widget getScreen(int idx){
    if(idx == 0){
      return HomeScreen(_selectedClub);
    }
    else if(idx == 1){
      return MembersScreen(_selectedClub);
    }
    else if(idx == 2){
      return ScheduleScreen(_selectedClub);      
    }
    else if(idx == 3){
      return DuesScreen(_selectedClub);
    }
    else if(idx == 4){
      return MoreScreen(_selectedClub);
    }
    else{
        throw Exception('Unknown screen');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_selectedClub.name),
        actions: [
          IconButton(icon: Icon(Icons.account_box_rounded), onPressed: null),
        ],
      ),
      body:  getScreen(_bottomItemIndex),
      drawer: Drawer(
        child: 
            ListView.builder(
                itemCount: _account.clubs.length + 1,
                itemBuilder: (BuildContext ctx, int index) {
                  if (index == 0) {
                    return  CreateDrawerHeader(_account);
                  } 
                  else {
                    return ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.grey[850],
                      ),
                      title: Text(_account.clubs[index-1].name),
                      onTap: () {
                        changeClub(_account.clubs[index-1]);
                      },
                    );
                  }
                }),
      
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _bottomItemIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _bottomItemIndex = index;
          });
        },
      ),  
    );
  }

UserAccountsDrawerHeader CreateDrawerHeader(Account account){
  return UserAccountsDrawerHeader(
    accountName: Text(
      account.name,
      style: TextStyle(
        letterSpacing: 1.0,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        ),
      ),
      accountEmail: Text(
        account.mailAddress,
        style: TextStyle(
          letterSpacing: 0.7,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
          ),
      ),
    );
}
  
  Account Load(){
     List<Member> members = [
      new Member(
          '박준영', 'jaywapp16@gmail.com', '01076549816', Permission.president),
      new Member(
          '김총무', 'satgot@gmail.com', '01012345678', Permission.secretary),
      new Member(
        '홍회원', 'gildon@gmail.com', '01056781234', Permission.normal),
    ];

    List<String> participants = ['jaywapp16@gmail.com', 'satgot@gmail.com'];

    List<Schedule> schedules = [
      new Schedule('정규일정', '정규일정 입니다.', '세븐축구클럽', new DateTime(2024, 09, 29),
          participants)
    ];

    List<Club> clubs = [
      new Club('1234', '경충FC', '풋살을 즐겁게 하자', new DateTime(2011, 08, 16),
          members, schedules)
    ];

    return new Account("박준영", "jaywapp16@gmail.com", clubs);
  }
}
