import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateCard extends StatefulWidget {
  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "Add info".text.semiBold.size(20).white.make(),
        centerTitle: true,
      ),
      body: VStack([
        CircleAvatar(
          child:Icon(Icons.person,color:Vx.blue700,size:60),
          radius: 60,
          backgroundColor: Vx.blue200,
        ).centered()
      ]).p20(),
    );
  }
}