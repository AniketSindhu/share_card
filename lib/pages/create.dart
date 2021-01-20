import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_card/pages/createCard.dart';
import 'package:share_card/pages/createCardOthers.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: tr("create_card").toString().text.semiBold.size(20).white.make(),
        actions: [
          Icon(
            Icons.person,
            color: Vx.blue900,
            size: 30,
          ).p12(),
        ],
      ),
      body: VStack([
        Expanded(
            child: Image.asset(
          "assets/create.jpg",
          height: (context.percentHeight * 50),
        ).centered()),
        tr("create?").toString().text.size(26).semiBold.makeCentered(),
        15.heightBox,
        HStack(
          [
            OutlineButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateCard()));
              },
              color: Vx.blue500,
              borderSide: BorderSide(width: 2, color: Vx.blue500),
              child: tr("for_me").toString().text.size(22).black.make(),
            ),
            OutlineButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateCardOthers()));
              },
              color: Vx.blue500,
              borderSide: BorderSide(width: 2, color: Vx.blue500),
              child: tr("for_others").toString().text.size(22).black.make(),
            ),
          ],
          alignment: MainAxisAlignment.spaceEvenly,
          axisSize: MainAxisSize.max,
        ),
        (context.percentHeight * 10).heightBox
      ]).p16(),
    );
  }
}
