import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final String name;
  final bool cardCreated;
  final String mobile;
  final String qrCode;
  final int recievedCards;
  final int sharedCards;
  final String userId;
  final int availableCards;

  UserModel(
      {
        this.cardCreated,
        this.mobile,
        this.name,
        this.qrCode,
        this.recievedCards,
        this.sharedCards,
        this.userId,
        this.availableCards
      });

  factory UserModel.fromDocument(DocumentSnapshot doc){
    return UserModel(
      name: doc['name']==null?doc['phone']:doc['name'],
      mobile: doc['phone'],
      cardCreated: doc['cardCreated']==null?false:doc['cardCreated'],
      recievedCards: doc['recievedCard_count'],
      sharedCards: doc['sharedCard_count'],
      qrCode: doc['qrCode'],
      userId: doc['userd'],
      availableCards: doc['availableCard_count']
    );
  }
  
}
