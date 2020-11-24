import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:share_card/pages/login.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    App()
  );
}

/* class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Share card',
      debugShowCheckedModeBanner: false,
      routes: {
        'login':(context)=>Login()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
} */

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home:Scaffold(
              body: Center(
                child:"Network error".text.size(20).bold.make()
              ),
            )
          ); 
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: 'Share card',
            debugShowCheckedModeBanner: false,
            routes: {
              'login':(context)=>Login()
            },
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Login(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home:Scaffold(
            body: Center(
              child:CircularProgressIndicator()
            ),
          )
        );
      },
    );
  }
}
