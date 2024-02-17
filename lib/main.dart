import 'package:flutter/material.dart';
import 'package:stopwatch/login_screen.dart';
import 'package:stopwatch/stopwatch.dart';

void main(){
  runApp(const StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/" : (context) => const LoginScreen(),
        LoginScreen.route : (context) => const LoginScreen(),
        StopWatch.route : (context) => const StopWatch(),
      },
      initialRoute: "/",
    );
  }
}

