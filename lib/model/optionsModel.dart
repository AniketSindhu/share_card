import 'package:flutter/material.dart';

class OptionsModel{
  final Icon icon;
  final String name;
  final Function onTap;
  OptionsModel({this.icon,this.name,this.onTap}); 
}

List<OptionsModel> optionList=[
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Add Credit",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Add On",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Profile",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Premium Member",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Theme",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"History",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Select Language",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Rate us",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Help",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Share",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Settings",onTap: (){}),
  OptionsModel(icon:Icon(Icons.settings,color:Colors.blue[700],size:30),name:"Signature",onTap: (){}),
];