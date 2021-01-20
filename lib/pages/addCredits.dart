import 'package:flutter/material.dart';
import 'package:share_card/model/creditsModel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

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
          title:
              tr("add_credits").toString().text.semiBold.size(20).white.make(),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: addCreditsList.length,
            itemBuilder: (context, index) {
              return Card(
                      elevation: 8,
                      child: HStack(
                        [
                          VStack([
                            tr("x_credits", args: [
                              addCreditsList[index].credits.toString()
                            ]).toString().text.size(20).semiBold.make(),
                            5.heightBox,
                            tr("x_cards", args: [
                              addCreditsList[index].cards.toString()
                            ]).toString().text.size(16).semiBold.make(),
                          ]),
                          VStack([
                            tr("x_price", args: [
                              addCreditsList[index].price.toString()
                            ]).toString().text.size(20).semiBold.make(),
                            5.heightBox,
                            RaisedButton(
                                onPressed: () {},
                                child: tr("buy")
                                    .toString()
                                    .text
                                    .semiBold
                                    .white
                                    .size(18)
                                    .make(),
                                color: Colors.blue)
                          ])
                        ],
                        alignment: MainAxisAlignment.spaceBetween,
                      ).p12())
                  .py12()
                  .px12();
            }));
  }
}
