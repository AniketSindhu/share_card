import 'package:flutter/material.dart';
import 'package:share_card/model/cardModel.dart';
import 'package:velocity_x/velocity_x.dart';



card(CardModel cardModel, BuildContext context){

  if(cardModel.cardNumber==1){
    return VxBox().red300.width(context.percentWidth*95).height(300).shadowLg.rounded.makeCentered();
  }

  if(cardModel.cardNumber==2){
    return VxBox().purple300.width(context.percentWidth*95).height(300).shadowLg.rounded.makeCentered();
  }

  if(cardModel.cardNumber==3){
    return VxBox().blue300.width(context.percentWidth*95).height(300).shadowLg.rounded.makeCentered();
  }

  if(cardModel.cardNumber==4){
    return VxBox().green300.width(context.percentWidth*95).height(300).shadowLg.rounded.makeCentered();
  }

  if(cardModel.cardNumber==5){
    return VxBox().pink300.width(context.percentWidth*95).height(300).shadowLg.rounded.makeCentered();
  }

}
