import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:share_card/pages/chatPage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:easy_localization/easy_localization.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  UserModel user;
  CardModel card;
  getUser1() async {
    user = await getUser();
    card = await getCurrentUserCard();
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
          leadingWidth: 10,
          title: tr("chat").toString().text.semiBold.size(20).white.make(),
        ),
        body: user != null && card != null
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .where('users', arrayContains: user.mobile)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator().centered();
                  } else if (snapshot.data.documents.length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/void.svg",
                          height: (context.percentHeight * 35),
                        ).centered(),
                        (20).heightBox,
                        tr("no_chat")
                            .toString()
                            .text
                            .semiBold
                            .size(18)
                            .makeCentered()
                      ],
                    );
                  } else
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                              card.mobile,
                                              snapshot.data.documents[index].id,
                                              snapshot.data.documents[index]
                                                  .data()['chatId']
                                                  .replaceAll("-", "")
                                                  .replaceAll(
                                                      card.firstName, ""))));
                                },
                                leading: Icon(
                                  Icons.person,
                                  color: Vx.blue700,
                                  size: 35,
                                ),
                                title:
                                    '${snapshot.data.documents[index].data()['chatId'].replaceAll("-", "").replaceAll(card.firstName, "")}'
                                        .text
                                        .semiBold
                                        .size(18)
                                        .make(),
                                subtitle: tr("tap_chat")
                                    .toString()
                                    .text
                                    .size(15)
                                    .make(),
                                trailing: Icon(
                                  Icons.navigate_next,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                                enabled: true,
                              ),
                              Divider(thickness: 0.8, height: 0)
                            ],
                          );
                        });
                })
            : CircularProgressIndicator().centered());
  }
}
