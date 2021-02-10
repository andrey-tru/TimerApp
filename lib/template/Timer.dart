import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/bloc/TimerBloc.dart';
import 'package:timer_app/state/TimerState.dart';
import 'TimerSetting.dart';
import 'Act.dart';

class Timer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Timer();
  }
}

class _Timer extends State<Timer> {
  TimerSetting timerSetting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          'Timer',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Container(
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  final String hourStr = ((state.standing / 3600) % 3600)
                      .floor()
                      .toString()
                      .padLeft(2, '0');
                  final String minutsStr = ((state.standing / 60) % 60)
                      .floor()
                      .toString()
                      .padLeft(2, '0');
                  final String secondsStr =
                      (state.standing % 60).floor().toString().padLeft(2, '0');

                  return TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: TimerSetting(),
                          );
                        },
                      );
                    },
                    child: Text(
                      '$hourStr:$minutsStr:$secondsStr',
                      style: TextStyle(fontSize: 80, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: BlocBuilder<TimerBloc, TimerState>(
                buildWhen: (previousState, state) =>
                    state.runtimeType != previousState.runtimeType,
                builder: (context, state) => Act(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
