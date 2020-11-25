import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  await FirebaseFirestore.instance.collection("users").doc(phone).set({
    'userd':uid,
    'phone':phone,
    'availableCard_count':100,
    'sharedCard_count':0,
    'recievedCard_count' :0
  });
  return true;
}

void logout() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('login', false);
  await FirebaseAuth.instance.signOut();
}
