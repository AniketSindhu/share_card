import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_card/cardDesigns.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class Qr extends StatefulWidget {
  @override
  _QrState createState() => _QrState();
}

class _QrState extends State<Qr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 10,
        title: tr("scan_qr").toString().text.semiBold.size(20).white.make(),
      ),
      body: VStack([
        Expanded(
            child: FutureBuilder(
                future: getQr(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator().centered();
                  } else
                    return PrettyQr(
                            typeNumber: 3,
                            size: 200,
                            data: snapshot.data,
                            roundEdges: true)
                        .centered();
                })),
        FlatButton(
          onPressed: () async {
            String qr = await FlutterBarcodeScanner.scanBarcode(
                "#ff6666", tr('stop').toString(), true, ScanMode.QR);
            final x = await FirebaseFirestore.instance
                .collection("users")
                .where('qrCode', isEqualTo: qr)
                .get();
            UserModel user = await getUser();

            if (!user.cardCreated) {
              context.showToast(
                  msg: tr('f_create_card').toString(),
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10);
            }
            if (x.docs.isEmpty) {
              context.showToast(
                  msg: tr('no_user').toString(),
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10);
            } else if (x.docs[0].data()['cardCreated'] == false) {
              context.showToast(
                  msg: tr('card_not_created').toString(),
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10);
            } else if (x.docs[0].data()['availableCard_count'] == 0) {
              context.showToast(
                  msg: tr('out_of_cards').toString(),
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10);
            } else {
              CardModel card = await getCard(x.docs[0].data()['phone']);
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: VStack([
                        20.heightBox,
                        cardDesigns(card, context),
                        20.heightBox,
                        FlatButton(
                          onPressed: () async {
                            await receiveCard(card).then((value) {
                              if (value) {
                                context.showToast(
                                    msg: tr('card_added').toString(),
                                    bgColor: Vx.green500,
                                    textColor: Colors.white,
                                    position: VxToastPosition.top,
                                    pdHorizontal: 20,
                                    showTime: 3500,
                                    pdVertical: 10);
                                Navigator.pop(context);
                              } else {
                                context.showToast(
                                    msg: tr('already_added').toString(),
                                    bgColor: Vx.red500,
                                    textColor: Colors.white,
                                    position: VxToastPosition.top,
                                    pdHorizontal: 20,
                                    showTime: 3500,
                                    pdVertical: 10);
                                Navigator.pop(context);
                              }
                            });
                          },
                          child: tr("add_card").toString().text.make(),
                          color: Vx.blue500,
                        ).centered()
                      ]).p12(),
                    );
                  });
            }
          },
          child: tr("scan_qr")
              .toString()
              .text
              .size(20)
              .semiBold
              .white
              .make()
              .py12(),
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        15.heightBox,
        FlatButton(
          onPressed: () {
            Get.dialog(Dialog(
                child: FutureBuilder(
                    future: getQr(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator().centered();
                      } else
                        return Column(
                          children: [
                            PrettyQr(
                                    typeNumber: 3,
                                    size: 200,
                                    data: snapshot.data,
                                    roundEdges: true)
                                .centered(),
                            tr("share_qr").toString().text.size(20).make(),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                        ).p64();
                    })));
          },
          child: tr("share_card")
              .toString()
              .text
              .size(20)
              .semiBold
              .white
              .make()
              .py12(),
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        (context.percentHeight * 3).heightBox
      ]).p16(),
    );
  }
}
