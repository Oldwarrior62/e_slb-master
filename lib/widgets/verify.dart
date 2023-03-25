import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/comm/genTextFormField.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:flutter_complete_guide/widgets/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);
  static const routeName = '/verify';

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController _email = TextEditingController();
  UserModel? user;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var userData = sp.getString("userData");
    user = UserModel.fromMap(jsonDecode(userData!));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Email",
        style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
      )),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          getTextFormField(
            controller: _email,
            icon: Icons.email,
            hintName: 'Enter Email',
            isObscureText: false,
            inputType: TextInputType.text,
          ),
          Container(
            margin: EdgeInsets.all(30.0),
            width: double.infinity,
            child: TextButton(
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_email.text.isNotEmpty) {
                  if (user!.email != _email.text) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Invalid Email")));
                  } else {
                    Navigator.pushNamed(
                        context, ChangePasswordScreen.routeName);
                  }
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Email Required")));
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
