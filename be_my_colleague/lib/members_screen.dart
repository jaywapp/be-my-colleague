import 'package:be_my_colleague/Styles.dart';
import 'package:be_my_colleague/data/data_center.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/member.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/androidmanagement/v1.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersScreen extends StatefulWidget {
  
  final DataCenter dataCenter;
  final String clubID;

  const MembersScreen(this.dataCenter, this.clubID);

  @override
  State<StatefulWidget> createState() => MembersScreenState();
}

class MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {

    var club = widget.dataCenter.GetClubs().firstWhere((o) => o.id == widget.clubID);

    return Scaffold(
      appBar: AppBar(
        title: Styles.CreateHeader(Icons.supervised_user_circle_sharp, '회원정보'),
      ),
      body: FutureBuilder(
        future: widget.dataCenter.GetMembers(club.id), 
        builder: (context, snapshot) {

          var members = snapshot?.data ?? List.empty();
          members.sort((a, b) => b.permission.index.compareTo(a.permission.index));

          return CreateListView(members);
        }),
    );
  }

  Widget CreateListView(List<Member> members) {
    return ListView.builder(
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
