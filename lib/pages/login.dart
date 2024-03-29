import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/pages/homepage.dart';
import 'package:share_card/pages/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phone;
  String country;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VStack(
      [
        (context.percentHeight * 6).heightBox,
        "sign up".tr().toString().text.bold.size(35).makeCentered(),
        25.heightBox,
        Image.asset(
          'assets/login.jpg',
          height: context.percentHeight * 40,
        ),
        30.heightBox,
        "sign_phone".tr().toString().text.semiBold.size(20).make(),
        8.heightBox,
        "valid_country".tr().toString().text.thin.size(15).make(),
        10.heightBox,
        IntlPhoneField(
          decoration: InputDecoration(
            labelText: 'phone'.tr(),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          initialCountryCode: 'SG',
          onChanged: (phone1) {
            setState(() {
              phone = phone1.completeNumber;
              country = phone1.countryISOCode;
              print(country);
            });
          },
        ),
        25.heightBox,
        FlatButton(
          onPressed: () async {
            final close = context.showLoading(msg: 'loading'.tr().toString());
            Future.delayed(Duration(seconds: 5), close);
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phone,
              verificationCompleted: (PhoneAuthCredential credential) async {
                await FirebaseAuth.instance.signInWithCredential(credential);
                context.showToast(
                    msg: 'code_detected'.tr().toString(),
                    bgColor: Vx.green500,
                    textColor: Colors.white,
                    position: VxToastPosition.top,
                    pdHorizontal: 20,
                    showTime: 3500,
                    pdVertical: 10);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('login', true);
                await firstTime().then((value) async {
                  if (value) {
                    await addUser(phone, country).then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    });
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                  }
                });
              },
              verificationFailed: (FirebaseAuthException e) {
                if (e.code == 'invalid-phone-number') {
                  context.showToast(
                      msg: 'invalid_phone'.tr().toString(),
                      showTime: 4500,
                      bgColor: Vx.red500,
                      textColor: Colors.white,
                      position: VxToastPosition.top,
                      pdHorizontal: 20,
                      pdVertical: 10);
                } else {
                  context.showToast(
                      msg: '${e.code}'.toString(),
                      showTime: 4500,
                      bgColor: Vx.red500,
                      textColor: Colors.white,
                      position: VxToastPosition.top,
                      pdHorizontal: 20,
                      pdVertical: 10);
                }
              },
              codeSent: (String verificationId, int resendToken) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OTP(
                            verificationId: verificationId,
                            phoneNo: phone,
                            country: country)));
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          },
          child: "continue"
              .tr()
              .toString()
              .text
              .size(22)
              .semiBold
              .white
              .make()
              .py12(),
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity).centered(),
        4.heightBox,
        "t&c".tr().toString().text.size(15).makeCentered(),
      ],
      alignment: MainAxisAlignment.center,
    ).p20().centered().scrollVertical());
  }
}
