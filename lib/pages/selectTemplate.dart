import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_card/cardDesigns.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:share_card/pages/homepage.dart';
import 'package:velocity_x/velocity_x.dart';

class SelectTemplate extends StatefulWidget {
  @override
  _SelectTemplateState createState() => _SelectTemplateState();
}

class _SelectTemplateState extends State<SelectTemplate> {
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
        title: "Select Template".text.white.make(),
        centerTitle: true,
      ),
      body: user != null || card != null
          ? ListView.builder(
              itemCount: user.isPremium ? 5 : 2,
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
                  qrCode: card.qrCode
                );
                return GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.mobile)
                              .update({'cardNumber': index + 1});
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              ModalRoute.withName('/home'));
                          context.showToast(
                              msg: "Card created!",
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
