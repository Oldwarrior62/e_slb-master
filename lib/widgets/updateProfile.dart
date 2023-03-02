// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comm/genTextFormField.dart';

class UpdateProfile extends StatelessWidget {
  static const routeName = '/update_user';
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController securityLicense = TextEditingController();
  TextEditingController ofa = TextEditingController();
  XFile? img;

  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    final provider = context.watch<UserCubit>().state;
    firstname.text = provider.userModel!.name.toString();
    lastname.text = provider.userModel!.surname.toString();
    email.text = provider.userModel!.email.toString();
    password.text = provider.userModel!.password.toString();
    securityLicense.text = provider.userModel!.securityLicense ?? "";
    ofa.text = provider.userModel!.ofa ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      drawer: Drawer(
        child: MainDrawer(
          lstcompany: companyProvider.state.lstcompany ?? [],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Update
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () async {
                      img = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (img != null)
                        provider.userModel!.image = String.fromCharCodes(
                            File(img!.path).readAsBytesSync());
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99.0),
                          border: Border.all(color: Colors.black)),
                      child: provider.userModel == null
                          ? Icon(
                              Icons.person,
                              size: 50,
                            )
                          : CircleAvatar(
                              backgroundImage: MemoryImage(
                                Uint8List.fromList(
                                    provider.userModel!.image!.codeUnits),
                              ),
                            ),
                    ),
                  );
                }),
                getTextFormField(
                    controller: firstname,
                    icon: Icons.person_outline,
                    inputType: TextInputType.name,
                    hintName: 'First Name'),
                SizedBox(height: 10.0),
                getTextFormField(
                    controller: lastname,
                    icon: Icons.person_outline,
                    inputType: TextInputType.name,
                    hintName: 'Last Name'),
                SizedBox(height: 10.0),
                getTextFormField(
                    controller: email,
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    hintName: 'Email'),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: password,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: securityLicense,
                  icon: Icons.security,
                  hintName: 'Security License',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: ofa,
                  icon: Icons.document_scanner,
                  hintName: 'OFA',
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      DbHelper db = DbHelper.instance;
                      if (email.text.isNotEmpty &&
                          password.text.isNotEmpty &&
                          firstname.text.isNotEmpty &&
                          lastname.text.isNotEmpty) {
                        provider.userModel!.name = firstname.text;
                        provider.userModel!.surname = lastname.text;
                        provider.userModel!.email = email.text;
                        provider.userModel!.password = password.text;
                        provider.userModel!.securityLicense =
                            securityLicense.text;
                        provider.userModel!.ofa = ofa.text;
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();

                        db.updateUserData(provider.userModel!).then((value) {
                          sp.setString('securityLisence',
                              provider.userModel!.securityLicense.toString());
                          sp.setString(
                              'ofa', provider.userModel!.ofa.toString());
                          alertDialog(context, "User Updated");
                        });
                      }
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),

                //Delete

                Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
