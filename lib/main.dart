import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:share_card/pages/homepage.dart';
import 'package:share_card/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:velocity_x/velocity_x.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool login=prefs.getBool('login');
  runApp(
    login==null?App():login?App1():App()
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
          return ThemeProvider(
            loadThemeOnInit: true,
            themes: [
              AppTheme(id: 'light_theme', data: ThemeData.light(),description: 'light Theme'),
              AppTheme(id: 'dark_theme', data: ThemeData.dark(),description: 'dark Theme'),
              AppTheme(id: 'red', data: ThemeData(primarySwatch: Colors.red),description: 'red Theme'),
              AppTheme(id: 'pink', data: ThemeData(primarySwatch: Colors.pink),description: 'pink Theme'),
              AppTheme(id: 'purple', data: ThemeData(primarySwatch: Colors.purple),description: 'purple Theme'),
              AppTheme(id: 'orange', data: ThemeData(primarySwatch: Colors.orange),description: 'orange Theme'),
              AppTheme(id: 'green', data: ThemeData(primarySwatch: Colors.green),description: 'green Theme'),
            ],
            saveThemesOnChange: true,
            child: ThemeConsumer(
              child: Builder(
                builder:(themeContext)=> GetMaterialApp(
                  theme: ThemeProvider.themeOf(themeContext).data,
                  title: 'Share card',
                  debugShowCheckedModeBanner: false,
                  routes: {
                    'login':(context)=>Login(),
                    'home':(context)=>HomePage()
                  },
                  home: Login(),
                ),
              ),
            ),
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


class App1 extends StatelessWidget {
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
          return ThemeProvider(
            saveThemesOnChange: true,
            loadThemeOnInit: true,
            themes: [
              AppTheme(id: 'light_theme', data: ThemeData.light(),description: 'light Theme'),
              AppTheme(id: 'dark_theme', data: ThemeData.dark(),description: 'dark Theme'),
              AppTheme(id: 'red', data: ThemeData(primarySwatch: Colors.red),description: 'red Theme'),
              AppTheme(id: 'pink', data: ThemeData(primarySwatch: Colors.pink),description: 'pink Theme'),
              AppTheme(id: 'purple', data: ThemeData(primarySwatch: Colors.purple),description: 'purple Theme'),
              AppTheme(id: 'orange', data: ThemeData(primarySwatch: Colors.orange),description: 'orange Theme'),
              AppTheme(id: 'green', data: ThemeData(primarySwatch: Colors.green),description: 'green Theme'),
            ],
            child: ThemeConsumer(
              child: Builder(
                builder:(themeContext)=> GetMaterialApp(
                  theme: ThemeProvider.themeOf(themeContext).data,
                  title: 'Share card',
                  debugShowCheckedModeBanner: false,
                  routes: {
                    'login':(context)=>Login(),
                    'home':(context)=>HomePage()
                  },
                  home: HomePage(),
                ),
              ),
            ),
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