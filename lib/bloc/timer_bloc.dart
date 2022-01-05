import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:washingmachcheck/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';


//the data that was taken from the firebase should come here, into the TimerBloc class.

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final Color _pagecolor;
  // int _duration;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker, required int duration, Color pagecolor = Colors.red})
      : _ticker = ticker, _pagecolor = pagecolor, 
        super(TimerInitial(duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : TimerRunComplete(pagecolor: _pagecolor)
    );
  }
}

