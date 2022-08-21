import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(

          ),
          RaisedButton(
            onPressed: () async {
              // ตัวแปรแบบ sharedPreferences ต้องอยู่ภายใต้ async function
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

              // เก็บค่าลงตัวแปรแบบ SharedPreferences
              sharedPreferences.setInt('appStep', 3);

              Navigator.pushReplacementNamed(context, '/lock');
            },
            child: Text('ออกจากระบบ', style: TextStyle(color: Colors.white),),
          )
        ],
      )
    );
  }
}