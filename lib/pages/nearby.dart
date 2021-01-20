import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class Nearby extends StatefulWidget {
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  UserModel user;
  CardModel card;
  getUser1() async {
    card = await getCurrentUserCard();
    user = await getUser();
    setState(() {});
  }

  void initState() {
    super.initState();
    getUser1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "nearby_users".tr().toString().text.make(),
        centerTitle: true,
      ),
      body: user != null || card != null
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('country', isEqualTo: user.country)
                  .where('cardCreated', isEqualTo: true)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  if (snapshot.data.documents.length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/void.svg",
                          height: (context.percentHeight * 35),
                        ).centered(),
                        (20).heightBox,
                        "no_user_nearby"
                            .tr()
                            .toString()
                            .text
                            .semiBold
                            .size(18)
                            .makeCentered()
                      ],
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          CardModel card1 = CardModel.fromDocument(
                              snapshot.data.documents[index]);
                          if (card1 != null) {
                            return Column(
                              children: [
                                ListTile(
                                  title: card1.firstName.text.make(),
                                  subtitle: card1.specialization.text.make(),
                                  trailing: FlatButton(
                                    onPressed: () async {
                                      final close = context.showLoading(
                                          msg: 'loading'.tr().toString());
                                      Future.delayed(1.seconds, close);
                                      bool result = await sayHi(
                                          user.mobile, card.firstName, card1);
                                      if (result) {
                                        context.showToast(
                                            msg: 'hi_sent'.tr().toString(),
                                            showTime: 4500,
                                            bgColor: Vx.green500,
                                            textColor: Colors.white,
                                            position: VxToastPosition.top,
                                            pdHorizontal: 20,
                                            pdVertical: 10);
                                      } else {
                                        context.showToast(
                                            msg: 'chat_init'.tr().toString(),
                                            showTime: 4500,
                                            bgColor: Vx.red500,
                                            textColor: Colors.white,
                                            position: VxToastPosition.top,
                                            pdHorizontal: 20,
                                            pdVertical: 10);
                                      }
                                    },
                                    color: Colors.blue,
                                    child: "say_hi"
                                        .tr()
                                        .toString()
                                        .text
                                        .white
                                        .make(),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.8,
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                } else {
                  return CircularProgressIndicator();
                }
              })
          : Container(),
    );
  }
}
