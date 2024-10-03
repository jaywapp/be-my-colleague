import 'package:be_my_colleague/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
          children: [
            Flexible(
                flex: 9,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "너 내 동료가 돼라",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Align(
                        child: Text("© Copyright 2024, BlueHeart",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                            )),
                      )
                    ],
                  ),
                )),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () 
                {
                  var name = '박준영';
                  var mailAddress = 'jaywapp16@gmail.com';
                  
                   Route(name, mailAddress); 
                },
                child: Text('Login with Google'),
              ),
            ),
          ],
        ));
  }

  void Route(String name, String mailAddress) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: MyHomePage(
                    title: '너 내 동료가 돼라',
                    name: name,
                    mailAddress: mailAddress))));
  }
}
