import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> currentUid() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  return auth.currentUser.uid;
}

Future<bool> firstTime() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: uid)
      .get();
  return x.docs.isEmpty;
}

Future<bool> addUser(String phone) async {
  String uid = await currentUid();
  String qrCode = randomAlphaNumeric(8);
  await FirebaseFirestore.instance.collection("users").doc(phone).set({
    'userd':uid,
    'phone':phone,
    'availableCard_count':100,
    'sharedCard_count':0,
    'recievedCard_count' :0,
    'qrCode': qrCode,
    'cardCreated':false
  });
  return true;
}

Future<UserModel> getUser() async {
  String uid = await currentUid();
  final x = await FirebaseFirestore.instance.collection('users').where("userd",isEqualTo:uid).get();
  return UserModel.fromDocument(x.docs[0]);
}

Future<String>getQr() async{
    String uid = await currentUid();
    final x = await FirebaseFirestore.instance.collection('users').where("userd",isEqualTo:uid).get();
    return x.docs[0].data()['qrCode'];
  }

void logout() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('login', false);
  await FirebaseAuth.instance.signOut();
}
