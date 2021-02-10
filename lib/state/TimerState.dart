import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int standing;

  const TimerState(this.standing);

  @override
  List<Object> get props => [standing];
}

class TimerInitial extends TimerState {
  const TimerInitial(int standing) : super(standing);

  @override
  String toString() => 'TimerInitial { starting: $standing}';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int standing) : super(standing);

  @override
  String toString() => 'TimerRunPause { starting: $standing}';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int standing) : super(standing);

  @override
  String toString() => 'TimerRunInProgress { starting: $standing}';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}