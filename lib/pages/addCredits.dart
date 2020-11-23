import 'package:flutter/material.dart';
import 'package:share_card/model/creditsModel.dart';
import 'package:velocity_x/velocity_x.dart';

class AddCredits extends StatefulWidget {
  @override
  _AddCreditsState createState() => _AddCreditsState();
}

class _AddCreditsState extends State<AddCredits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "Add Credits".text.semiBold.size(20).white.make(),
        centerTitle: true,
      ),
      body:ListView.builder(
        itemCount:addCreditsList.length,
        itemBuilder:(context,index){
          return Card(
            elevation: 8,
            child:HStack([
              VStack([
                "\$ ${addCreditsList[index].credits} Credits".text.size(20).semiBold.make(),
                5.heightBox,
                "${addCreditsList[index].cards} Cards".text.size(16).semiBold.make(),
              ]),
              VStack([
                "${addCreditsList[index].price} \$".text.size(20).semiBold.make(),
                5.heightBox,
                RaisedButton(
                  onPressed:(){},
                  child:"BUY".text.semiBold.white.size(18).make(),
                  color:Colors.blue
                )
              ])
            ],alignment: MainAxisAlignment.spaceBetween,).p12()
          ).py12().px12();
        }
      )
    );
  }
}