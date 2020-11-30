import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class OTP extends StatefulWidget {
  final String verificationId;
  final String phoneNo;
  final String country;
  OTP({this.verificationId,this.phoneNo,this.country});
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
          onCompleted: (pin) async{
            final close = context.showLoading(msg: "Loading");
            Future.delayed(2.seconds,close);
            PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: pin);
            await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).catchError((e){
              context.showToast(
                msg: 'invalid code',
                showTime: 4500,
                bgColor: Vx.red500,
                textColor: Colors.white,
                position: VxToastPosition.top,
                pdHorizontal: 20,
                pdVertical: 10);
            }).then((value) async{
              if(value!=null){
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('login', true);
                await firstTime().then((value) async{
                  if(value){
                    await addUser(widget.phoneNo,widget.country).then((value){
                      context.showToast(
                        msg: 'User Logged in',
                        showTime: 4500,
                        bgColor: Vx.green500,
                        textColor: Colors.white,
                        position: VxToastPosition.top,
                        pdHorizontal: 20,
                        pdVertical: 10);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context){return HomePage();}),ModalRoute.withName('/login'));
                    });
                  }
                  else{
                    context.showToast(
                        msg: 'User Logged in',
                        showTime: 4500,
                        bgColor: Vx.green500,
                        textColor: Colors.white,
                        position: VxToastPosition.top,
                        pdHorizontal: 20,
                        pdVertical: 10);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context){return HomePage();}),ModalRoute.withName('/login'));
                  }
                });
              }
            });
          },
        ).centered(),
        (context.percentHeight*10).heightBox
      ],alignment: MainAxisAlignment.center,).p20().centered()
    );
  }
}