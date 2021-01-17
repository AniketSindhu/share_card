import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_card/pages/homepage.dart';
import 'package:share_card/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:velocity_x/velocity_x.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool login=prefs.getBool('login');
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en','US'),Locale('zh','CN')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: login==null?App():login?App1():App()
    ),
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
        AppTheme(id: 'solway_font', data: ThemeData(textTheme: GoogleFonts.solwayTextTheme(Theme.of(context).textTheme,)),description: 'solway font'),
        AppTheme(id: 'abeezee_font', data: ThemeData(textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme,)),description: 'aBeeZee font'),
        AppTheme(id: 'tenorsans_font', data: ThemeData(textTheme: GoogleFonts.tenorSansTextTheme(Theme.of(context).textTheme,)),description: 'tenorSans font'),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder:(themeContext)=> GetMaterialApp(
            routes: {
              'login':(context)=>Login(),
              'home':(context)=>HomePage()
            },
            theme: ThemeProvider.themeOf(themeContext).data,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(
              seconds: 3,
              image: new Image.asset('assets/splash.jpeg'),
              photoSize: 150.0,
              navigateAfterSeconds: FutureBuilder(
              // Initialize FlutterFire:
              future: _initialization,
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return  Scaffold(
                      body: Center(
                        child:"Network error".text.size(20).bold.make()
                      ),
                  ); 
                }
                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  return Login();
                }
                // Otherwise, show something whilst waiting for initialization to complete
                return Scaffold(
                  body: Center(
                    child:CircularProgressIndicator()
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}


class App1 extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
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
        AppTheme(id: 'solway_font', data: ThemeData(textTheme: GoogleFonts.solwayTextTheme(Theme.of(context).textTheme,)),description: 'solway font'),
        AppTheme(id: 'abeezee_font', data: ThemeData(textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme,)),description: 'aBeeZee font'),
        AppTheme(id: 'tenorsans_font', data: ThemeData(textTheme: GoogleFonts.tenorSansTextTheme(Theme.of(context).textTheme,)),description: 'tenorSans font'),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder:(themeContext)=> GetMaterialApp(
            routes: {
              'login':(context)=>Login(),
              'home':(context)=>HomePage()
            },
            theme: ThemeProvider.themeOf(themeContext).data,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(
              seconds: 3,
              image: new Image.asset('assets/splash.jpeg'),
              photoSize: 150.0,
              navigateAfterSeconds: FutureBuilder(
              // Initialize FlutterFire:
              future: _initialization,
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return  Scaffold(
                      body: Center(
                        child:"Network error".text.size(20).bold.make()
                      ),
                  ); 
                }
                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  return HomePage();
                }
                // Otherwise, show something whilst waiting for initialization to complete
                return Scaffold(
                  body: Center(
                    child:CircularProgressIndicator()
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}