import 'package:be_my_colleague/Styles.dart';
import 'package:be_my_colleague/data/data_center.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersScreen extends StatefulWidget {
  final Account account;
  final Club club;

  const MembersScreen(this.account, this.club);

  @override
  State<StatefulWidget> createState() => MembersScreenState();
}

class MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    var club = widget.club;

    // 멤버를 permission에 따라 정렬
    var members = DataCenter.GetMembers(club);
    
    members.sort((a, b) => b.permission.index.compareTo(a.permission.index));

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
            Text('회원정보', style: Styles.HeaderStyle,),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(member.name, style: Styles.ContentStyle),
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
