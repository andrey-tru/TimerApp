import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/bloc/TimerBloc.dart';
import 'package:timer_app/event/TimerEvent.dart';

class TimerSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimerSetting();
  }
}

class _TimerSetting extends State<TimerSetting> {
  double pickerItemHeight = 50.0;
  var hrValue = 0, minValue = 0, secValue = 0;
  int hrLength = 24;
  int secLength = 60;
  var hr, min, sec, time;

  @override
  void initState() {
    super.initState();
    hr = List(hrLength);
    min = List(secLength);
    sec = List(secLength);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      height: 250,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Hour',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
              Text(
                'Min',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
              Text(
                'Sec',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 120,
            child: Row(
              children: [
                durationPicker(hr, hrLength, 0),
                durationPicker(min, secLength, 1),
                durationPicker(sec, secLength, 2),
              ],
            ),
          ),
          RaisedButton(
            child: Text(
              'Ok',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              time = (hrValue * 3600) + (minValue * 60) + secValue;
              BlocProvider.of<TimerBloc>(context).add(TimerRequested(standing: time));
              Navigator.pop(context);
            },
            color: Colors.white38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Flexible durationPicker(array, a, arg) {
    for (var i = 0; i < a; i++) {
      array[i] = i;
    }
    return Flexible(
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(),
        itemExtent: pickerItemHeight,
        onSelectedItemChanged: (int index) {
          setState(() {
            if (arg == 0) {
              hrValue = array[index];
            } else if (arg == 1) {
              minValue = array[index];
            } else {
              secValue = array[index];
            }
          });
        },
        children: List<Widget>.generate(
          a,
          (int index) {
            return Center(
              child: Text('${array[index].toString().padLeft(2, '0')}'),
            );
          },
        ),
      ),
    );
  }
}
