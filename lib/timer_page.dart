import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washingmachcheck/ticker.dart';
import 'package:washingmachcheck/timer.dart';

class TimerPage extends StatelessWidget {
  final int _duration;
  final  String _machineName;
  final Color colorContainer;
  const TimerPage({required int duration,required String machineName , Key? key}) : 
    _duration = duration,
    _machineName = machineName,
    colorContainer = (duration == 0 ? Colors.green: Colors.red),
    super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker(), duration: _duration, pagecolor: colorContainer),
      child: TimerView(machineName: _machineName,duration : _duration),
    ),
      color: colorContainer,
    ) 
    ;
  }
}
//class for displaying the time.

class TimerView extends StatelessWidget {
  final String _machineName;
  final int _duration;
  const TimerView({required String machineName,required int duration, Key? key}) : 
  _machineName = machineName,
  _duration = duration,
  super( key: key);
  @override
    Widget build(BuildContext context) 
    {
      context.read<TimerBloc>().add(TimerStarted(duration: _duration));
      return Stack(
        children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_machineName),
              const TimerText(),
            ]
          
          ),
        // Actions(),
        ]
      );
    } 
}

//this class is the format for time.
class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Container( 
    child:Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline1,
      
    ),
    //color: minutesStr ==  0 ? Colors.green :Colors.red,
    );
  }
}


class Actions extends StatelessWidget { 
  
  const Actions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              ElevatedButton(
                child: Text("Check Now"),
                onPressed: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration)),
              ),
            ]
          ]
        );
      }
      
    );
  }
}