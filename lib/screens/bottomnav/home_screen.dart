import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // สร้างตัวแปรเก็บชื่อเมนู
  var services = [
    "Sofa Cleaning",
    "Carpet Cleaning",
    "Deep Cleaning",
    "Office Cleaning",
    "Windows Cleaning",
    "Construct Cleaning",
    "Wall Printing",
    "Move In Cleaning"
  ];

  var images = [
    "assets/images/menu_icon/broom.png",
    "assets/images/menu_icon/adornment.png",
    "assets/images/menu_icon/vacuum.png",
    "assets/images/menu_icon/offices.png",
    "assets/images/menu_icon/window.png",
    "assets/images/menu_icon/house.png",
    "assets/images/menu_icon/paint-roller.png",
    "assets/images/menu_icon/cleaner.png",
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // มีกี่รายการ
      itemCount: services.length,
      // บอกขนาดของ Grid ว่ามีกี่คอลัมน์ กี่แถว
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // แนวนอน
        crossAxisCount: 2,
        // ความสูงเทียบกับแนวนอน: กว้าง/สูง (สูงน้อยกว่าความกว้าง 2.4 เท่า)
        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.4)
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          // InkWell: ใส่เพื่อให้กดได้ (ใส่ event) ตอนกดจะมี ripple effect ด้วย
          child: InkWell(
            onTap: (){},
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Image.asset(images[index], height: 50, width: 50),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(services[index], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}