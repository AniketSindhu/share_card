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

Future<bool> addUser(String phone) async {
  String uid = await currentUid();
  String qrCode = randomAlphaNumeric(8);
  await FirebaseFirestore.instance.collection("users").doc(phone).set({
    'userd': uid,
    'phone': phone,
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

createCard(String name, String email, String company, String location,
    String website, String position, String specialization, File image) async {
  UserModel user = await getUser();
  String iid = randomString(6);
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
    'name': name,
    'email': email,
    'company': company,
    'location': location,
    'website': website,
    'position': position,
    'specialization': specialization,
    'image': _uploadedFileURL,
    'cardNumber': 1,
    'cardCreated': true
  }, SetOptions(merge: true));

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
      'msg': "You received card from ${card.name}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('history')
        .add({
      'msg': "You received card from ${card.name}",
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
      'msg': "You shared card with ${x.docs[0].data()['name']}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .collection('history')
        .add({
      'msg': "You shared card with ${x.docs[0].data()['name']}",
      'time': DateTime.now(),
    });

    await FirebaseFirestore.instance
        .collection('chats')
        .doc('${x.docs[0].data()['phone']}-${card.mobile}')
        .set({
      'chatId': "${x.docs[0].data()['name']}-${card.name}",
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
      'msg': "You received card from ${card.name}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(x.docs[0].data()['phone'])
        .collection('history')
        .add({
      'msg': "You received card from ${card.name}",
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
      'msg': "You shared card with ${x.docs[0].data()['name']}",
      'time': DateTime.now(),
      'isRead': false
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(card.mobile)
        .collection('history')
        .add({
      'msg': "You shared card with ${x.docs[0].data()['name']}",
      'time': DateTime.now(),
    });

    await FirebaseFirestore.instance
        .collection('chats')
        .doc('${x.docs[0].data()['phone']}-${card.mobile}')
        .set({
      'chatId': "${x.docs[0].data()['name']}-${card.name}",
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

void logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('login', false);
  await FirebaseAuth.instance.signOut();
}
