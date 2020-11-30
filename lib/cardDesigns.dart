import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
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
        cardModel.specialization != null
            ? cardModel.specialization.text.size(16).semiBold.make()
            : cardModel.position.text.size(16).medium.make(),
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
              child: HStack(
        [
          VStack([
            cardModel.email.text.white.size(16).make(),
            4.heightBox,
            cardModel.mobile.text.white.size(16).make(),
            4.heightBox,
            cardModel.location.text.white.size(16).make(),
          ], alignment: MainAxisAlignment.center, axisSize: MainAxisSize.max)
              .expand(),
        ],
        axisSize: MainAxisSize.max,
      ).p16())
          .black
          .make()
          .h(100)
    ]))
        .gray400
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }

  if (cardModel.cardNumber == 3) {
    return VxBox(
      child: VStack([
        VxBox(
          child:cardModel.company.text
            .size(25)
            .white
            .capitalize
            .bold
            .make()
            .centered(),
        ).height(80).width(double.infinity).blue600.make(),
        15.heightBox,
        Row(
          children: [
            Column(
              children: [
                cardModel.name.text.size(25).extraBlack.capitalize.bold.make(),
                2.heightBox,
                cardModel.position.text.size(16).semiBold.make(),
                16.heightBox,
                cardModel.mobile.text.black.size(16).make(),
                2.heightBox,
                cardModel.email.text.black.size(16).make(),
              ],crossAxisAlignment: CrossAxisAlignment.start,
            ),
            PrettyQr(
              typeNumber: 3,
              size: 60,
              data: cardModel.qrCode,
              roundEdges: true
            ).objectCenterRight().expand()
          ],
        ).p16(),
      ]),
    )
        .gray200
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }

  if (cardModel.cardNumber == 4) {
    return VxBox(
      child: VStack([
        cardModel.company.text.size(25).capitalize.yellow400.medium.make(),
        3.heightBox,
        cardModel.location.text.size(18).white.normal.make(),
        15.heightBox,
        cardModel.name.text.size(20).yellow400.medium.make(),
        3.heightBox,
        cardModel.specialization.text.size(18).white.normal.make(),
        20.heightBox,
        HStack([
          VxBox().height(15).width(15).pink600.make(),
          10.widthBox,
          cardModel.mobile.text.size(18).white.normal.make(),
        ]),
        HStack([
          VxBox().height(15).width(15).orange500.make(),
          10.widthBox,
          cardModel.email.text.size(18).white.normal.make(),
        ]),
      ]).p32()
    )
        .black
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }

  if (cardModel.cardNumber == 5) {
    return VxBox(
      child: VStack([
        Row(
          children: [
            Column(
              children: [
                cardModel.name.text.size(20).red800.medium.make(),
                3.heightBox,
                cardModel.position.text.size(20).red800.medium.make(),
                20.heightBox,
                HStack([
                  Icon(Icons.mobile_friendly,color: Vx.red800,size: 30,),
                  10.widthBox,
                  cardModel.mobile.text.size(18).red800.normal.make(),
                ]),
                HStack([
                  Icon(Icons.mail,color: Vx.red800,size: 30,),
                  10.widthBox,
                  cardModel.email.text.size(18).red800.normal.make(),
                ]),
                HStack([
                  Icon(Icons.web,color: Vx.red800,size: 30,),
                  10.widthBox,
                  cardModel.website.text.size(18).red800.normal.make(),
                ]),
              ],crossAxisAlignment: CrossAxisAlignment.start,
            ),
            VxBox(
              child: CircleAvatar(
                backgroundImage: NetworkImage(cardModel.image),
                radius: 30,
              )..objectCenterRight().expand(),
            ).roundedFull.shadowLg.make(),
          ],mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        ).px20().py16(),
        VxBox(
          child: HStack([
            Icon(Icons.location_city,color: Vx.white,size: 30,),
            10.widthBox,
            cardModel.location.text.size(18).white.normal.make(),
          ]).px20(),
        ).width(double.infinity).height(75).red800.make().expand()
      ])
    )
        .color(Colors.amber[100])
        .width(context.percentWidth * 95)
        .height(250)
        .shadowMd
        .rounded
        .makeCentered();
  }
  
  if(cardModel.cardNumber == 6){
    return VxBox(
      child: HStack([
        VStack([
          45.heightBox,
          cardModel.name.text.size(25).white.medium.make(),
          3.heightBox,
          cardModel.position.text.size(20).white.make(),
          cardModel.company.text.size(20).white.medium.make().objectBottomCenter().expand(),
        ],alignment: MainAxisAlignment.center,axisSize: MainAxisSize.max,),
        VStack([
          10.heightBox,
          cardModel.location.text.size(20).white.medium.make(),
          35.heightBox,
          cardModel.email.text.size(14).white.make(),
          2.heightBox,
          cardModel.mobile.text.size(18).white.medium.make(),
          cardModel.website.text.size(20).white.medium.make().objectBottomCenter().expand(),
        ],alignment: MainAxisAlignment.start,axisSize: MainAxisSize.max,),    
      ],alignment: MainAxisAlignment.spaceBetween,).p20()
    )
      .color(Colors.limeAccent[700])
      .width(context.percentWidth * 95)
      .height(250)
      .shadowMd
      .rounded
      .makeCentered();
  }

  if(cardModel.cardNumber == 7){
    return VxBox(
      child: VStack([
        Divider(thickness:2.0,color: Vx.white,),
        cardModel.name.text.size(25).white.medium.make(),
        2.heightBox,
        cardModel.position.text.size(18).white.medium.make(),
        cardModel.specialization.text.size(18).white.medium.make(),
        Divider(thickness:2.0,color: Vx.white,),
        4.heightBox,
          Row(
            children: [
              VStack([
                HStack([
                  Icon(Icons.mobile_friendly,color: Vx.white,size: 30,),
                  10.widthBox,
                  cardModel.mobile.text.size(14).white.normal.make(),
                ]),
                2.heightBox,
                HStack([
                  Icon(Icons.mail,color: Vx.white,size: 30,),
                  10.widthBox,
                  cardModel.email.text.size(14).white.normal.make(),
                ]),
                HStack([
                  Icon(Icons.web,color: Vx.white,size: 30,),
                  10.widthBox,
                  cardModel.website.text.size(14).white.normal.make(),
                ]),
              ],alignment: MainAxisAlignment.center,),
              PrettyQr(
                typeNumber: 3,
                size: 60,
                elementColor: Colors.white,
                data: cardModel.qrCode,
                roundEdges: true
              ).objectCenterRight().expand()
            ],
          ),
        Divider(thickness:2.0,color: Vx.white,).objectBottomCenter().expand(),
      ]).p16()
    )
      .color(Colors.teal[400])
      .width(context.percentWidth * 95)
      .height(250)
      .shadowMd
      .rounded
      .makeCentered();
  }

  if(cardModel.cardNumber == 8){
    return VxBox(
      child: HStack([
        Column(
          children: [
            HStack([
              Icon(Icons.mobile_friendly,color: Vx.black,size: 25,),
              10.widthBox,
              cardModel.mobile.text.size(14).black.normal.make(),
            ]),
            2.heightBox,
            HStack([
              Icon(Icons.mail,color: Vx.black,size: 25,),
              10.widthBox,
              cardModel.email.text.size(14).black.normal.make(),
            ]),
            HStack([
              Icon(Icons.web,color: Vx.black,size: 25,),
              10.widthBox,
              cardModel.website.text.size(14).black.normal.make(),
            ]),
          ],mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
        ).p12(),
        VStack([
          VxBox().blue700.height(40).make(),
          10.heightBox,
          cardModel.name.text.size(22).blue700.medium.make(),
          2.heightBox,
          cardModel.specialization.text.size(15).blue700.medium.make(),
          20.heightBox,
          cardModel.company.text.size(18).black.medium.make(),
          4.heightBox,
          cardModel.location.text.size(18).black.medium.make(),
        ],crossAlignment: CrossAxisAlignment.start,).expand()
      ],crossAlignment: CrossAxisAlignment.center,).py20()
    )
      .color(Vx.gray400)
      .width(context.percentWidth * 95)
      .height(250)
      .shadowMd
      .rounded
      .makeCentered();
  }

  if(cardModel.cardNumber == 9){
    return VxBox(
      child: HStack([
        VxBox(
          child: CircleAvatar(
            backgroundImage: NetworkImage(cardModel.image),
            radius: 45,
          ),
        ).roundedFull.shadowXl.make().objectTopLeft(),
        15.widthBox,
        VStack([
          cardModel.name.text.size(24).gray800.medium.make(),
          cardModel.specialization.text.size(18).gray800.make(),
          25.heightBox,
          cardModel.mobile.text.size(18).gray800.make(),
          cardModel.email.text.size(18).gray800.make(),
          Column(
            children: [
              cardModel.company.text.size(20).gray800.make(),
              cardModel.location.text.size(20).gray800.make(),
            ],mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.start
          ).expand(),
        ],alignment: MainAxisAlignment.start,)
      ],crossAlignment: CrossAxisAlignment.start,).p24()
    )
      .color(Colors.deepOrange[200])
      .width(context.percentWidth * 95)
      .height(250)
      .shadowMd
      .rounded
      .makeCentered();
  }

/*   if(cardModel.cardNumber == 10){
    return VxBox()
      .color(Colors.amber[100])
      .width(context.percentWidth * 95)
      .height(250)
      .shadowMd
      .rounded
      .makeCentered();
  } */

  
}
