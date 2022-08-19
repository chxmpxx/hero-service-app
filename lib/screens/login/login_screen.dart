import 'package:flutter/material.dart';
import 'package:hero_service_app/components/password_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // กำหนดตัวแปรสำหรับเก็บ email และ password
  String? _email, _password;

  // สร้าง Key สำหรับเก็บสถานะของฟอร์ม
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.purple[300],
      ),
      // GestureDetector: ทำให้แบบฟอร์มเลื่อนขึ้นลงได้ กัน keyboard ทับ และกดที่ว่างแล้วให้แป้นหาย
      body: GestureDetector(
        onTap: () {
          // ยกเลิก focus ช่อง input
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: formKey,
            // ListView: ใช้ใส่ช่องเยอะ ๆ
            child: ListView(
              children: <Widget>[
                TextFormField(
                  // autofocus = true: ใส่เพื่อให้พอเปิดหน้านี้มามีเคอร์เซอร์รอเลย
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20, color: Colors.teal),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'กรอกอีเมล'
                  ),
                  // จำกัดความยาว Input
                  // maxLength: 5,
                  // initialValue: 'chxmpxx@gmail.com',
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'กรุณากรอกอีเมล';
                    }
                  },
                  onFieldSubmitted: (String value) {
                    setState(() {
                      this._email = value;
                    });
                  },
                  onSaved: (value) {
                    // ตัดช่องว่างด้านหน้า-หลังออก
                    this._email = value!.trim();
                  },
                ),
                PasswordField(
                  labelText: 'กรอกรหัสผ่าน',
                  helperText: 'ไม่เกิน 6 หลัก',
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'กรุณากรอกรหัสผ่าน';
                    }
                    else if(value.length != 6) {
                      return 'กรุณากรอกรหัสผ่านให้ครบ 6 หลัก';
                    }
                  },
                  onFieldSubmitted: (String value) {
                    setState(() {
                      this._password = value;
                    });
                  },
                  onSaved: (value) {
                    this._password = value!.trim();
                  },
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: (){
                    // เช็คว่าฟอร์มอยู่สถานะอะไร: validate ยัง
                    if(formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      print(_email! + _password!);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                  color: Colors.pink[300]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}