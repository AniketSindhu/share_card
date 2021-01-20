import 'package:flutter/material.dart';
import 'package:share_card/model/creditsModel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

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
          title: tr("add_on").toString().text.semiBold.size(20).white.make(),
          centerTitle: true,
        ),
        body: VStack([
          Card(
            elevation: 10,
            child: HStack(
              [
                VStack([
                  tr("add_on1").toString().text.bold.size(18).make(),
                  tr("pro_card_design").toString().text.medium.size(16).make(),
                  tr("customization").toString().text.medium.size(16).make(),
                ]),
                VStack([
                  "\$20".text.bold.size(18).make(),
                  FlatButton(
                    child: tr("buy").toString().text.size(18).white.make(),
                    onPressed: () {},
                    color: Colors.blue,
                  )
                ])
              ],
              alignment: MainAxisAlignment.spaceBetween,
              axisSize: MainAxisSize.max,
            ).p16(),
          ),
          10.heightBox,
          Card(
            elevation: 10,
            child: HStack(
              [
                VStack([
                  tr("add_on1").toString().text.bold.size(18).make(),
                  tr("pro_card_design").toString().text.medium.size(16).make(),
                  tr("customization").toString().text.medium.size(16).make(),
                  tr("card_with_qr").toString().text.medium.size(16).make(),
                  tr("custom_fonts").toString().text.medium.size(16).make(),
                ]),
                VStack([
                  "\$50".text.bold.size(18).make(),
                  FlatButton(
                    child: tr("buy").toString().text.size(18).white.make(),
                    onPressed: () {},
                    color: Colors.blue,
                  )
                ])
              ],
              alignment: MainAxisAlignment.spaceBetween,
              axisSize: MainAxisSize.max,
            ).p16(),
          ),
        ]).p12());
  }
}
