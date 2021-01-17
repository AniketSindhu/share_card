import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:share_card/pages/createCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> currentUid() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  return auth.currentUser.uid;
}

Future<bool> firstTime() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where('userd', isEqualTo: uid)
      .get();
  return x.docs.isEmpty;
}

Future<bool> addUser(String phone,String country) async {
  String uid = await currentUid();
  String qrCode = randomAlphaNumeric(8);
  await FirebaseFirestore.instance.collection("users").doc(phone).set({
    'userd': uid,
    'phone': phone,
    'country':country,
    'availableCard_count': 100,
    'sharedCard_count': 0,
    'recievedCard_count': 0,
    'qrCode': qrCode,
    'cardCreated': false,
    'isPremium': false
  }, SetOptions(merge: true));
  return true;
}

Future<UserModel> getUser() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();
  return UserModel.fromDocument(x.docs[0]);
}

createCard(String firstName,String secondName, String email, String company, String address1,String address2, String country, String postCode, String industry,
    String website, String position, String specialization, File image) async {
  UserModel user = await getUser();
  String iid = randomString(6);
  if(image!=null){
    String _uploadedFileURL;
    String fileName = "Images/$iid";
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    await firebaseStorageRef.getDownloadURL().then((fileURL) async {
      _uploadedFileURL = fileURL;
    });
    await firebaseStorageRef.getDownloadURL().then((fileURL) async {
      _uploadedFileURL = fileURL;
    });

    FirebaseFirestore.instance.collection("users").doc(user.mobile).set({
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'company': company,
      'address1': address1,
      'address2': address2,
      'country' : country,
      'postCode': postCode,
      'industry':industry,
      'website': website,
      'position': position,
      'specialization': specialization,
      'image': _uploadedFileURL,
      'cardNumber': 1,
      'cardCreated': true
    }, SetOptions(merge: true));
  }
  else{
    FirebaseFirestore.instance.collection("users").doc(user.mobile).set({
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'company': company,
      'address1': address1,
      'address2': address2,
      'country' : country,
      'postCode': postCode,
      'industry':industry,
      'website': website,
      'position': position,
      'specialization': specialization,
      'image': null,
      'cardNumber': 1,
      'cardCreated': true
    }, SetOptions(merge: true));
  }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.mobile)
        .collection('notifications')
        .add({
      'msg': "Your card was created",
      'time': DateTime.now(),
      'isRead': false
    });

  return true;
}

Future<String> getQr() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();
  return x.docs[0].data()['qrCode'];
}

Future<CardModel> getCard(String mobile) async {
  final x =
      await FirebaseFirestore.instance.collection("users").doc(mobile).get();
  return CardModel.fromDocument(x);
}

Future<CardModel> getCurrentUserCard() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();
  return CardModel.fromDocument(x.docs[0]);
}

