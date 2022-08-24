import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  // สร้าง Object สำหรับเรียกตัวสแกน QR
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  // แฟรช
  bool _flashOn = false;
  // สลับกล้อง
  bool _frontCam = false;


  @override
  Widget build(BuildContext context) {
    // ใช้ Stack เพราะจะวางของทับกล้อง
    return Stack(
      children: [
        QRView(
          key: _qrKey,
          // ใส่กรอบสแกน
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderLength: 15.0,
            borderWidth: 5.0,
            borderRadius: 2.0
          ),
          // กด Alt ค้างเพื่อหมุนกล้อง
          onQRViewCreated: (QRViewController controller) {
            this._controller = controller;

            // รับค่ามาใช้งาน
            controller.scannedDataStream.listen((event) {
              print(event);
              if(mounted){
                Fluttertoast.showToast(
                    msg: event.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                // เคลียร์ค่า
                _controller!.dispose();
                // ปิดหน้า scan
                // Navigator.pop(context);
              }
            });
          }
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 60),
            child: Text(
              'วางคิวอาร์โค้ดให้อยู่ในกรอบเพื่อสแกน',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 80),
            child: OutlinedButton(
              onPressed: (){},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                shape: StadiumBorder(),
              ),
              child: Text(
              'นำเข้าจากแกลเลอรี่',
              style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off), 
                  onPressed: (){
                   setState(() {
                    // สลับเปิด-ปิด
                     _flashOn = !_flashOn;
                     _controller!.toggleFlash();
                   });
                  }
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(_frontCam ? Icons.camera_front : Icons.camera_rear), 
                  onPressed: (){
                   setState(() {
                     _frontCam = !_frontCam;
                     _controller!.flipCamera();
                   });
                  }
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close), 
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}