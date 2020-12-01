import 'package:flutter/material.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

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
            Get.dialog(Dialog(
              child: Column(children: [
                "Upgrade to premium".text.size(22).bold.makeCentered(),
                20.heightBox,
                "You need to pay 10\$ for the upgrade".text.italic.size(18).make().centered(),
                20.heightBox,
                FlatButton(
                  child:"Buy Premium".text.white.medium.size(18).make(),
                  color: Colors.red,
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
                      Navigator.pop(context);
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
                )
              ],mainAxisAlignment: MainAxisAlignment.center,).p12().h32(context),));            
          },
          child: "Get Premium".text.white.size(20).make(),
          color: Colors.red, 
        ).centered(),
        5.heightBox,
      ]).p16(),
    );
  }
}