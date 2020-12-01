import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool val=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Settngs".text.white.make(),
        centerTitle: true,
      ),
      body: ListView(
        children:[
          ListTile(
            onTap: (){
              context.showToast(
                  msg: 'History deleted',
                  bgColor: Vx.green500,
                  textColor: Colors.white,
                  position: VxToastPosition.top,
                  pdHorizontal: 20,
                  showTime: 3500,
                  pdVertical: 10);
            },
            title:"Clear history".text.size(20).make(),
            leading: Icon(Icons.delete),
          ),
          Divider(),
          ListTile(
            title:"Sounds".text.size(20).make(),
            leading: Icon(Icons.surround_sound),
            trailing: Switch(
              value:val,
              onChanged: (result){
                setState(() {
                  val=result;
                });
              },
            ),
          ),
          Divider(),
        ]
      ),
    );
  }
}