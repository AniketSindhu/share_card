import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_card/cardDesigns.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:share_card/pages/create.dart';
import 'package:velocity_x/velocity_x.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  UserModel user;
  CardModel card;
  getUser1() async{
    card = await getCurrentUserCard();
    user = await getUser();
    setState(() {
    });
  }

  void initState(){
    super.initState();
    getUser1();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context){
            return Create();
          }));
        },
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "HOME".text.semiBold.size(20).white.make(),
        actions: [
          Icon(Icons.person,color: Vx.blue900,size: 30,).p12(),
          ],
      ),
      body: user!=null||card!=null?VStack([
        TextField(
          decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Vx.gray700,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Vx.gray700,
                width: 2,
              ),
            ),
          )
        ).w(double.infinity),
        !user.cardCreated?
        Expanded(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/void.svg",height: (context.percentHeight*35),).centered(),
              (20).heightBox,
              "No card here!".text.semiBold.size(18).makeCentered()
            ],
          )
        ):
          VStack([
            10.heightBox,
            "My Card:".text.semiBold.size(24).make(),
            5.heightBox,
            Padding(
             padding: EdgeInsets.all(10),
             child:cardDesigns(card, context)
            )
          ])
      ]).p16()
      :CircularProgressIndicator().centered(),
    );
  }
}