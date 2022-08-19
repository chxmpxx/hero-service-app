import 'package:flutter/material.dart';
import 'package:hero_service_app/screens/lockscreen/numpad.dart';

class LockScreen extends StatefulWidget {
  LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {

  int length = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/menu_icon/offices.png', width: 80, height: 80),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'กรุณาป้อนรหัสผ่าน',
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            Numpad(length: length)
          ],
        ),
      ),
    );
  }
}