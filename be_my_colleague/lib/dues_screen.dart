import 'package:be_my_colleague/Styles.dart';
import 'package:be_my_colleague/data/data_center.dart';
import 'package:be_my_colleague/dues_bank_block.dart';
import 'package:be_my_colleague/dues_block.dart';
import 'package:be_my_colleague/model/account.dart';
import 'package:be_my_colleague/model/club.dart';
import 'package:be_my_colleague/model/due.dart';
import 'package:flutter/material.dart';

class DuesScreen extends StatefulWidget {
  final DataCenter dataCenter;
  final String clubID;

  const DuesScreen(this.dataCenter, this.clubID);

  @override
  State<StatefulWidget> createState() => DuesScreenState();
}

class DuesScreenState extends State<DuesScreen> {

  Club _club = new Club('','', '', new DateTime(1000, 1, 1,), 1, '', '');
  List<Due> _dues = [];

  @override
  void initState() {
    super.initState();
    _club = widget.dataCenter.GetClub(widget.clubID);
    _dues = widget.dataCenter.GetDues(widget.clubID, widget.dataCenter.account.mailAddress);
    _dues.sort((a, b) => a.date.compareTo(b.date));
    _dues = List.from(_dues.reversed);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Styles.CreateHeader(Icons.monetization_on_sharp , '회비납부내역'),
      ),
      body: Column(

        children: [
          DuesBankBlock(name: _club.bankName, account: _club.bankAccount,),
          Expanded(
              child: ListView.builder(
                itemCount: _dues.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return 
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DueBlock(due: _dues[index]));
            },
          ))
        ],
      ),
    );
  }
}
