import 'package:flutter/material.dart';
import 'package:share_card/pages/cardListPage.dart';
import 'package:share_card/pages/chat.dart';
import 'package:share_card/pages/create.dart';
import 'package:share_card/pages/more.dart';
import 'package:share_card/pages/qr.dart';
import 'package:velocity_x/velocity_x.dart';
import 'notfications.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index==0?CardList():index==1?Qr():index==2?Chat():index==3?Notifications():More(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        showSelectedLabels: true,
        selectedFontSize: 20,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Vx.blue800,
        iconSize: 25,
        selectedItemColor: Vx.blue400,
        unselectedItemColor: Vx.gray300,
        onTap: (val){
          setState(() {
            index=val;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code),label: "Card"),
          BottomNavigationBarItem(icon: Icon(Icons.message),label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded).badge(size:18,count:4,color: Colors.red,textStyle: TextStyle(fontSize: 15,color: Colors.white)),label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz),label: "More"),
        ],
      ),
    );
  }
}