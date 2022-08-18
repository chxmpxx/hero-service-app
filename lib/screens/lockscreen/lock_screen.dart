import 'package:flutter/material.dart';
import 'package:hero_service_app/screens/lockscreen/numpad.dart';

class LockScreen extends StatefulWidget {
  LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {

  int length = 6;

  onChange(String number) {
    if(number.length == length) {
      if(number == '123456') {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
      else {
        _showDialog('แจ้งเตือน', 'รหัสผ่านไม่ถูกต้อง');
      }
    }
  }

  void _showDialog(title, msg) {
    // showDialog: ตัว pop-up
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog: หน้าตา UI ข้างในที่ใส่ของต่าง ๆ ได้
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('ปิด')
            )
          ],
        );
      }
    );
  }

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
            Numpad(length: length, onChange: onChange)
          ],
        ),
      ),
    );
  }
}