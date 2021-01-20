import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getf;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_card/cardDesigns.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:share_card/pages/create.dart';
import 'package:share_card/pages/notfications.dart';
import 'package:share_card/pages/profile.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

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
      ),
      appBar: AppBar(
        leadingWidth: 10,
        title: "home".tr().toString().text.semiBold.size(20).white.make(),
        actions: [
          GestureDetector(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
            },
            child: user!=null?StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(user.mobile).collection('notifications').where('isRead',isEqualTo: false).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Icon(Icons.notifications_rounded);
                }
                else if(!snapshot.hasData){
                  return Icon(Icons.notifications_rounded);
                }
                else{
                  if(snapshot.data.documents.length==0){
                    return Icon(Icons.notifications_rounded);
                  }
                  else{
                    return Icon(Icons.notifications_rounded).badge(count:snapshot.data.documents.length,color: Colors.red,textStyle: TextStyle(fontSize: 15,color: Colors.white)).centered();
                  }
                }
              }
            ):Icon(Icons.notifications_rounded),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>ProfilePage()));
            },
            child: Icon(Icons.person,color: Vx.white,size: 30,).p12()),
          ],
      ),
      body: user!=null||card!=null?VStack([
        TextField(
          onChanged: (v){
            setState(() {});
          },
          controller: search,
          decoration: InputDecoration(
            hintText: "Search by specialization",
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/home.jpg",height: (context.percentHeight*55),).centered(),
            (20).heightBox,
            "No card here!".text.semiBold.size(18).makeCentered()
          ],
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
              future: FirebaseFirestore.instance.collection('users').doc(user.mobile).collection('createdCards').get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return VxBox().gray500.width(context.percentHeight*95).height(250).makeCentered().shimmer();
                }
                else{
                  if(snapshot.data==null){
                    return Container();
                  }
                  else{
                    if(snapshot.data.documents.length==0){
                      return Container();
                    }
                    else{
                      return Column(
                        children: [
                          10.heightBox,
                          "Created cards:".text.size(24).semiBold.make().objectCenterLeft().p4(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context,index){
                              CardModel card1 = CardModel.fromDocument(snapshot.data.documents[index]);
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child:GestureDetector(
                                  onTap: (){
                                    getf.Get.dialog(
                                     Dialog(
                                       child: VStack([
                                         "Add to Contacts".text.bold.black.size(22).makeCentered(),
                                         15.heightBox,
                                         "Do you want to add this to your contacts?".text.size(18).make(),
                                         10.heightBox,
                                         FlatButton(
                                           child: "Add".text.white.size(20).make(),
                                           onPressed: ()async{
                                             if (await Permission.contacts.request().isGranted) {
                                               await ContactsService.addContact(
                                                 Contact(
                                                   displayName: card1.firstName+' '+card1.secondName,
                                                   givenName: card1.firstName+' '+card1.secondName,
                                                   company: card1.company,
                                                   jobTitle: card1.position,
                                                   emails: [Item(label: card1.email,value: card1.email)],
                                                   phones: [Item(label: card1.mobile,value: card1.mobile)],
                                                   androidAccountType: AndroidAccountType.other,
                                                   androidAccountName: card1.firstName+' '+card1.secondName
                                                 )
                                               ); 
                                               context.showToast(
                                               msg: 'Contact added',
                                               bgColor: Vx.green500,
                                               textColor: Colors.white,
                                               position: VxToastPosition.top,
                                               pdHorizontal: 20,
                                               showTime: 3500,
                                               pdVertical: 10); 
                                             }
                                           },
                                           color: Colors.blue,
                                         )
                                       ],crossAlignment: CrossAxisAlignment.center,).p16().h24(context),
                                     )
                                    );
                                  },
                                  child:cardDesigns(card1, context))
                                );
                            }
                          ),
                        ],
                      );
                    }
                  }
                }
              },
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
                                    child:
                                      GestureDetector(
                                        child:cardDesigns(card1, context),
                                        onTap: (){
                                          getf.Get.dialog(
                                            Dialog(
                                              child: VStack([
                                                "Add to Contacts".text.bold.black.size(22).makeCentered(),
                                                15.heightBox,
                                                "Do you want to add this to your contacts?".text.size(18).make(),
                                                10.heightBox,
                                                FlatButton(
                                                  child: "Add".text.white.size(20).make(),
                                                  onPressed: ()async{
                                                    if (await Permission.contacts.request().isGranted) {
                                                      await ContactsService.addContact(
                                                        Contact(
                                                          displayName: card1.firstName+' '+card1.secondName,
                                                          givenName: card1.firstName+' '+card1.secondName,
                                                          company: card1.company,
                                                          jobTitle: card1.position,
                                                          emails: [Item(label: card1.email,value: card1.email)],
                                                          phones: [Item(label: card1.mobile,value: card1.mobile)],
                                                          androidAccountType: AndroidAccountType.other,
                                                          androidAccountName: card1.firstName+' '+card1.secondName
                                                        )
                                                      ); 
                                                      context.showToast(
                                                      msg: 'Contact added',
                                                      bgColor: Vx.green500,
                                                      textColor: Colors.white,
                                                      position: VxToastPosition.top,
                                                      pdHorizontal: 20,
                                                      showTime: 3500,
                                                      pdVertical: 10); 
                                                    }
                                                  },
                                                  color: Colors.blue,
                                                )
                                              ],crossAlignment: CrossAxisAlignment.center,).p16().h24(context),
                                            )
                                          );
                                        },
                                      )
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
            future: FirebaseFirestore.instance.collection('users').get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              else if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context,index){
                      CardModel card1 = CardModel.fromDocument(snapshot.data.documents[index]);
                      if(card1!=null){
                        if(card1.specialization.toLowerCase().contains(search.text.toLowerCase()))
                          return Column(
                            children: [
                              ListTile(
                                title: "${card1.firstName} ${card1.secondName}".text.make(),
                                subtitle: card1.specialization.text.make(),
                                trailing: FlatButton(
                                  onPressed: ()async{
                                    final close= context.showLoading(msg:'Loading');
                                    Future.delayed(1.seconds,close);
                                    bool result = await sayHi(user.mobile,card.firstName,card1);
                                    if(result){
                                      context.showToast(
                                        msg: 'Hi sent!',
                                        showTime: 4500,
                                        bgColor: Vx.green500,
                                        textColor: Colors.white,
                                        position: VxToastPosition.top,
                                        pdHorizontal: 20,
                                        pdVertical: 10);
                                    }
                                    else{
                                      context.showToast(
                                        msg: 'chat already initiated',
                                        showTime: 4500,
                                        bgColor: Vx.red500,
                                        textColor: Colors.white,
                                        position: VxToastPosition.top,
                                        pdHorizontal: 20,
                                        pdVertical: 10);
                                    }
                                  },
                                  color: Colors.blue,
                                  child: "Say \"Hi\"".text.white.make(),),
                              ),
                              Divider(thickness: 0.8,)
                            ],
                          );
                        else 
                          return Container();
                      }
                      else{
                        return Container();
                      }
                    }
                  );
              }
              else{
                return CircularProgressIndicator();
              }
            }
          ),
      ]).p8().scrollVertical()
      :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/home.jpg",height: (context.percentHeight*55),).centered(),
          (20).heightBox,
          "No card here!".text.semiBold.size(18).makeCentered()
        ],
      ),
    );
  }
}