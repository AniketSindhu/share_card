import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:share_card/pages/homepage.dart';
import 'package:velocity_x/velocity_x.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:VStack([
        Expanded(child: SvgPicture.asset("assets/otp.svg",height: context.percentHeight*30).centered()),
        "Verfication".text.semiBold.size(25).makeCentered(),
        10.heightBox,
        "OTP Verification".text.normal.size(18).make(),
        10.heightBox,
        "Please enter otp sent to your mobile".text.thin.size(16).make(),
        OTPTextField(
          length: 6,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 20,
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.underline,
          onCompleted: (pin) {
            print("Completed: " + pin);
          },
        ).centered(),
        30.heightBox,
        FlatButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>HomePage()),ModalRoute.withName('/login'));
          },
          child: "CONTINUE".text.size(22).semiBold.white.make().py12(),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        (context.percentHeight*4).heightBox
      ],alignment: MainAxisAlignment.center,).p20().centered()
    );
  }
}