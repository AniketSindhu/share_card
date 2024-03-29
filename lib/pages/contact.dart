import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController query = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tr('contact').toString().text.white.make(),
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
                helperText: tr('tell_query').toString(),
                labelText: tr('query').toString()),
            controller: query,
          ),
          10.heightBox,
          FlatButton(
            child: tr('send_query').toString().text.white.make(),
            color: Colors.red,
            onPressed: () {
              launch(
                  'mailto:test@example.org?subject=Support&body=${query.text}');
            },
          ).centered()
        ],
        alignment: MainAxisAlignment.center,
      ).p16(),
    );
  }
}
