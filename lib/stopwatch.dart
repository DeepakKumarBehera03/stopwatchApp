import 'dart:async';

import 'package:flutter/material.dart';
class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {

  int milliseconds = 0;
  bool isTick = true;
  Timer? timer;
  final laps = <int>[];
  void _lap(){
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
    scrollController.animateTo(
      itemHeight * laps.length,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeIn,
    );
  }
  final itemHeight = 60.0;
  final scrollController = ScrollController();
  void _clearLaps(){
    setState(() {
      laps.clear();
    });
  }
  void startTimer(){
    timer = Timer.periodic(const Duration(milliseconds: 100), (_onTick));
    setState(() {
      isTick = true;
    });
  }
  void stopTimer(){
    setState(() {
      timer!.cancel();
      isTick = false;
    });
  }
  void _onTick(Timer timer){
    setState(() {
      milliseconds+=100;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }
  String timeSecond() => (milliseconds == 1 ? "Second" : "Seconds");
  String secondSecond(int milliseconds){
    final seconds = milliseconds / 1000;
    return "$seconds seconds";
  }
  Widget _buildLapDisplay(){
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index){
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            title: Text("Lap ${index + 1}"),
            trailing: Text(secondSecond(milliseconds),),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stop Watch"),
      ),
      body:Column(
        children: [
          Expanded(child: _buildCounter(context)),
          ElevatedButton(
            onPressed: _clearLaps,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              foregroundColor: MaterialStateProperty.all(Colors.greenAccent),
            ),
            child: const Text(
              "Clear Laps",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(child: _buildLapDisplay()),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lap ${laps.length+1}",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            secondSecond(milliseconds),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            "$milliseconds milliseconds",
            style: const TextStyle(color: Colors.cyanAccent,fontSize: 20),),
          const SizedBox(height: 30,),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startTimer,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                foregroundColor: MaterialStateProperty.all(Colors.blueGrey),
              ),
              child: const Text("Start",style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(width: 20,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow),
              ),
              onPressed: _lap,
              child: const Text(
                "Lap",
                style: TextStyle(color: Colors.blueGrey,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 20,),
            TextButton(
              onPressed: (stopTimer),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                foregroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text("Stop",style: TextStyle(color: Colors.white),),
            ),
          ],
        );
  }
}

