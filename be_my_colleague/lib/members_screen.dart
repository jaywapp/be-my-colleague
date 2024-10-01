import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersScreen extends StatefulWidget {
  final Club club;
  const MembersScreen(this.club);

  @override
  State<StatefulWidget> createState() => MembersScreenState();
}

class MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    var club = widget.club;

    // 멤버를 permission에 따라 정렬
    club.members
        .sort((a, b) => b.permission.index.compareTo(a.permission.index));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.supervised_user_circle_sharp,
              size: 30, // 아이콘 크기 조정
              color: Colors.black, // 아이콘 색상
            ),
            SizedBox(width: 8), // 아이콘과 텍스트 사이의 간격
            Text(
              '회원정보',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: club.members.length,
        itemBuilder: (context, index) {
          final member = club.members[index];
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(member.name),
            subtitle:
                Text('등급: ${member.permission.toString().split('.').last}'),
            trailing: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () => _makePhoneCall(member.phoneNumber),
            ),
          );
        },
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    var url = Uri.parse('tel:${phoneNumber}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
