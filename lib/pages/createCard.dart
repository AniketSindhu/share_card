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
        ).centered(),
        20.heightBox,
        TextField(
          decoration: InputDecoration(
            hintText: "Name",
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
        10.heightBox,
        TextField(
          decoration: InputDecoration(
            hintText: "Email",
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
        10.heightBox,
        TextField(
          decoration: InputDecoration(
            hintText: "Company name",
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
        10.heightBox,
        TextField(
          decoration: InputDecoration(
            hintText: "Location",
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
        10.heightBox,
        TextField(
          decoration: InputDecoration(
            hintText: "Website",
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
        10.heightBox,
        TextField(
          decoration: InputDecoration(
            hintText: "Position",
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
        10.heightBox,
        TextField(
          decoration: InputDecoration(
            hintText: "Specialization",
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
        15.heightBox,
        FlatButton(
          onPressed: (){
          },
          child: "Save info".text.size(22).semiBold.white.make().py12(),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
      ]).p20().scrollVertical(),
    );
  }
}