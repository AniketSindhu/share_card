import 'package:flutter/material.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/pages/addCredits.dart';
import 'package:get/get.dart';
import 'package:share_card/pages/add_on.dart';
import 'package:share_card/pages/help.dart';

import 'package:share_card/pages/login.dart';
import 'package:share_card/pages/nearby.dart';
import 'package:share_card/pages/premium.dart';
import 'package:share_card/pages/profile.dart';
import 'package:share_card/pages/settings.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:flutter_share/flutter_share.dart';

class OptionsModel {
  final Icon icon;
  final String name;
  final Function onTap;
  OptionsModel({this.icon, this.name, this.onTap});
}

List<OptionsModel> optionList = [
  OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Credits",
      onTap: () {
        Get.to(AddCredits());
      }),
  OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Add On",
      onTap: () {
        Get.to(AddOn());
      }),
  OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Profile",
      onTap: () {
        Get.to(ProfilePage());
      }),
  OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Premium",
      onTap: () {
        Get.to(Premium());
      }),
/*   OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Theme",
      onTap: () {
        Get.dialog(ThemeConsumer(child: ThemeDialog()));
      }), */
/*   OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "History",
      onTap: () {
        Get.to(History());
      }), */
/*   OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "language",
      onTap: () {}), */
/*   OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Rate us",
      onTap: () {

      }), */
/*   OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Help",
      onTap: () {
        Get.to(Help());
      }), */
  OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Nearby",
      onTap: () {
        Get.to(Nearby());
      }),
  OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Share",
      onTap: () async {
        await FlutterShare.share(
          title: 'Visting card',
          text: 'Download this visiting card app',
          linkUrl: 'https://flutter.dev/',
        );
      }),
  OptionsModel(
      icon: Icon(Icons.settings, color: Colors.blue[700], size: 20),
      name: "Settings",
      onTap: () {
        Get.to(Settings());
      }),
/*   OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:20),name:"Signature",onTap: (){}), */
  OptionsModel(
      icon: Icon(Icons.logout, color: Colors.blue[700], size: 20),
      name: "Logout",
      onTap: () {
        Get.dialog(WillPopScope(
        onWillPop: (){
          logout();
          Get.offAll(Login());
          return Future.value(true);
        },
          child: Dialog(
            child: Container(
            height: 250,
            width: 300,
            child: Center(
              child: Column(
                children: [
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: 0,
                      size: 40.0,
                      isReadOnly: false,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.blur_on,
                      color: Colors.green,
                      borderColor: Colors.green,
                      spacing: 0.0),
                  SizedBox(height: 10),
                  Center(
                    child: FlatButton(
                      child: Text(
                        'Rate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        logout();
                        Get.offAll(Login());
                      },
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          )),
        ));
      }),
];
