import 'dart:async';

import 'package:flutter/material.dart';
class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int seconds = 0;
  Timer? timer;
  bool isTicking = true;
  void _startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    setState(() {
      isTicking = true;
    });
  }
  void stopTimer(){
    timer!.cancel();
    setState(() {
      isTicking = false;
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // TODO: implement initState
  //   seconds = 0;
  //   timer = Timer.periodic(Duration(seconds: 1), _onTick);
  // }
  void _onTick(Timer time){
    setState(() {
      ++seconds;
    });
  }

  String time() => (seconds == 1? "Second":"Seconds");
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
        title: const Text("Stopwatch"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$seconds ${time()}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: _startTimer,
                    child: const Text("Start"),
                  ),
                  const SizedBox(width: 25,),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: isTicking == true ? stopTimer : null,
                    child: const Text("Stop"),
                  )
                ],
              )
            ],
          ),
    );
  }
}
