import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  final String name;
  final String email;
  final String company;
  final String location;
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
      this.location,
      this.mobile,
      this.name,
      this.position,
      this.specialization,
      this.website,
      this.cardNumber,
      this.qrCode});

  factory CardModel.fromDocument(DocumentSnapshot doc){
    return CardModel(
      name: doc['name'],
      email: doc['email'],
      company: doc['company'],
      location: doc['location'],
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
