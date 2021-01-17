import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_card/methods/firebase.dart';
import 'package:share_card/model/UserModel.dart';
import 'package:share_card/pages/selectTemplate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';

class CreateCard extends StatefulWidget {
  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController industry = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  String specialization;
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue500,
        leadingWidth: 10,
        title: "Add info".text.semiBold.size(20).white.make(),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getSpecializations(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator().centered();
          }
          else{
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
                                      final pickedFile = await picker.getImage(
                                          source: ImageSource.camera);
                                      setState(() {
                                        if (pickedFile != null) {
                                          _image = File(pickedFile.path);
                                        } else {
                                          print('No image selected.');
                                        }
                                      });
                                    },
                                    child:
                                        "Camera".text.white.semiBold.size(16).make(),
                                    color: Colors.blue),
                                10.widthBox,
                                FlatButton(
                                    onPressed: () async {
                                      final pickedFile = await picker.getImage(
                                          source: ImageSource.gallery);
                                      setState(() {
                                        if (pickedFile != null) {
                                          _image = File(pickedFile.path);
                                        } else {
                                          print('No image selected.');
                                        }
                                      });
                                    },
                                    child:
                                        "Gallery".text.white.semiBold.size(16).make(),
                                    color: Colors.blue),
                              ],
                              alignment: MainAxisAlignment.center,
                            ),
                          );
                        });
                  },
                  child: _image == null
                      ? CircleAvatar(
                          child: Icon(Icons.person, color: Vx.blue700, size: 50),
                          radius: 50,
                          backgroundColor: Vx.blue200,
                        ).centered()
                      : Image.file(_image,
                              fit: BoxFit.cover, width: context.percentWidth * 50)
                          .centered(),
                ),
                20.heightBox,
                TextFormField(
                    controller: firstNameController,
                    validator: (v) =>
                        v.trim().length <=0 ? " Enter valid name" : null,
                    decoration: InputDecoration(
                      hintText: "First Name*",
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
                    validator: (v) =>
                        v.trim().length <=0 ? " Enter valid name" : null,
                    decoration: InputDecoration(
                      hintText: "Last Name*",
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
                          return 'Enter Valid Email';
                        else
                          return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Email*",
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
                    validator: (v) =>
                        v.trim().length < 2 ? " Enter valid name" : null,
                    decoration: InputDecoration(
                      hintText: "Company name*",
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
                    decoration: InputDecoration(
                      hintText: "Website",
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
                    decoration: InputDecoration(
                      hintText: "Position",
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
                    controller: industry,
                    validator: (v) =>
                        v.trim().length < 1 ? " Enter valid industry" : null,
                    decoration: InputDecoration(
                      hintText: "Industry*",
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
                  hint: "Specialization".text.make(),
                  value: specialization,
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
                  items: snapshot.data.map<DropdownMenuItem<String>>((val){
                    return new DropdownMenuItem<String>(
                      value: val,
                      child: new Text(val),
                    );
                  }).toList()).h(60),
                10.heightBox,
                "Company Address".text.size(20).semiBold.make(),
                5.heightBox,
                TextFormField(
                    controller: address1Controller,
                    validator: (v) =>
                        v.trim().length < 2 ? " Enter valid address" : null,
                    decoration: InputDecoration(
                      hintText: "Address1 *",
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
                    validator: (v) =>
                        v.trim().length < 2 ? " Enter valid address" : null,
                    decoration: InputDecoration(
                      hintText: "Address2 *",
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
                    validator: (v) =>
                        v.trim().length < 1 ? " Enter valid country" : null,
                    decoration: InputDecoration(
                      hintText: "Country*",
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
                    validator: (v) =>
                        v.trim().length < 2 ? " Enter valid postalCode" : null,
                    decoration: InputDecoration(
                      hintText: "PostCode *",
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
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                        final close = context.showLoading(msg: 'Loading');
                        Future.delayed(Duration(seconds: 3), close);
                        await createCard(
                            firstNameController.text,
                            secondNameController.text,
                            emailController.text,
                            companyNameController.text,
                            address1Controller.text,
                            address2Controller.text,
                            country.text,
                            postalCode.text,
                            industry.text,
                            webController.text,
                            positionController.text,
                            specialization,
                            _image);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectTemplate()));
                    }
                  },
                  child: "Save info".text.size(22).semiBold.white.make().py12(),
                  color: Colors.blue,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                ).w(double.infinity),
              ]).p20().scrollVertical(),
            );
          }
        }
      ),
    );
  }
}
