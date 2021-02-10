import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/bloc/TimerBloc.dart';
import 'package:timer_app/template/Timer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(standing: 0),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Timer(),
      ),
    );
  }
}
