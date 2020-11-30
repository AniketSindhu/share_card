import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Help'.text.make(),
      ),
      body: FlatButton(
        color:Colors.blue,
        child:'Contact us'.text.white.make(),
        onPressed: (){},
      ).centered(),
    );
  }
}