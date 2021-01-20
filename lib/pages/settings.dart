import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'history.dart';
import 'help.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool val = true;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tr("settings").toString().text.white.make(),
        centerTitle: true,
      ),
      body: ListView(children: [
        ListTile(
          onTap: () {
            context.showToast(
                msg: tr('history_deleted').toString(),
                bgColor: Vx.green500,
                textColor: Colors.white,
                position: VxToastPosition.top,
                pdHorizontal: 20,
                showTime: 3500,
                pdVertical: 10);
          },
          title: tr("clear_history").toString().text.size(20).make(),
          leading: Icon(Icons.delete),
        ),
        Divider(),
        ListTile(
          title: tr("sounds").toString().text.size(20).make(),
          leading: Icon(Icons.surround_sound),
          trailing: Switch(
            value: val,
            onChanged: (result) {
              setState(() {
                val = result;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Get.to(History());
          },
          title: tr("history").toString().text.size(20).make(),
          leading: Icon(Icons.history),
        ),
        Divider(),
        ListTile(
          title: tr("language").toString().text.size(20).make(),
          leading: Icon(Icons.language),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: VxBox(
                        child: DropdownButtonFormField(
                      value: selected,
                      onChanged: (val) {
                        if (val == 0) {
                          EasyLocalization.of(context).locale =
                              Locale('en', 'US');
                        } else if (val == 1) {
                          EasyLocalization.of(context).locale =
                              Locale('zh', 'CN');
                        } else if (val == 2) {
                          EasyLocalization.of(context).locale =
                              Locale('ko', 'KR');
                        }
                        setState(() {
                          selected = val;
                        });
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Vx.gray700,
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Vx.gray700,
                            width: 1,
                          ),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: tr('English').toString().text.make(),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: tr('Chinese').toString().text.make(),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: tr('Korean').toString().text.make(),
                          value: 2,
                        ),
                      ],
                    )).make().centered().p12(),
                  ).h32(context);
                });
            // EasyLocalization.of(context).locale = Locale('zh', 'CN');
          },
        ),
        Divider(),
        ListTile(
          onTap: () {
            Get.dialog(ThemeConsumer(child: ThemeDialog()));
          },
          title: tr("theme").toString().text.size(20).make(),
          leading: Icon(Icons.theater_comedy),
        ),
        Divider(),
        ListTile(
            onTap: () {
              Get.to(Help());
            },
            title: tr("help").toString().text.size(20).make(),
            leading: Icon(Icons.help)),
        Divider(),
      ]),
    );
  }
}
