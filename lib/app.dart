import 'package:flutter/material.dart';
import 'package:washingmachcheck/timer.dart';
import 'package:washingmachcheck/timer_page.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washing Machine Vacancy Check',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        colorScheme: ColorScheme.light(
          secondary: Color.fromRGBO(72, 74, 126, 1),  
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("洗衣機所剩時間"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              TimerPage(duration: 1124 , machineName: "洗衣機1號"),
              TimerPage(duration: 0, machineName: "洗衣機2號"),
              TimerPage(duration: 1000 , machineName: "洗衣機3號"),
            ],
          ),
        ),
      ),
    );
  }
}
