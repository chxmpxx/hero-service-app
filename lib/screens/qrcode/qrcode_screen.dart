import 'package:flutter/material.dart';
import 'package:hero_service_app/screens/qrcode/my_qrcode.dart';
import 'package:hero_service_app/screens/qrcode/scanner_screen.dart';

class QRCodeScreen extends StatefulWidget {
  QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> with SingleTickerProviderStateMixin {

  TabController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // vsync: this หมายถึงคลาสนี้ (ใส่ with SingleTickerProviderStateMixin ที่คลาสนี้ด้วย)
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('คิวอาร์โค้ด'),
        backgroundColor: Colors.purple[300],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: 'ตัวสแกน',),
            Tab(text: 'โค้ดของฉัน',)
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          ScannerScreen(),
          MyQRCodeScreen()
        ],
      ),
    );
  }
}