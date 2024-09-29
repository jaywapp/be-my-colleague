import 'package:be_my_colleague/model/Member.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/enums.dart';
import 'package:be_my_colleague/model/schedule.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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
  Widget build(BuildContext context) {
    // Sample datas ----------------------------------
    List<Member> members = [
      new Member(
          '박준영', 'jaywapp16@gmail.com', '01076549816', Permission.president),
      new Member(
          '김총무', 'satgot@gmail.com', '01012345678', Permission.secretary),
      new Member('홍회원', 'gildon@gmail.com', '01056781234', Permission.normal),
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

    _account = new Account("박준영", "jaywapp16@gmail.com", clubs);

    // Sample datas --------------------------------

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_selectedClub.name),
        actions: [
          IconButton(icon: Icon(Icons.account_box_rounded), onPressed: null),
        ],
      ),
      drawer: Drawer(
        child: 
            ListView.builder(
                itemCount: _account.clubs.length + 1,
                itemBuilder: (BuildContext ctx, int index) {
                  if (index == 0) {
                    return   UserAccountsDrawerHeader(
                      accountName: Text(
                        _account.name,
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Text(
                        _account.mailAddress,
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
        items: const <BottomNavigationBarItem>[
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
        ],
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
}
