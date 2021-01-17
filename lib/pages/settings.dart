import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'history.dart';
import 'help.dart';
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
          ListTile(
            onTap: (){
              Get.to(History());
            },
            title:"History".text.size(20).make(),
            leading: Icon(Icons.history),
          ),
          Divider(),
          ListTile(
            title:"Language".text.size(20).make(),
            leading: Icon(Icons.language),
            onTap: (){
/*               showDialog(context: context,builder: (context){
                return Dialog(
                  
                );
              }); */
              EasyLocalization.of(context).locale = Locale('zh','CN');
            },
          ),
          Divider(),
          ListTile(
            onTap: (){
              Get.dialog(ThemeConsumer(child: ThemeDialog()));
            },
            title:"Theme".text.size(20).make(),
            leading: Icon(Icons.theater_comedy),
          ),
          Divider(),   
          ListTile(
            onTap: (){
              Get.to(Help());
            },
            title:"Help".text.size(20).make(),
            leading: Icon(Icons.help)
          ),
          Divider(),     
        ]
      ),
    );
  }
}