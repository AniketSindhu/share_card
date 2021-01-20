import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "notifications".tr().toString().text.white.make(),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator().centered();
            } else if (snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/void.svg",
                    height: (context.percentHeight * 35),
                  ).centered(),
                  (20).heightBox,
                  "no_notifications"
                      .tr()
                      .toString()
                      .text
                      .semiBold
                      .size(18)
                      .makeCentered()
                ],
              );
            } else {
              if (snapshot.data.length == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/void.svg",
                      height: (context.percentHeight * 35),
                    ).centered(),
                    (20).heightBox,
                    "no_notifications"
                        .tr()
                        .toString()
                        .text
                        .semiBold
                        .size(18)
                        .makeCentered()
                  ],
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: "${snapshot.data[index].data()['msg']}"
                            .text
                            .size(18)
                            .medium
                            .make(),
                        leading: Icon(
                          Icons.notification_important,
                          color: Colors.blue[400],
                          size: 30,
                        ),
                        /*  trailing:
                            "${snapshot.data[index].data()['time'].toDate().format()}"
                                .text
                                .make(), */
                      ),
                      Divider(thickness: 2.0)
                    ],
                  );
                },
              );
            }
          },
        ));
  }
}
