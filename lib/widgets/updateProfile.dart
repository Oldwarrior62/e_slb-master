// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:flutter_complete_guide/models/user_model.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  List<String> ofalevels = ['OFA1', 'OFA2', 'OFA3'];
  List<DropdownMenuItem<String>> get getItems => ofalevels
      .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
      .toList();
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
    String ofaExpiryDate = provider.userModel!.ofaExpiryDate ?? '';
    String securityLicenseExpiryDate =
        provider.userModel!.securityLicenseExpiryDate ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
        ),
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
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 30),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            labelText: "Select OFA Level"),
                        isExpanded: true,
                        items: getItems,
                        onChanged: (value) {
                          UserModel userModel =
                              context.read<UserCubit>().state.userModel!;
                          userModel.ofaLevel = value;
                          context.read<UserCubit>().setUser(userModel);
                        },
                        value: context
                            .watch<UserCubit>()
                            .state
                            .userModel!
                            .ofaLevel,
                      ),
                    ),
                  );
                }),

                SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now().add(Duration(days: 3600)),
                        onChanged: (date) {}, onConfirm: (date) {
                      ofaExpiryDate = date.toString().split(' ')[0];
                      provider.userModel!.ofaExpiryDate = ofaExpiryDate;
                      context
                          .read<UserCubit>()
                          .isUpdate(!context.read<UserCubit>().state.isUpdate!);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: OfaExpiry(context),
                ),
                SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now().add(Duration(days: 3600)),
                        onChanged: (date) {}, onConfirm: (date) {
                      securityLicenseExpiryDate = date.toString().split(' ')[0];
                      provider.userModel!.securityLicenseExpiryDate =
                          securityLicenseExpiryDate;
                      context
                          .read<UserCubit>()
                          .isUpdate(!context.read<UserCubit>().state.isUpdate!);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: SecurityExpiry(),
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
                      if (password.text.isNotEmpty &&
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
                          context.read<UserCubit>().setWarning(true);
                          sp.setString("userData",
                              jsonEncode(provider.userModel!.toMap()));
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
                Builder(builder: (context) {
                  return SwitchListTile(
                    title: Text(
                      'Dyslexic',
                      style: TextStyle(
                          fontFamily: context.watch<UserCubit>().state.font),
                    ),
                    subtitle: Text(
                      "May help in reading",
                      style: TextStyle(
                          fontFamily: context.watch<UserCubit>().state.font),
                    ),
                    onChanged: (bool value) {
                      context.read<UserCubit>().setIsDyslexic(value);
                    },
                    value: context.watch<UserCubit>().state.isDyslexic,
                  );
                }),
                //Delete
              ],
            ),
          ),
        ),
      ),
    );
  }

  Builder SecurityExpiry() {
    return Builder(builder: (context) {
      return Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0)),
          child: Center(
            child: Text(
              context.watch<UserCubit>().state.isUpdate!
                  ? context
                              .read<UserCubit>()
                              .state
                              .userModel!
                              .securityLicenseExpiryDate ==
                          null
                      ? 'Select Date Of License Expiry'
                      : context
                          .read<UserCubit>()
                          .state
                          .userModel!
                          .securityLicenseExpiryDate
                          .toString()
                  : context
                              .read<UserCubit>()
                              .state
                              .userModel!
                              .securityLicenseExpiryDate ==
                          null
                      ? 'Select Date Of License Expiry'
                      : context
                          .read<UserCubit>()
                          .state
                          .userModel!
                          .securityLicenseExpiryDate
                          .toString(),
              style: TextStyle(color: Colors.blue),
            ),
          ));
    });
  }

  Builder OfaExpiry(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0)),
          child: Center(
            child: Text(
              context.watch<UserCubit>().state.isUpdate!
                  ? context.read<UserCubit>().state.userModel!.ofaExpiryDate ==
                          null
                      ? 'Select Date Of OFA Expiry'
                      : context
                          .read<UserCubit>()
                          .state
                          .userModel!
                          .ofaExpiryDate
                          .toString()
                  : context.read<UserCubit>().state.userModel!.ofaExpiryDate ==
                          null
                      ? 'Select Date Of OFA Expiry'
                      : context
                          .read<UserCubit>()
                          .state
                          .userModel!
                          .ofaExpiryDate
                          .toString(),
              style: TextStyle(color: Colors.blue),
            ),
          ));
    });
  }
}
