import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:timer_app/event/TimerEvent.dart';
import 'package:timer_app/state/TimerState.dart';
import 'package:timer_app/template/Ticker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker = Ticker();
  int standing;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({this.standing}) : super(TimerInitial(standing));

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is TimerRequested) {
      yield* _mapTimerRequestedToState(event);
    } else if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerReset) {
      yield* _mapTimerResetToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerRequestedToState(TimerRequested requested) async* {
    _tickerSubscription?.cancel();
    standing = requested.standing;
    yield TimerInitial(standing);
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    yield TimerRunInProgress(standing);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: standing)
        .listen((standing) => add(TimerTicked(standing: standing)));
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused pause) async* {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      yield TimerRunPause(state.standing);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.standing);
    }
  }

  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    yield TimerInitial(standing);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    yield tick.standing > 0
        ? TimerRunInProgress(tick.standing)
        : TimerRunComplete();
  }
}
