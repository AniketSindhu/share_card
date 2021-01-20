import 'package:flutter/material.dart';
import 'package:share_card/model/optionsModel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: tr("options").toString().text.semiBold.size(20).white.make(),
        actions: [
          Icon(
            Icons.person,
            color: Vx.blue900,
            size: 30,
          ).p12(),
        ],
      ),
      body: ListView.builder(
          itemCount: optionList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: optionList[index].name.text.semiBold.size(18).make(),
                  leading: optionList[index].icon,
                  onTap: optionList[index].onTap,
                  trailing: Icon(
                    Icons.navigate_next,
                    size: 28,
                  ),
                ),
                Divider(
                  thickness: 0.8,
                  height: 0,
                )
              ],
            );
          }),
    );
  }
}
