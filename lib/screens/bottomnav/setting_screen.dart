import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  // สร้างตัวแปรไว้เก็บชื่อและรูป
  String? _fullname, _avatar;
  SharedPreferences? sharedPreferences;

  // อ่านข้อมูลผู้ใช้งานจาก sharedPreferences
  getProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _fullname = sharedPreferences!.getString('storeFullname');
      _avatar = sharedPreferences!.getString('storeAvatar');
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_account.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              children: [
                // ขอบวงกลม
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    // รูป account วงกลม
                    child: CircleAvatar(
                      radius: 46.0,
                      // backgroundImage: AssetImage('assets/images/account.jpg'),
                      backgroundImage: NetworkImage('$_avatar'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '$_fullname',
                  style: TextStyle(
                    fontSize: 24, 
                    color: Colors.pink[300], 
                    fontFamily: 'Montserrat[700]',
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 1,
                        color: Colors.white
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ข้อมูลผู้ใช้'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('เปลี่ยนรหัสผ่าน'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('เปลี่ยนภาษา'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('ติดต่อทีมงาน'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('ตั้งค่าการใช้งาน'),
            onTap: (){
              print('...' + _avatar!);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('ออกจากระบบ'),
            onTap: () async {
              // ตัวแปรแบบ sharedPreferences ต้องอยู่ภายใต้ async function
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

              // เก็บค่าลงตัวแปรแบบ SharedPreferences
              sharedPreferences.setInt('appStep', 3);

              Navigator.pushReplacementNamed(context, '/lock');
            },
          )
        ],
      )
    );
  }
}