import 'package:flutter/material.dart';
import 'package:hero_service_app/models/news_model.dart';
import 'package:hero_service_app/services/rest_api.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'ข่าวประกาศล่าสุด',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: FutureBuilder(
              // Call API
              future: CallAPI().getLastNews(),
              // AsyncSnapshot อ่าน data จาก API มา
              builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
                if(snapshot.hasError) {
                  return Center(
                    child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                  );
                }
                else if(snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data!;
                  return _listViewLastNews(news);
                }
                // กำลังโหลดอยู่
                else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'ข่าวประกาศทั้งหมด',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: FutureBuilder(
              // Call API
              future: CallAPI().getAllNews(),
              // AsyncSnapshot อ่าน data จาก API มา
              builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
                if(snapshot.hasError) {
                  return Center(
                    child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                  );
                }
                else if(snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data!;
                  return _listViewAllNews(news);
                }
                // กำลังโหลดอยู่
                else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ),
        ],
      )
    );
  }

  // สร้าง ListView สำหรับการแสดงข่าวล่าสุด
  // อ่านจาก API มา ตอนใช้งานต้องเรียกจาก FutureBuilder
  Widget _listViewLastNews(List<NewsModel> news) {
    return ListView.builder(
      // เลื่อนแนวนอน
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      itemBuilder: (context, index) {
        // Load model
        NewsModel newsModel = news[index];
        
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: InkWell(
            onTap: (){
              // ส่งค่า id
              Navigator.pushNamed(
                context, 
                '/newsdetail',
                arguments: {'id': newsModel.id}
              );
            },
            child: Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // รูปข่าว
                    Container(
                      height: 125,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(newsModel.imageurl!),
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topCenter
                        )
                      )
                    ),
                    // ข้อความ
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            newsModel.topic!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            newsModel.detail!,
                            style: TextStyle(fontSize: 16),
                            // ตัดคำยาวเป็น ...
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ]
                ),
              ),
            ),
          ),
        );
        
      },
    );
  }

  // สร้าง ListView สำหรับการแสดงข่าวทั้งหมด
  Widget _listViewAllNews(List<NewsModel> news) {
    return ListView.builder(
      // เลื่อนแนวตั้ง
      scrollDirection: Axis.vertical,
      itemCount: news.length,
      itemBuilder: (context, index) {
        // Load model
        NewsModel newsModel = news[index];
        
        return ListTile(
          leading: Icon(Icons.pages),
          title: Text(
            newsModel.topic!,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: (){
            _launcherInBrowser(Uri.parse(newsModel.linkurl!));
          },
        );
        
      },
    );
  }

  // ฟังก์ชันสำหรับการ Launcher Web Screen
  Future<void> _launcherInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        // <แบบก่อน> false: เปิดแล้ว back กลับมาแอปได้ true: เปิดแล้วกลับมาแอปไม่ได้
        // forceSafariVC: false,
        // forceWebView: false,
        // headers: <String, String>{'header_key': 'header_value'}
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}