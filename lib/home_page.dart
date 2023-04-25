import 'package:flutter/material.dart';
import 'package:timmer/timer_model.dart';
import 'widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'count_down.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final CountDown timer = CountDown();

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timmer'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                      child: ProductivityButton(
                          callBack: () => timer.startWork(),
                          color: Color(0xff009688),
                          size: 20,
                          text: 'Work')),
                  Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                      child: ProductivityButton(
                          callBack: () => timer.startBreak(true),
                          color: Color(0xff607D8B),
                          size: 20,
                          text: 'Short Break')),
                  Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                      child: ProductivityButton(
                          callBack: () => timer.startBreak(false),
                          color: Color(0xff455A64),
                          size: 20,
                          text: 'Long Break')),
                  Padding(padding: EdgeInsets.all(5))
                ],
              ),
              StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timerModel = (snapshot.data == '00:00')
                        ? TimerModel('00:00', 1)
                        : snapshot.data;
                    return Expanded(
                        child: CircularPercentIndicator(
                      radius: availableWidth / 4,
                      percent: timerModel.percent,
                      progressColor: Color(0xff009688),
                      lineWidth: 7,
                      center: Text(
                        timerModel.time,
                        style: TextStyle(fontSize: 25),
                      ),
                    ));
                  }),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                      child: ProductivityButton(
                          callBack: () {
                            timer.stopTime();
                          },
                          color: Color(0xff455A64),
                          size: 20,
                          text: 'Stop')),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          callBack: () {
                            timer.startTime();
                          },
                          color: Color(0xff009688),
                          size: 20,
                          text: 'Restart')),
                  Padding(
                    padding: EdgeInsets.all(5),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
