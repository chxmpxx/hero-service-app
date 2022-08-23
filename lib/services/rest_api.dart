// ใส่ alias: http
import 'dart:convert';

import 'package:hero_service_app/models/login_model.dart';
import 'package:hero_service_app/models/news_detail_model.dart';
import 'package:hero_service_app/models/news_model.dart';
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

  // Read User Profile
  // ต้องทำผ่าน Future เพื่อให้อ่านข้อมูลเป็น background process แล้วส่งกลับเมื่อทำเสร็จ
  Future<LoginModel> getProfile(data) async {
    var fullURL = Uri.parse(baseAPIURL + "login");

    final response = await http.post(
      fullURL,
      body: jsonEncode(data),
      headers: _setHeaders()
    );

    if(response.statusCode == 200) {
      return loginModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  // Read Last News (5 News)
  Future<List<NewsModel>> getLastNews() async {
    var fullURL = Uri.parse(baseAPIURL + "lastnews");

    final response = await http.get(
      fullURL,
      headers: _setHeaders()
    );

    if(response.body != null) {
      return newsModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  // Read All News
  Future<List<NewsModel>> getAllNews() async {
    var fullURL = Uri.parse(baseAPIURL + "news");

    final response = await http.get(
      fullURL,
      headers: _setHeaders()
    );

    if(response.body != null) {
      return newsModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  // Read News Detail By ID
  Future<NewsDetailModel> getNewsDetail(id) async {
    var fullURL = Uri.parse(baseAPIURL + "news/" + id);

    final response = await http.get(
      fullURL,
      headers: _setHeaders()
    );

    if(response.body != null) {
      return newsDetailModelFromJson(response.body);
    }
    throw Exception('Fail');
  }
}