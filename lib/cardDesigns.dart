import 'package:flutter/material.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:velocity_x/velocity_x.dart';

cardDesigns(CardModel cardModel, BuildContext context) {
  if (cardModel.cardNumber == 1) {
    return VxBox(
            child: HStack([
      VStack([
        CircleAvatar(
          backgroundImage: NetworkImage(cardModel.image),
          radius: 40,
        ).objectCenterLeft().expand(),
        10.heightBox,
        cardModel.name.text.capitalize.size(22).bold.make(),
        2.heightBox,
        cardModel.specialization!=null?cardModel.specialization.text.size(16).semiBold.make():cardModel.position.text.size(16).medium.make(),
      ]).w(context.percentWidth * 25),
      VxBox().height(double.infinity).width(1).red400.make(),
      8.widthBox,
      VStack(
        [
          HStack([
            Icon(Icons.business_center, color: Colors.pinkAccent),
            3.widthBox,
            cardModel.position.text.size(16).medium.make().expand()
          ]),
          10.heightBox,
          HStack([
            Icon(Icons.business, color: Colors.pinkAccent),
            3.widthBox,
            cardModel.company.text.size(16).medium.make().expand()
          ]),
          10.heightBox,
          HStack([
            Icon(Icons.location_history, color: Colors.pinkAccent),
            3.widthBox,
            '${cardModel.location}'.text.size(16).medium.make().expand()
          ]),
          10.heightBox,
          HStack([
            Icon(Icons.email, color: Colors.pinkAccent),
            3.widthBox,
            cardModel.email.text.size(15).medium.make().expand()
          ]),
          10.heightBox,
          HStack([
            Icon(Icons.mobile_friendly, color: Colors.pinkAccent),
            3.widthBox,
            cardModel.mobile.text.size(16).medium.make().expand()
          ]),
          10.heightBox,
          HStack([
            Icon(Icons.web, color: Colors.pinkAccent),
            3.widthBox,
            cardModel.website.text.size(16).medium.make().expand()
          ]),
        ],
        crossAlignment: CrossAxisAlignment.start,
      ).expand(),
    ]).p20())
        .pink200
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }

  if (cardModel.cardNumber == 2) {
    return VxBox(
            child: VStack([
      HStack([
        CircleAvatar(
          backgroundImage: NetworkImage(cardModel.image),
          radius: 50,
        ).objectCenterLeft(),
        10.widthBox,
        VStack(
          [
            cardModel.name.text.size(24).extraBlack.capitalize.bold.make(),
            2.heightBox,
            cardModel.specialization != null
                ? cardModel.specialization.text.size(16).semiBold.make()
                : Container(),
            2.heightBox,
            cardModel.position.text.size(16).semiBold.make(),
            3.heightBox,
            cardModel.company.text.size(18).semiBold.make(),
          ],
          crossAlignment: CrossAxisAlignment.end,
          alignment: MainAxisAlignment.start,
        ).expand()
      ]).p20().expand(),
      VxBox(
        child: HStack([
          VStack([
           cardModel.email.text.white.size(16).make(),
           4.heightBox,
           cardModel.mobile.text.white.size(16).make(),
           4.heightBox,
           cardModel.location.text.white.size(16).make(),
          ],alignment: MainAxisAlignment.center,axisSize: MainAxisSize.max).expand(),
        ],axisSize: MainAxisSize.max,).p16()
      ).black.make().h(100)
    ]))
        .gray400
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }

  if (cardModel.cardNumber == 3) {
    return VxBox()
        .blue300
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }

  if (cardModel.cardNumber == 4) {
    return VxBox()
        .green300
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }

  if (cardModel.cardNumber == 5) {
    return VxBox()
        .pink300
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }
}
