import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

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
      body: Column(
        children: [
          SvgPicture.asset(
            "assets/help.svg",
            height: (context.percentHeight * 45),
          ).centered(),
          40.heightBox,
          FlatButton(
            color:Colors.blue,
            child:'Contact us'.text.white.make(),
            onPressed: (){},
          ).centered(),
          10.heightBox,
          FlatButton(
            color:Colors.blue,
            child:'Privacy Policy'.text.white.make(),
            onPressed: (){
              Get.dialog(Dialog(
                child: VStack([
                  "Privacy Policy".text.extraBlack.extraBold.size(40).makeCentered(),
                  20.heightBox,
                  "Zomato Private Limited(Formerly known as Zomato Media Private Limited) and/or its affiliates (\"Zomato,\" the \"Company,\" \"we,\" \"us,\" and \"our,\") respect your privacy and is committed to protecting it through its compliance with its privacy policies. This policy describes:\nthe types of information that Zomato may collect from you when you access or use its websites, applications and other online services (collectively, referred as \"Services\") annits practices for collecting, using, maintaining, protecting and disclosing that information.\nThis policy applies only to the information Zomato collects through its Services, in email, text and other electronic communications sent through or in connection with its Services.\nThis policy DOES NOT apply to information that you provide to, or that is collected by, any third-party, such as restaurants at which you make reservations and/or pay through Zomato's Services and social networks that you use in connection with its Services. Zomato encourages you to consult directly with such third-parties about their privacy practices.\nPlease read this policy carefully to understand Zomato's policies and practices regarding your information and how Zomato will treat it. By accessing or using its Services and/or registering for an account with Zomato, you agree to this privacy policy and you are consenting to Zomato's collection, use, disclosure, retention, and protection of your personal information as described here. If you do not provide the information Zomato requires, Zomato may not be able to provide all of its Services to you.\nIf you reside in a country within the European Union/European Economic Area (EAA), Zomato Media Portugal, Unipessoal LDA , located at Avenida 24 de Julho, N 102-E, 1200-870, Lisboa, Portugal, will be the controller of your personal data provided to, or collected by or for, or processed in connection with our Services;\nIf you reside in United States of America, Zomato USA LLC, located at 7427 Matthews Mint Hill Rd., STE 105, #324, Mint Hill, NC 28227 will be the controller of your personal data provided to, or collected by or for, or processed in connection with our Services;".text.makeCentered()
                ]).py12().px16().scrollVertical(),
              ));
            },
          ).centered(),
          10.heightBox,
        ],mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}