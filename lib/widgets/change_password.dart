// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/comm/genTextFormField.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:flutter_complete_guide/widgets/loginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bloc/User/userCubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/chnageoassword';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _password = TextEditingController();
  UserModel? userModel;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var userData = sp.getString("userData");
    userModel = UserModel.fromMap(jsonDecode(userData!));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Change Password",
        style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
      )),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          getTextFormField(
            controller: _password,
            icon: Icons.lock,
            hintName: 'Enter Password',
            isObscureText: true,
            inputType: TextInputType.number,
          ),
          Container(
            margin: EdgeInsets.all(30.0),
            width: double.infinity,
            child: TextButton(
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_password.text.isNotEmpty) {
                  if (userModel!.password == _password.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "New Password is different from Old Password")));
                  } else if (_password.text.length != 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password Must be 4 digits")));
                  } else {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    userModel!.password = _password.text;
                    await sp.setString(
                        "userData", jsonEncode(userModel!.toMap()));
                    DbHelper db = DbHelper.instance;
                    await db.updateUserData(userModel!);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Password Changed Successfully")));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginForm()),
                        (Route<dynamic> route) => false);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password Required")));
                }
              },
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }
}
