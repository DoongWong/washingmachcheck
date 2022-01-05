import 'dart:async';
//import 'package:washingmachcheck/ticker.dart';
//import 'package:washingmachcheck/bloc/timer_bloc.dart';

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

