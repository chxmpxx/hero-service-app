import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:hero_service_app/screens/bottomnav/booking_screen.dart';
import 'package:hero_service_app/screens/bottomnav/home_screen.dart';
import 'package:hero_service_app/screens/bottomnav/news_screen.dart';
import 'package:hero_service_app/screens/bottomnav/notification_screen.dart';
import 'package:hero_service_app/screens/bottomnav/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้างตัวแปรแบบ List ไว้เก็บรายการของ bottom nav
  int _currentIndex = 2;
  String _title = 'บริการ';
  Widget? _actionWidget;

  final List<Widget> _children = [
    NewsScreen(),
    BookingScreen(),
    HomeScreen(),
    NotificationScreen(),
    SettingScreen()
  ];

  // สร้าง Widget action สำหรับแยกแสดงผล Appbar
  Widget _homeActionBar() {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/qrcode');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          children: [
            Icon(Icons.center_focus_strong),
            Text(' SCAN')
          ],
        ),
      ),
    );
  }

  Widget _newsActionBar() {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          children: [
            Icon(Icons.add),
            Text('Add news')
          ],
        ),
      ),
    );
  }

  // สร้างฟังก์ชันไว้เปลี่ยนหน้า
  void onTabTapped(int index) {
    // setState เพื่อเปลี่ยน ui (rebuild with new currentIndex)
    setState(() {
      _currentIndex = index;

      // เปลี่ยน title ตาม teb ที่เลือก
      switch (index) {
        case 0: _title = 'ข่าว';
        _actionWidget = _newsActionBar();
          break;
        case 1: _title = 'รายการจอง';
        _actionWidget = Container();
          break;
        case 2: _title = 'หน้าหลัก';
        _actionWidget = _homeActionBar();
          break;
        case 3: _title = 'แจ้งเตือน';
        _actionWidget = Container();
          break;
        case 4: _title = 'อื่น ๆ';
        _actionWidget = Container();
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _actionWidget = _homeActionBar();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.pink[400],
        actions: [
          _actionWidget!
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   // ถ้ามีพารามิเตอร์เดียวไม่ต้องใส่ก็ได้
      //   onTap: onTabTapped,
      //   // อ่านตำแหน่งปัจจุบันที่กด
      //   currentIndex: _currentIndex,
      //   backgroundColor: Colors.pink[400],
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey[300],
      //   type: BottomNavigationBarType.fixed,
        // items: [
        //   BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'ตลาด'),
        //   BottomNavigationBarItem(icon: Icon(Icons.library_add_sharp), label: 'รายการจอง'),
        //   BottomNavigationBarItem(icon: Icon(Icons.business_center), label: 'บริการ'),
        //   BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'แจ้งเตือน'),
        //   BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'อื่น ๆ'),
        // ],
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        onTap: onTabTapped,
        // สีพื้นหลัง
        backgroundColor: Colors.white,
        // สีเมนู
        color: Colors.pink,
        buttonBackgroundColor: Colors.pink,
        height: 60,
        animationDuration: Duration(
          // 0.2 วิ
          milliseconds: 200
        ),
        animationCurve: Curves.bounceInOut,
        items: [
          Icon(Icons.newspaper, size: 30, color: Colors.white,),
          Icon(Icons.library_add_sharp, size: 30, color: Colors.white,),
          Icon(Icons.business_center, size: 30, color: Colors.white,),
          Icon(Icons.notifications, size: 30, color: Colors.white,),
          Icon(Icons.menu, size: 30, color: Colors.white,)
        ],
      ),
      body: _children[_currentIndex]
    );
  }
}