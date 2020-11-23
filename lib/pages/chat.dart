import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "CHAT".text.semiBold.size(20).white.make(),
        actions: [
          Icon(Icons.person,color: Vx.blue900,size: 30,).p12(),
          ],
      ),
      body:ListView.builder(
        itemCount: 6,
        itemBuilder:(_,__){
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.person,color: Vx.blue700,size: 30,),
                title: "Mr. Aniket".text.semiBold.size(18).make(),
                subtitle: "Hey how you doin?".text.size(15).make(),
                trailing: "7:15 AM".text.size(17).make(),
                enabled: true,
              ),
              Divider(thickness:0.8,height:0)
            ],
          );
        }
      )
    );
  }
}
