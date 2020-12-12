import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  final String firstName;
  final String secondName;
  final String email;
  final String company;
  final String address1;
  final String address2;
  final String country;
  final String postCode;
  final String industry;
  final String website;
  final String position;
  final String specialization;
  final String mobile;
  final String image;
  final int cardNumber;
  final String qrCode;

  CardModel(
      {this.company,
      this.email,
      this.image,
      this.address1,
      this.address2,
      this.country,
      this.postCode,
      this.industry,
      this.mobile,
      this.firstName,
      this.secondName,
      this.position,
      this.specialization,
      this.website,
      this.cardNumber,
      this.qrCode});

  factory CardModel.fromDocument(DocumentSnapshot doc){
    return CardModel(
      firstName: doc['firstName'],
      secondName: doc['secondName'],
      industry: doc['industry'],
      email: doc['email'],
      company: doc['company'],
      address1: doc['address1'],
      address2: doc['address2'],
      country: doc['country'],
      postCode: doc['postCode'],
      website: doc['website'],
      position: doc['position'],
      specialization: doc['specialization'],
      mobile: doc['phone'],
      image: doc['image'],
      cardNumber: doc['cardNumber'],
      qrCode: doc['qrCode']
    );
  }
  
}
