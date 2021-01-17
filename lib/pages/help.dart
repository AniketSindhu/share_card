import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'contact.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Help'.text.make(),
      ),
      body: Column(
        children: [
          SvgPicture.asset(
            "assets/help.svg",
            height: (context.percentHeight * 45),
          ).centered(),
          40.heightBox,
          FlatButton(
            color:Colors.blue,
            child:'Contact us'.text.white.make(),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Contact()));
            },
          ).centered(),
          10.heightBox,
          FlatButton(
            color:Colors.blue,
            child:'Privacy Policy'.text.white.make(),
            onPressed: (){
              Get.dialog(Dialog(
                child: VStack([
                  "Privacy Policy".text.extraBlack.extraBold.size(40).makeCentered(),
                  20.heightBox,
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.".text.makeCentered()
                ]).py12().px16().scrollVertical(),
              ));
            },
          ).centered(),
          10.heightBox,
        ],mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}