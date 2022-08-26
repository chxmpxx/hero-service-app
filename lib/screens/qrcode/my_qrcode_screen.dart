import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQRCodeScreen extends StatefulWidget {
  MyQRCodeScreen({Key? key}) : super(key: key);

  @override
  State<MyQRCodeScreen> createState() => _MyQRCodeScreenState();
}

class _MyQRCodeScreenState extends State<MyQRCodeScreen> {

  @override
  Widget build(BuildContext context) {

    // กำหนดตัวแปรไว้เก็บ data ของ qrcode
    final message = 'https://github.com/chxmpxx';

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Color.fromARGB(255, 240, 98, 146),
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: Color.fromARGB(255, 244, 143, 177),
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    return Material(
      color: Colors.white,
      child: SafeArea(
        // true: ใช้พื้นที่ทั้งหมด
        top: true,
        bottom: true,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: 250,
                    child: qrFutureBuilder
                    // แบบไม่เอารูป
                    // QrImage(data: "$message",version: QrVersions.auto),
                  ),
                )
              ),
              Padding(
                // เว้นจากด้านล่าง 20 เริ่มนับจากล่างสุดขึ้นมา 40 รวมเว้นล่าง 60
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40).copyWith(bottom: 40),
                child: Text('$message')
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    // โหลดภาพ
    final byteData = await rootBundle.load('assets/images/icon.png');
    // อ่านภาพเป็น byte แล้วเอาไปวาดทับบน QR
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }

}