import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_card/cardDesigns.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:share_card/pages/create.dart';
import 'package:share_card/pages/profile.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  UserModel user;
  CardModel card;
  TextEditingController search = TextEditingController();
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
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>ProfilePage()));
            },
            child: Icon(Icons.person,color: Vx.blue900,size: 30,).p12()),
          ],
      ),
      body: user!=null||card!=null?VStack([
        TextField(
          onChanged: (v){
            setState(() {});
          },
          controller: search,
          decoration: InputDecoration(
            hintText: "Search name, Specialization, Company",
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
        ).p12().w(double.infinity),
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
        ):search.text.trim().length==0?
          VStack([
            10.heightBox,
            "My Card:".text.semiBold.size(24).make().p4(),
            Padding(
             padding: EdgeInsets.all(10),
             child:cardDesigns(card, context)
            ),
            Divider(thickness: 2,),
            FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').doc(user.mobile).get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator().centered();
                }
                else{
                  if(snapshot.data.data()['recieved_cards']==null){
                    return Container();
                  }
                  else{
                    return Column(
                      children: [
                        10.heightBox,
                        "Added cards:".text.size(24).semiBold.make().objectCenterLeft().p4(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.data()['recieved_cards'].length,
                          itemBuilder: (context,index){
                            return FutureBuilder(
                              future: FirebaseFirestore.instance.collection('users').doc(snapshot.data.data()['recieved_cards'][snapshot.data.data()['recieved_cards'].length-index-1]).get(),
                              builder: (context,snapshot){
                                if(snapshot.connectionState== ConnectionState.waiting){
                                  return VxBox().gray500.width(context.percentHeight*95).height(250).makeCentered().shimmer();
                                }
                                else{
                                  CardModel card1 = CardModel.fromDocument(snapshot.data);
                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child:cardDesigns(card1, context)
                                  );
                                }
                              },
                            );
                          }
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ]):
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').doc(user.mobile).get(),
            builder: (context, snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.data()['recieved_cards'].length,
                itemBuilder: (context,index){
                  return FutureBuilder(
                    future: FirebaseFirestore.instance.collection('users').doc(snapshot.data.data()['recieved_cards'][snapshot.data.data()['recieved_cards'].length-index-1]).get(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState== ConnectionState.waiting){
                        return VxBox().gray500.width(context.percentHeight*95).height(250).makeCentered().shimmer();
                      }
                      else{
                        CardModel card1 = CardModel.fromDocument(snapshot.data);
                        if(card.name.contains(search.text)||card1.specialization.contains(search.text)||card.company.contains(search.text))
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child:cardDesigns(card1, context)
                          );
                        else
                          return Container();
                      }
                    },
                  );
                }
              );
            }
          ),
      ]).p8().scrollVertical()
      :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/void.svg",height: (context.percentHeight*35),).centered(),
          (20).heightBox,
          "No card here!".text.semiBold.size(18).makeCentered()
        ],
      ),
    );
  }
}