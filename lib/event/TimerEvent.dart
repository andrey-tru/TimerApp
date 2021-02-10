import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerRequested extends TimerEvent {
  final int standing;

  const TimerRequested({@required this.standing});

  @override
  List<Object> get props => [standing];
}

class TimerStarted extends TimerEvent {
  final int standing;

  const TimerStarted({@required this.standing});

  @override
  String toString() => "TimerStarted { standing: $standing }";
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final int standing;

  const TimerTicked({@required this.standing});

  @override
  String toString() => "TimerTicked { standing: $standing }";
}

