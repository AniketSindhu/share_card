import 'package:flutter/material.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel user;
  CardModel card;
  getUser1() async{
    card = await getCurrentUserCard();
    user = await getUser();
    nameController = TextEditingController(text: card.name);
    emailController = TextEditingController(text:card.email);
    companyNameController = TextEditingController(text:card.company);
    locationController = TextEditingController(text:card.location);
    webController = TextEditingController(text:card.website);
    positionController = TextEditingController(text:card.position);
    setState(() {
    });
  }
  TextEditingController nameController ;
  TextEditingController emailController ;
  TextEditingController companyNameController ;
  TextEditingController locationController ;
  TextEditingController webController ;
  TextEditingController positionController ;
  String specialization;
  void initState(){
    super.initState();
    getUser1();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Profile".text.semiBold.size(20).white.make(),
          centerTitle: true,
          ),      
        body: user!=null||card!=null?VStack([
          10.heightBox,
          CircleAvatar(
            backgroundImage:NetworkImage(card.image,),
            radius: 40,
          ).centered(),
          5.heightBox,
          card.name.text.size(25).bold.makeCentered(),
          5.heightBox,
          HStack([
            VStack([
              user.recievedCards.text.semiBold.size(22).make().centered(),
              "Received".text.medium.size(16).make(),
            ],crossAlignment: CrossAxisAlignment.center,),
            VStack([
              user.sharedCards.text.semiBold.size(22).make().centered(),
              "Shared".text.medium.size(16).make(),
            ],crossAlignment: CrossAxisAlignment.center,),
            VStack([
              user.availableCards.text.semiBold.size(22).make().centered(),
              "Available".text.medium.size(16).make(),
            ],crossAlignment: CrossAxisAlignment.center,)
          ],alignment: MainAxisAlignment.spaceEvenly,axisSize: MainAxisSize.max,).p12(),
          20.heightBox,
          TextFormField(
              controller: nameController,
              validator: (v) =>
                  v.trim().length < 2 ? " Enter valid name" : null,
              decoration: InputDecoration(
                hintText: "Name",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
              )).w(double.infinity).h(60),
          10.heightBox,
          TextFormField(
              controller: emailController,
              validator: (value) {
                {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value))
                    return 'Enter Valid Email';
                  else
                    return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Email",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
              )).w(double.infinity).h(60),
          10.heightBox,
          TextFormField(
              controller: companyNameController,
              validator: (v) =>
                  v.trim().length < 2 ? " Enter valid name" : null,
              decoration: InputDecoration(
                hintText: "Company name",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
              )).w(double.infinity).h(60),
          10.heightBox,
          TextFormField(
              controller: locationController,
              validator: (v) =>
                  v.trim().length < 2 ? " Enter valid location" : null,
              decoration: InputDecoration(
                hintText: "Location",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
              )).w(double.infinity).h(60),
          10.heightBox,
          TextFormField(
              controller: webController,
              validator: (v) =>
                  v.trim().length < 2 ? " Enter valid website" : null,
              decoration: InputDecoration(
                hintText: "Website",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
              )).w(double.infinity).h(60),
          10.heightBox,
          TextFormField(
              controller: positionController,
              validator: (v) =>
                  v.trim().length < 1 ? " Enter valid position" : null,
              decoration: InputDecoration(
                hintText: "Position",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
              )).w(double.infinity).h(60),
          10.heightBox,
          DropdownButtonFormField(
              hint: "Specialization".text.make(),
              onChanged: (val) {
                setState(() {
                  specialization = val;
                });
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Vx.gray700,
                    width: 1,
                  ),
                ),
              ),
              items: [
                DropdownMenuItem(
                    child: "Android Developer".text.make(),
                    value: "Android Developer"),
                DropdownMenuItem(
                    child: "Website Developer".text.make(),
                    value: "Website Developer"),
              ]).h(60),
          15.heightBox,
        ]).p12().scrollVertical():Column(
          children: [
            CircularProgressIndicator(),
            10.heightBox,
            "Create card".text.semiBold.size(20).makeCentered()
          ],mainAxisAlignment: MainAxisAlignment.center,
        ).centered(),
    );
  }
}