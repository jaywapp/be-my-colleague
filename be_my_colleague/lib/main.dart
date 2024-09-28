import 'package:be_my_colleague/intro_screen.dart';
import 'package:be_my_colleague/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '너 내 동료가 돼라',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Color.fromARGB(255, 7, 110, 245),
            ),
          useMaterial3: true,
        ),
        home: FutureBuilder(
          future: Future.delayed(
              const Duration(seconds: 10), () => "Intro Completed."),
          builder: (context, snapshot) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: _splashLoadingWidget(snapshot));
          },
        ));
  }

  Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return const Text("Error!!");
    } else if (snapshot.hasData) {
      return const MyHomePage(title: '너 내 동료가 돼라');
    } else {
      return const IntroScreen();
    }
  }
}
