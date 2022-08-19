// ใส่ alias: http
import 'dart:convert';

import 'package:http/http.dart' as http;

class CallAPI {

  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };

  final String baseAPIURL = 'https://www.itgenius.co.th/sandbox_api/flutteradvapi/public/api/';

  // Login API
  // asynchronous: ไม่ขึ้นกับเวลา ไม่ต้องรอการทำงานกันให้เสร็จทีละอย่าง ระหว่างรอก็ไปทำอย่างอื่น
  loginAPI(data) async {
    var fullURL = Uri.parse(baseAPIURL + "login");
    
    //await: รอจนกว่าคำสั่งนี้จะเสร็จ ค่อยทำคำสั่งถัดไป ไม่งั้นบางที api ยังโหลดไม่เสร็จ แต่ไปทำงานฟังก์ชันต่อไปที่ต้องใช้ข้อมูล api ก็ตู้ม
    return await http.post(
      fullURL,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }
}