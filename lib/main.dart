import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/pages/quizpage.dart';
import 'package:test_project/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      // this stops the device from changing to landscape
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen()
    );
  }
}
