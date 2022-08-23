import 'package:flutter/material.dart';
import 'package:hero_service_app/models/news_model.dart';
import 'package:hero_service_app/services/rest_api.dart';

class MarketScreen extends StatefulWidget {
  MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
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
              future: CallAPI().getNews(),
              // AsyncSnapshot อ่าน data จาก API มา
              builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
                if(snapshot.hasError) {
                  return Center(
                    child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                  );
                }
                else if(snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data!;
                  return _listViewNews(news);
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

  // สร้าง ListView สำหรับการแสดงข่าว อ่านจาก API มา ตอนใช้งานต้องเรียกจาก FutureBuilder
  Widget _listViewNews(List<NewsModel> news) {
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
            onTap: (){},
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

}