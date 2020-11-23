import 'package:flutter/material.dart';
import 'package:share_card/pages/cardListPage.dart';
import 'package:share_card/pages/chat.dart';
import 'package:share_card/pages/create.dart';
import 'package:share_card/pages/more.dart';
import 'package:share_card/pages/qr.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index==0?CardList():index==1?Qr():index==2?Create():index==3?Chat():More(),
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
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline),label: "Create"),
          BottomNavigationBarItem(icon: Icon(Icons.message),label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz),label: "More"),
        ],
      ),
    );
  }
}