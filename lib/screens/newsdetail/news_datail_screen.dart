import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero_service_app/models/news_detail_model.dart';
import 'package:hero_service_app/services/rest_api.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  String? newsId;
  String? createdAt;

  // Load Model NewsDetailModel
  NewsDetailModel? _detailNews;

  // การอ่าน API News Detail
  readNewsDdetail() async {
    // check: เครื่องผู้ใช้ Offline/Online
    var result = await Connectivity().checkConnectivity();
    // Offline
    if(result == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "คุณไม่ได้เชื่อมต่ออินเตอร์เน็ต",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
    // Online
    else {
      try {
        var response = await CallAPI().getNewsDetail(newsId);
        // Map API and Model
        setState(() {
          _detailNews = response;
          createdAt = DateFormat("dd-MM-yyyy").format(DateTime.parse(response.data!.createdAt.toString()));
        });
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readNewsDdetail();
  }

  @override
  Widget build(BuildContext context) {

    // รับค่า id จาก arguments
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    newsId = arguments['id'].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('${_detailNews?.data?.topic ?? "..." }'),
        backgroundColor: Colors.purple[300],
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_detailNews?.data?.imageurl ?? "..."),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('${_detailNews?.data?.detail ?? "..." }'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('Created: ${createdAt ?? "..." }'),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16, bottom: 20),
          //   child: Text('Status: ${_detailNews?.data?.status ?? "..." }'),
          // ),
        ],
      ),
    );
  }
}