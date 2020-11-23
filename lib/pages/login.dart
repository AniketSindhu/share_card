import 'package:flutter/material.dart';
import 'package:share_card/pages/otp.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:VStack([
        (context.percentHeight*8).heightBox,
        "Sign Up".text.bold.size(35).makeCentered(),
        25.heightBox,
        SvgPicture.asset("assets/login_svg.svg",height: context.percentHeight*40).centered(),
        30.heightBox,
        "Sign up with Phone number".text.semiBold.size(20).make(),
        8.heightBox,
        "Please enter valid country and mobile number".text.thin.size(15).make(),
        10.heightBox,
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Mobile Number",
            prefixText: "+65 ",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          )
        ).centered(),
        15.heightBox,
        FlatButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OTP()));
          },
          child: "CONTINUE".text.size(22).semiBold.white.make().py12(),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        3.heightBox,
        "By login in you agree our terms and conditions".text.size(15).makeCentered(),
      ],alignment: MainAxisAlignment.center,).p20().centered().scrollVertical()
    );
  }
}