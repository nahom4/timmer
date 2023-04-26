import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:timmer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController worktxt = TextEditingController();
  TextEditingController shortxt = TextEditingController();
  TextEditingController longtxt = TextEditingController();
  static const String WORK = 'workTime';
  static const String LONG = 'longBreak';
  static const String SHORT = 'shortBreak';

  int? workTime = 0;
  int? shortBreak = 0;
  int? longBreak = 0;

  SharedPreferences? pref;

  @override
  void initState() {
    TextEditingController worktxt = TextEditingController();
    TextEditingController shortxt = TextEditingController();
    TextEditingController longtxt = TextEditingController();
    read();
    super.initState();
  }

  TextStyle textStyle = TextStyle(fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
          child: GridView.count(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        children: [
          Text(
            'work',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: WORK,
            callBack: write,
          ),
          TextField(
            controller: worktxt,
            textAlign: TextAlign.center,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: WORK,
            callBack: write,
          ),
          Text(
            'Short break',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: SHORT,
            callBack: write,
          ),
          TextField(
            controller: shortxt,
            textAlign: TextAlign.center,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: SHORT,
            callBack: write,
          ),
          Text(
            'long break',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: LONG,
            callBack: write,
          ),
          TextField(
            controller: longtxt,
            textAlign: TextAlign.center,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: LONG,
            callBack: write,
          )
        ],
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      )),
    );
  }

  read() async {
    pref = await SharedPreferences.getInstance();

    workTime = pref!.getInt(WORK);
    if (workTime == null) {
      workTime = 30;
      await pref!.setInt(WORK, workTime!);
    }
    shortBreak = pref!.getInt(SHORT);
    if (shortBreak == null) {
      shortBreak = 5;
      await pref!.setInt(SHORT, shortBreak!);
    }
    longBreak = pref!.getInt(LONG);
    if (longBreak == null) {
      longBreak = 15;
      await pref!.setInt(LONG, longBreak!);
    }

    // once we have found the values form local local storage let's set them to the text field
    worktxt.text = workTime.toString();
    shortxt.text = shortBreak.toString();
    longtxt.text = longBreak.toString();
  }

  void write(String key, int value) async {
    int workTime = 0;
    int shortBreak = 0;
    int longBreak = 0;
    switch (key) {
      case WORK:
        {
          workTime = pref!.getInt(WORK)!;
          workTime += value;
          if ((1 <= workTime) & (workTime <= 180)) {
            setState(() {
              worktxt.text = workTime.toString();
            });
            
            await pref!.setInt(WORK, workTime);
          }
        }
        break;
      case LONG:
        {
          longBreak = pref!.getInt(LONG)!;
          longBreak += value;
          if ((1 <= longBreak) & (longBreak <= 180)) {
            setState(() {
              longtxt.text = longBreak.toString();
            });
          
            await pref!.setInt(LONG, longBreak);
          }
        }
        break;

      case SHORT:
        {
          shortBreak = pref!.getInt(SHORT)!;
          shortBreak += value;

          if ((1 <= shortBreak) & (shortBreak <= 180)) {
            setState(() {
               shortxt.text = shortBreak.toString();
            });
           
            await pref!.setInt(SHORT, shortBreak);
          }
        }

        break;
    }
  }
}
