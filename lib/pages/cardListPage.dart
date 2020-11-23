import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "HOME".text.semiBold.size(20).white.make(),
        actions: [
          Icon(Icons.person,color: Vx.blue900,size: 30,).p12(),
          ],
      ),
      body: VStack([
        TextField(
          decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Vx.gray700,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Vx.gray700,
                width: 2,
              ),
            ),
          )
        ).w(double.infinity),
        Expanded(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/void.svg",height: (context.percentHeight*35),).centered(),
              (20).heightBox,
              "No card here!".text.semiBold.size(18).makeCentered()
            ],
          )
        )
      ]).p16(),
    );
  }
}