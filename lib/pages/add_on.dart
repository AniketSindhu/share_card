import 'package:flutter/material.dart';
import 'package:share_card/model/creditsModel.dart';
import 'package:velocity_x/velocity_x.dart';

class AddOn extends StatefulWidget {
  @override
  _AddOnState createState() => _AddOnState();
}

class _AddOnState extends State<AddOn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "Add On".text.semiBold.size(20).white.make(),
        centerTitle: true,
      ),
      body:VStack([
        Card(
          elevation: 10,
          child: HStack([
            VStack([
              "Add On 1".text.bold.size(18).make(),
              "Pro Card Design".text.medium.size(16).make(),
              "Access to card customization".text.medium.size(16).make(),
            ]),
            VStack([
              "\$20".text.bold.size(18).make(),
              FlatButton(
                child:"Buy".text.size(18).white.make(),
                onPressed: (){},
                color: Colors.blue,
              )
            ])
          ],alignment: MainAxisAlignment.spaceBetween,axisSize: MainAxisSize.max,).p16(),
        ),
        10.heightBox,
        Card(
          elevation: 10,
          child: HStack([
            VStack([
              "Add On 1".text.bold.size(18).make(),
              "Pro Card Design".text.medium.size(16).make(),
              "Access to card customization".text.medium.size(16).make(),
              "Access to card with Qr code".text.medium.size(16).make(),
              "Custom fonts".text.medium.size(16).make(),
            ]),
            VStack([
              "\$50".text.bold.size(18).make(),
              FlatButton(
                child:"Buy".text.size(18).white.make(),
                onPressed: (){},
                color: Colors.blue,
              )
            ])
          ],alignment: MainAxisAlignment.spaceBetween,axisSize: MainAxisSize.max,).p16(),
        ),
      ]).p12()
    );
  }
}