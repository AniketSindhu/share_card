import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
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
  UserModel user;
  getUser1() async{
    user = await getUser();
    setState(() {
    });
  }

  void initState(){
    super.initState();
    getUser1();
  }
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
          BottomNavigationBarItem(icon: user!=null?StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').doc(user.mobile).collection('notifications').where('isRead',isEqualTo: false).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Icon(Icons.notifications_rounded);
              }
              else if(!snapshot.hasData){
                return Icon(Icons.notifications_rounded);
              }
              else{
                if(snapshot.data.documents.length==0){
                  return Icon(Icons.notifications_rounded);
                }
                else{
                  return Icon(Icons.notifications_rounded).badge(size:18,count:snapshot.data.documents.length,color: Colors.red,textStyle: TextStyle(fontSize: 15,color: Colors.white));
                }
              }
            }
          ):Icon(Icons.notifications_rounded),
          label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz),label: "More"),
        ],
      ),
    );
  }
}