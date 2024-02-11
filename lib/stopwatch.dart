import 'dart:async';

import 'package:flutter/material.dart';
class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late int seconds;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seconds = 0;
    timer = Timer.periodic(Duration(seconds: 1), onTick);
  }
  void onTick(Timer timer){
    setState(() {
      ++seconds;
    });
  }
  String _secondText() => (seconds == 1 ? "second" : "seconds");
  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stop Watch"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          height: 50,
          width: 450,
          decoration:  BoxDecoration(

            gradient: const LinearGradient(
              colors: [
                Colors.grey,
                Colors.white54,
                Colors.grey
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "$seconds ${_secondText()}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
