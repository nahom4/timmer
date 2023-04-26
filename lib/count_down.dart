import 'dart:async';
import 'timer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDown {
  // periodically update the time decrease the value of the start clock
  static const String WORK = 'workTime';
  static const String LONG = 'longBreak';
  static const String SHORT = 'shortBreak';
  double _radius = 1;
  late Duration _time;
  late Duration _totalTime;
  bool isActive = true;
  int shortBreak = 10;
  int longBreak = 15;
  int work = 30;
  getSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    work = (pref.getInt(WORK) == null) ? 30 : pref.getInt(WORK)!;
    shortBreak = (pref.getInt(SHORT) == null) ? 5 : pref.getInt(SHORT)!;
    longBreak = (pref.getInt(LONG) == null) ? 15 : pref.getInt(LONG)!;
  }

  startWork() async {
    await getSetting();
    _time = Duration(minutes: work, seconds: 0);
    _totalTime = _time;
  }

  startBreak(isShort) async {
    await getSetting();
    _time = Duration(seconds: 0, minutes: (isShort) ? shortBreak : longBreak);
    _totalTime = _time;
  }

  startTime() {
    if (_time.inSeconds > 0) {
      isActive = true;
    }
  }

  stopTime() {
    isActive = false;
  }

  // let's use the timmer to periodically generate update the clock
  Stream<TimerModel> stream() async* {
    String changedTime = '';
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      if (isActive) {
        // update the _time
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _totalTime.inSeconds;
        if (_time == 0) {
          isActive = false;
        }
      }

      changedTime = formatString(_time);
      return TimerModel(changedTime, _radius);
    });
  }
}

// let's create a function that formats the time

String formatString(Duration time) {
  // extract the minute
  String minutes = (time.inMinutes < 10)
      ? '0' + time.inMinutes.toString()
      : time.inMinutes.toString();
  int timeSeconds = time.inSeconds - time.inMinutes * 60;
  String seconds = (timeSeconds < 10)
      ? '0' + (timeSeconds).toString()
      : (timeSeconds).toString();

  return minutes + ':' + seconds;
}
