import 'package:flutter/material.dart';
// แสกนนิ้ว
import 'package:local_auth/local_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart'; 

class Numpad extends StatefulWidget {
  // รหัสผ่านกี่หลัก
  final int? length;
  Numpad({Key? key, this.length}) : super(key: key);

  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {

  bool _authSuccess = false;
  final LocalAuthentication _localAuth = LocalAuthentication();
  String number = '';

  /** ฟังก์ชันการสแกนนิ้ว */
  Future<bool> _auth() async {
    setState(() => this._authSuccess = false);
    if (await this._localAuth.canCheckBiometrics == false) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Your device is NOT capable of checking biometrics.\n'
              'This demo will not work on your device!\n'
              'You must have android 6.0+ and have fingerprint sensor.'),
        ),
      );
      return false;
    }
    // **NOTE**: for local auth to work, tha MainActivity needs to extend from
    // FlutterFragmentActivity, cf. https://stackoverflow.com/a/56605771.
    try {
      // authenticateWithBiometrics: ตรวจว่าลายนิ้วมือตรงกับลายนิ้วมือที่เก็บในเครื่องไหม
      final authSuccess = await this._localAuth.authenticateWithBiometrics (
        localizedReason: 'เข้าใช้งานด้วยการแสกนลายนิ้วมือ\nหรือ ยกเลิกเพื่อกลับไปใช้รหัส PIN'
      );

      if(authSuccess){
        _setAuthSuccess();
      }

      return true;

      /*
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('authSuccess=$authSuccess')),
      );
      return authSuccess;
      */

    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return false;
    }
  }

  void _setAuthSuccess() async {
    // สร้างตัวเก็บข้อมูลแบบ SharedPreferences
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setInt('storeStep', 3);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  // ตรวจว่าผู้ใช้กด pin ไปแล้วกี่หลัก ถ้าน้อยว่า ui (6 หลัก) ให้ต่อค่าไปเรื่อย ๆ
  setValue(String val){
    if(number.length < widget.length!) {
      setState(() {
        number += val;
      });
    }
    if (number.length == widget.length!) {
      if(number == '123456') {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
      else {
        _showDialog('แจ้งเตือน', 'รหัสผ่านไม่ถูกต้อง');
        // ไม่ต้อง set state ให้ number เพราะไม่ได้เปลี่ยน ui
        number = '';
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

  backspace(String text){
    if(text.length > 0) {
      setState(() {
        number = text.split('').sublist(0,text.length-1).join('');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column( 
        children: <Widget>[
          Preview(text: number, length: widget.length!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '1',
                onPressed: ()=>setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: ()=>setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: ()=>setValue('3'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '4',
                onPressed: ()=>setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: ()=>setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: ()=>setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '7',
                onPressed: ()=>setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: ()=>setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: ()=>setValue('9'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumpadButton(
                haveBorder: false,
                icon: Icons.fingerprint,
                onPressed: () async {
                  final authSuccess = await this._auth();
                  setState(() => this._authSuccess = authSuccess);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: NumpadButton(
                  text: '0',
                  onPressed: ()=>setValue('0'),
                ),
              ),
              NumpadButton(
                haveBorder: false,
                icon: Icons.backspace,
                onPressed: ()=>backspace(number),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Preview extends StatelessWidget {
  final int? length;
  final String? text;
  const Preview({Key? key, this.length, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> previewLength = [];
    for (var i = 0; i < length!; i++) {
      previewLength.add(Dot(isActive: text!.length >= i+1));
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        children: previewLength
      )
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;
  const Dot({Key? key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 15.0,
        height: 15.0,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
            width: 1.0,
            color: Theme.of(context).primaryColor
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class NumpadButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool haveBorder;
  final void Function()? onPressed;
  const NumpadButton({Key? key, this.text, this.icon, this.haveBorder=true, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = TextStyle(fontSize:30.0, color: Colors.black);
    Widget label = icon != null ? Icon(icon, color: Theme.of(context).primaryColor.withOpacity(0.8), size: 40.0,)
      : Text(this.text ?? '', style: buttonStyle);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: haveBorder ? BorderSide(color: Colors.grey) : BorderSide.none,
          // highlightedBorderColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.3),
          // splashColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
          padding: EdgeInsets.all(12.0),
          shape: CircleBorder(),
        ),
        onPressed: onPressed,
        child: label,
      )
    );
  }
} 

