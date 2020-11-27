import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final bool cardCreated;
  final String mobile;
  final String qrCode;
  final int recievedCards;
  final int sharedCards;
  final String userId;
  final int availableCards;
  final bool isPremium;

  UserModel(
      {
        this.cardCreated,
        this.mobile,
        this.qrCode,
        this.recievedCards,
        this.sharedCards,
        this.userId,
        this.availableCards,
        this.isPremium
      });

  factory UserModel.fromDocument(DocumentSnapshot doc){
    return UserModel(
      mobile: doc['phone'],
      recievedCards: doc['recievedCard_count'],
      sharedCards: doc['sharedCard_count'],
      qrCode: doc['qrCode'],
      userId: doc['userd'],
      availableCards: doc['availableCard_count'],
      isPremium: doc['isPremium'],
      cardCreated: doc['cardCreated']
    );
  }
  
}
