import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_card/cardDesigns.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:share_card/pages/homepage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectTemplateOther extends StatefulWidget {
  final String phone;
  SelectTemplateOther({this.phone});
  @override
  _SelectTemplateOtherState createState() => _SelectTemplateOtherState();
}

class _SelectTemplateOtherState extends State<SelectTemplateOther> {
  UserModel user;
  CardModel card;
  getUser1() async {
    user = await getUser();
    final x = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.mobile)
        .collection('createdCards')
        .doc(widget.phone)
        .get();
    card = CardModel.fromDocument(x);
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
        title: "select_template".tr().toString().text.white.make(),
        centerTitle: true,
      ),
      body: user != null || card != null
          ? ListView.builder(
              itemCount: user.isPremium ? 9 : 2,
              itemBuilder: (context, index) {
                CardModel card1 = CardModel(
                    cardNumber: index + 1,
                    company: card.company,
                    website: card.website,
                    image: card.image,
                    firstName: card.firstName,
                    secondName: card.secondName,
                    email: card.email,
                    address1: card.address1,
                    address2: card.address2,
                    country: card.country,
                    postCode: card.postCode,
                    industry: card.industry,
                    mobile: card.mobile,
                    position: card.position,
                    specialization: card.specialization,
                    qrCode: card.qrCode);
                return GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.mobile)
                              .collection('createdCards')
                              .doc(widget.phone)
                              .update({'cardNumber': index + 1});
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              ModalRoute.withName('/home'));
                          context.showToast(
                              msg: "card_created".tr().toString(),
                              bgColor: Colors.green,
                              textColor: Colors.white,
                              showTime: 2500,
                              pdHorizontal: 20,
                              pdVertical: 10,
                              position: VxToastPosition.top);
                        },
                        child: cardDesigns(card1, context))
                    .p16();
              },
            )
          : CircularProgressIndicator().centered(),
    );
  }
}
