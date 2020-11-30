import 'package:flutter/material.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:velocity_x/velocity_x.dart';

class Premium extends StatefulWidget {
  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Premium".text.make(),
        centerTitle: true,
      ),
      body: VStack([
        "Benifits:".text.size(32).bold.make(),
        10.heightBox,
        "- Access to 8 more pro card designs".text.size(20).medium.make(),
        5.heightBox,
        "- Access to different fonts".text.size(20).medium.make(),
        5.heightBox,
        "- Accesss more app themes".text.size(20).medium.make(),
        20.heightBox,
        RaisedButton(
          onPressed: ()async{
            bool result = await getPremium();
            if(result){
              context.showToast(
                  msg: 'You are premium member now',
                  showTime: 4500,
                  bgColor: Vx.green500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10);
            }
            else {
              context.showToast(
                  msg: 'You are already premium member',
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10);
            }
          },
          child: "Get Premium".text.white.size(20).make(),
          color: Colors.red, 
        ).centered(),
        5.heightBox,
      ]).p16(),
    );
  }
}