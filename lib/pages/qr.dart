import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_card/cardDesigns.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:velocity_x/velocity_x.dart';

class Qr extends StatefulWidget {
  @override
  _QrState createState() => _QrState();
}

class _QrState extends State<Qr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "Scan QR code".text.semiBold.size(20).white.make(),
        actions: [
          Icon(Icons.person,color: Vx.blue900,size: 30,).p12(),
          ],
      ),
      body: VStack([
        Expanded(
          child:FutureBuilder(
            future: getQr(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator().centered();
              }
              else
                return PrettyQr(
                  typeNumber: 3,
                  size: 200,
                  data: snapshot.data,
                  roundEdges: true
                ).centered();
            }
          )
        ),
        FlatButton(
          onPressed: () async{
            String qr=await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Stop Scan', true, ScanMode.QR);
            final x = await FirebaseFirestore.instance.collection("users").where('qrCode',isEqualTo:qr).get();
            UserModel user = await getUser();

            if(!user.cardCreated){
              context.showToast(
                  msg: 'First create a card',
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10
              );
            }
            if(x.docs.isEmpty){
              context.showToast(
                  msg: 'No user found invalid qr code',
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10
              );
            }
            else if(x.docs[0].data()['cardCreated']==false){
              context.showToast(
                  msg:'card is not created by the user!',
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10
              );
            }
            else if(x.docs[0].data()['availableCard_count']==0){
              context.showToast(
                  msg:'The user is out of cards!',
                  showTime: 4500,
                  bgColor: Vx.red500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  pdVertical: 10
              );
            }
            else {
              CardModel card =await getCard(x.docs[0].data()['phone']);
              showDialog(
                context: context,
                builder: (context){
                  return Dialog(
                    child: VStack([
                      20.heightBox,
                      cardDesigns(card, context),
                      20.heightBox,
                      FlatButton(
                        onPressed: () async{
                          await receiveCard(card).then((value){
                            if(value){
                              context.showToast(
                                msg: 'Card added !',
                                bgColor: Vx.green500,
                                textColor: Colors.white,
                                position: VxToastPosition.top,
                                pdHorizontal: 20,
                                showTime: 3500,
                                pdVertical: 10);         
                              Navigator.pop(context);
                            }
                            else{
                              context.showToast(
                                msg: 'Card already added',
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
                        child: "Add card".text.make(),
                        color: Vx.blue500,
                      ).centered()
                    ]).p12(),
                  );
                }
              );
            }
          },
          child: "Scan QR code".text.size(20).semiBold.white.make().py12(),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        15.heightBox,
        FlatButton(
          onPressed: (){
            
          },
          child: "Share Card".text.size(20).semiBold.white.make().py12(),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ).w(double.infinity),
        (context.percentHeight*3).heightBox
      ]).p16(),
    );
  }
}