import 'package:be_my_colleague/model/club.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('회원목록')),
      body: ListView.builder(
        itemCount: club.members.length,
        itemBuilder: (context, index) {
          final member = club.members[index];
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(member.name),
            subtitle: Text(
                'Permission: ${member.permission.toString().split('.').last}'),
          );
        },
      ),
    );
  }
}
