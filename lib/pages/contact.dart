import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController query=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Contact us'.text.white.make(),
      ),
      body: VStack(
        [
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                enabledBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                disabledBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                helperText: 'Tell your query',
                labelText: 'Query'),
            controller: query,
          ),
          10.heightBox,
          FlatButton(
            child: 'Send Query'.text.white.make(),
            color: Colors.red,
            onPressed: () {
              launch('mailto:test@example.org?subject=Support&body=${query.text}');
            },
          ).centered()
        ],
        alignment: MainAxisAlignment.center,
      ).p16(),
    );
  }
}
