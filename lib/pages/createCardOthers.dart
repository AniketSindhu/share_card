import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/pages/selectTemplate.dart';
import 'package:share_card/pages/selectTemplateOthers.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateCardOthers extends StatefulWidget {
  @override
  _CreateCardOthersState createState() => _CreateCardOthersState();
}

class _CreateCardOthersState extends State<CreateCardOthers> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController industry = TextEditingController();
  String specialization;
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "add_info".tr().toString().text.semiBold.size(20).white.make(),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getSpecializations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator().centered();
            } else {
              return Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: VStack([
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: HStack(
                                [
                                  FlatButton(
                                      onPressed: () async {
                                        final pickedFile =
                                            await picker.getImage(
                                                source: ImageSource.camera);
                                        setState(() {
                                          if (pickedFile != null) {
                                            _image = File(pickedFile.path);
                                          } else {
                                            print('No image selected.');
                                          }
                                        });
                                      },
                                      child: "camera"
                                          .tr()
                                          .toString()
                                          .text
                                          .white
                                          .semiBold
                                          .size(16)
                                          .make(),
                                      color: Colors.blue),
                                  10.widthBox,
                                  FlatButton(
                                      onPressed: () async {
                                        final pickedFile =
                                            await picker.getImage(
                                                source: ImageSource.gallery);
                                        setState(() {
                                          if (pickedFile != null) {
                                            _image = File(pickedFile.path);
                                          } else {
                                            print('No image selected.');
                                          }
                                        });
                                      },
                                      child: "gallery"
                                          .tr()
                                          .toString()
                                          .text
                                          .white
                                          .semiBold
                                          .size(16)
                                          .make(),
                                      color: Colors.blue),
                                ],
                                alignment: MainAxisAlignment.center,
                              ),
                            );
                          });
                    },
                    child: _image == null
                        ? CircleAvatar(
                            child:
                                Icon(Icons.person, color: Vx.blue700, size: 50),
                            radius: 50,
                            backgroundColor: Vx.blue200,
                          ).centered()
                        : Image.file(_image,
                                fit: BoxFit.cover,
                                width: context.percentWidth * 50)
                            .centered(),
                  ),
                  20.heightBox,
                  TextFormField(
                      controller: firstNameController,
                      validator: (v) => v.trim().length <= 0
                          ? "valid_name".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "first_name".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: secondNameController,
                      validator: (v) => v.trim().length <= 0
                          ? "valid_name".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "last_name".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: emailController,
                      validator: (value) {
                        {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'valid_email'.tr().toString();
                          else
                            return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "email".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: companyNameController,
                      validator: (v) => v.trim().length < 2
                          ? "valid_name".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "company_name".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: phoneNumberController,
                      validator: (v) => v.trim().length < 2
                          ? "valid_phone".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "phone".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: webController,
                      validator: (v) => v.trim().length < 2
                          ? "valid_website".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "website".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: positionController,
                      validator: (v) =>
                          v.trim().length < 1 ? " Enter valid position" : null,
                      decoration: InputDecoration(
                        hintText: "position".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  DropdownButtonFormField(
                          hint: 'specialization'.tr().toString().text.make(),
                          onChanged: (val) {
                            setState(() {
                              specialization = val;
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
                          items: snapshot.data.map<DropdownMenuItem>((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList())
                      .h(60),
                  15.heightBox,
                  TextFormField(
                      controller: industry,
                      validator: (v) => v.trim().length < 1
                          ? "valid_industry".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "industry".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  "company_address"
                      .tr()
                      .toString()
                      .text
                      .size(20)
                      .semiBold
                      .make(),
                  5.heightBox,
                  TextFormField(
                      controller: address1Controller,
                      validator: (v) => v.trim().length < 2
                          ? "valid_address".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "address1".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: address2Controller,
                      validator: (v) => v.trim().length < 2
                          ? "valid_address".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "address2".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      controller: country,
                      validator: (v) => v.trim().length < 1
                          ? "valid_country".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "country".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  10.heightBox,
                  TextFormField(
                      keyboardType: TextInputType.number,
                      controller: postalCode,
                      validator: (v) => v.trim().length < 2
                          ? "valid_postcode".tr().toString()
                          : null,
                      decoration: InputDecoration(
                        hintText: "postcode".tr().toString(),
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
                      )).w(double.infinity).h(60),
                  15.heightBox,
                  FlatButton(
                    onPressed: () async {
                      final close =
                          context.showLoading(msg: 'loading'.tr().toString());
                      Future.delayed(Duration(seconds: 3), close);
                      await createCardOtherfunc(
                          firstNameController.text,
                          secondNameController.text,
                          emailController.text,
                          companyNameController.text,
                          webController.text,
                          positionController.text,
                          specialization,
                          _image,
                          phoneNumberController.text,
                          industry.text,
                          address1Controller.text,
                          address2Controller.text,
                          postalCode.text,
                          country.text);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectTemplateOther(
                                    phone: phoneNumberController.text,
                                  )));
                    },
                    child: "save_info"
                        .tr()
                        .toString()
                        .text
                        .size(22)
                        .semiBold
                        .white
                        .make()
                        .py12(),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                  ).w(double.infinity),
                ]).p20().scrollVertical(),
              );
            }
          }),
    );
  }
}
