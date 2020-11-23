import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:velocity_x/velocity_x.dart';

class Qr extends StatefulWidget {
  @override
  _QrState createState() => _QrState();
}

class _QrState extends State<Qr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "Share Card".text.semiBold.size(20).white.make(),
        actions: [
          Icon(Icons.person,color: Vx.blue900,size: 30,).p12(),
          ],
      ),
      body: VStack([
        Expanded(
          child:PrettyQr(
            typeNumber: 3,
            size: 200,
            data: 'https://www.google.ru',
            roundEdges: true
          ).centered()
        ),
        FlatButton(
          onPressed: (){
          },
          child: "Share QR code".text.size(20).semiBold.white.make().py12(),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        15.heightBox,
        FlatButton(
          onPressed: (){
          },
          child: "Scan QR code".text.size(20).semiBold.white.make().py12(),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        (context.percentHeight*3).heightBox
      ]).p16(),
    );
  }
}