Future<bool> receiveCard(CardModel card) async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();

  if (x.docs[0].data()['recieved_cards'] == null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .update({
      'recievedCard_count': FieldValue.increment(1),
      'recieved_cards': [card.mobile],
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('notifications')
        .add({
      'msg': "You received card from ${card.firstName} ${card.secondName}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('history')
        .add({
      'msg': "You received card from ${card.firstName} ${card.secondName}}",
      'time': DateTime.now(),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .update({
      'availableCard_count': FieldValue.increment(-1),
      'sharedCard_count': FieldValue.increment(1)
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .collection('notifications')
        .add({
      'msg': "You shared card with ${x.docs[0].data()['firstName']}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .collection('history')
        .add({
      'msg': "You shared card with ${x.docs[0].data()['firstName']}",
      'time': DateTime.now(),
    });

    await FirebaseFirestore.instance
        .collection('chats')
        .doc('${x.docs[0].data()['phone']}-${card.mobile}')
        .set({
      'chatId': "${x.docs[0].data()['firstName']}-${card.firstName}",
      'users': [x.docs[0].data()['phone'], card.mobile]
    });
    return true;
  } else if (x.docs[0].data()['recieved_cards'].contains(card.mobile)) {
    return false;
  } else {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .update({
      'recievedCard_count': FieldValue.increment(1),
      'recieved_cards': FieldValue.arrayUnion([card.mobile]),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('notifications')
        .add({
      'msg': "You received card from ${card.firstName}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('history')
        .add({
      'msg': "You received card from ${card.firstName}",
      'time': DateTime.now(),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .update({
      'availableCard_count': FieldValue.increment(-1),
      'sharedCard_count': FieldValue.increment(1)
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .collection('notifications')
        .add({
      'msg': "You shared card with ${x.docs[0].data()['firstName']}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .collection('history')
        .add({
      'msg': "You shared card with ${x.docs[0].data()['firstName']}",
      'time': DateTime.now(),
    });

    await FirebaseFirestore.instance
        .collection('chats')
        .doc('${x.docs[0].data()['phone']}-${card.mobile}')
        .set({
      'chatId': "${x.docs[0].data()['firstName']}-${card.firstName}",
      'users': [x.docs[0].data()['phone'], card.mobile]
    });
    return true;
  }
}

Future getNotifications() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();
  final y = await FirebaseFirestore.instance
      .collection('users')
      .doc(x.docs[0].data()['phone'])
      .collection('notifications').orderBy('time',descending: true)
      .get();
  
  for (int i = 0; i < y.docs.length; i++) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('notifications')
        .doc(y.docs[i].id)
        .update({'isRead': true});
  }
  return y.docs;
}

Future getHistory() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();
  final y = await FirebaseFirestore.instance
      .collection('users')
      .doc(x.docs[0].data()['phone'])
      .collection('history').orderBy('time',descending: true)
      .get();
  
  return y.docs;
}

Future<bool> sayHi(String userMobile,String userName, CardModel card) async{
  if(userMobile== card.mobile){
    return false;
  }
  else{
    final x = await FirebaseFirestore.instance.collection('chats').doc('$userMobile-${card.mobile}').get();
    final y = await FirebaseFirestore.instance.collection('chats').doc('${card.mobile}-$userMobile').get();
    if(x.exists||y.exists){
      return false;
    }
    else{
      await FirebaseFirestore.instance.collection('chats').doc('$userMobile-${card.mobile}').set({
        'chatId':'$userName-${card.firstName}',
        'users':[userMobile,card.mobile]
      });
      await FirebaseFirestore.instance.collection('chats').doc('$userMobile-${card.mobile}').collection('msg').add({
        'date': DateTime.now().toIso8601String().toString(),
        'from':userMobile,
        'text':"Hi"
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(card.mobile)
          .collection('notifications')
          .add({
        'msg': "You have a new mesage from $userName",
        'time': DateTime.now(),
        'isRead': false
      });

      return true;
    }     
  }
}

Future<bool> createCardOtherfunc(String firstName,String secondName, String email, String company,String website, String position, String specialization, File image,String mobile,String industry,String address1,String address2,String postCode, String country) async{
  
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();
  if(image!=null){
      String _uploadedFileURL;
      String iid = randomString(6);
      String fileName = "Images/$iid";
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      await firebaseStorageRef.getDownloadURL().then((fileURL) async {
        _uploadedFileURL = fileURL;
      });
      await firebaseStorageRef.getDownloadURL().then((fileURL) async {
        _uploadedFileURL = fileURL;
      });
      final qr = randomAlphaNumeric(8);
      FirebaseFirestore.instance.collection("users").doc(x.docs[0].data()['phone']).collection('createdCards').doc(mobile).set({
        'firstName': firstName,
        'secondName':secondName,
        'industry': industry,
        'email': email,
        'company': company,
        'address1':address1,
        'address2':address2,
        'postCode':postCode,
        'country':country,
        'website': website,
        'position': position,
        'specialization': specialization,
        'image': _uploadedFileURL,
        'cardNumber': 1,
        'cardCreated': true,
        'phone': mobile,
        'qrCode':qr
      });
  }
  else{
      final qr = randomAlphaNumeric(8);
      FirebaseFirestore.instance.collection("users").doc(x.docs[0].data()['phone']).collection('createdCards').doc(mobile).set({
        'firstName': firstName,
        'secondName':secondName,
        'industry': industry,
        'email': email,
        'company': company,
        'address1':address1,
        'address2':address2,
        'postCode':postCode,
        'country':country,
        'website': website,
        'position': position,
        'specialization': specialization,
        'image': null,
        'cardNumber': 1,
        'cardCreated': true,
        'phone': mobile,
        'qrCode':qr
      });
  }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('notifications')
        .add({
      'msg': "A new card was created",
      'time': DateTime.now(),
      'isRead': false
    });

  return true;

}

Future<bool> getPremium() async{
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where("userd", isEqualTo: uid)
      .get();
  if(x.docs[0].data()['isPremium']==true){
    return false;
  }
  else{
    await FirebaseFirestore.instance.collection('users').doc(x.docs[0].data()['phone']).update({
      'isPremium':true
    });
    return true;
  }
}

Future<List> getSpecializations() async{
  final x = await FirebaseFirestore.instance.collection("specializations").doc('values').get();

  return x.data()['val'];
}

void logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('login', false);
  await FirebaseAuth.instance.signOut();
}