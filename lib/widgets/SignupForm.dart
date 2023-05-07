// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userState.dart';
import 'package:flutter_complete_guide/widgets/signature.dart';
import 'package:image_picker/image_picker.dart';
import '../comm/commHelper.dart';
import '../DatabaseHandler/DbHelper.dart';
import '../comm/genTextFormField.dart';
import 'loginForm.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final _conUsersurname = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;
  XFile? img;

  @override
  void initState() {
    super.initState();
  }

  signUp() async {
    //look signup function?
    String name = _conUserName.text;
    String surname = _conUsersurname.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Password Mismatch');
      } else if (passwd.length != 4) {
        alertDialog(context, "Password must be 4 digit");
      } else if (img != null) {
        if (context.read<UserCubit>().state.userModel?.signature != null) {
          _formKey.currentState?.save();
          DbHelper db = DbHelper.instance;
          await db.database;

          context.read<UserCubit>().state.userModel?.name = name;
          context.read<UserCubit>().state.userModel?.surname = surname;
          context.read<UserCubit>().state.userModel?.email = email;
          context.read<UserCubit>().state.userModel?.password = passwd;
          context.read<UserCubit>().state.userModel?.image =
              String.fromCharCodes(File(img!.path).readAsBytesSync());
          context.read<UserCubit>().state.userModel?.isLogin = "true";
          db.saveData(context.read<UserCubit>().state.userModel!).then(
            (value) {
              if (value == -1) {
                alertDialog(context, "User already Exists");
              } else {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginForm()));
              }
            },
          );
        }
      } else {
        alertDialog(context, "Select Image");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Secure Log',
          style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      img = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99.0),
                          border: Border.all(color: Colors.black)),
                      child: img == null
                          ? Icon(
                              Icons.person,
                              size: 50,
                            )
                          : CircleAvatar(
                              backgroundImage: MemoryImage(
                                File(img!.path).readAsBytesSync(),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person,
                      hintName: 'Name'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conUsersurname,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'Surname'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: '4 Digit Password',
                    isObscureText: true,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                    inputType: TextInputType.number,
                  ),
                  BlocBuilder<UserCubit, UserState>(
                      builder: ((context, state) => Container(
                            margin: const EdgeInsets.all(30.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: TextButton(
                              onPressed: setSignature,
                              child: Text(
                                state.userModel?.signature == null
                                    ? 'Set Signature'
                                    : "Signature Saved",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        context.watch<UserCubit>().state.font),
                              ),
                            ),
                          ))),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 30.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextButton(
                      onPressed: signUp,
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: context.watch<UserCubit>().state.font),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Does you have account? ',
                          style: TextStyle(
                              fontFamily:
                                  context.watch<UserCubit>().state.font),
                        ),
                        TextButton(
                          child: Text(
                            'Sign In',
                            selectionColor: Colors.blue,
                            style: TextStyle(
                                fontFamily:
                                    context.watch<UserCubit>().state.font),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => LoginForm()));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  setSignature() {
    showModalBottomSheet(
        context: context,
        builder: ((context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Signature",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: context.watch<UserCubit>().state.font),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<UserCubit>().setSignatureType("Draw");
                    Navigator.pushNamed(context, SignatureScreen.routeName);
                  },
                  child: ListTile(
                    title: Text("Draw"),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    context.read<UserCubit>().setSignatureType("LeftCursive");
                    Navigator.pushNamed(context, SignatureScreen.routeName);
                  },
                  child: ListTile(
                    title: Text("Left Cursive"),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    context.read<UserCubit>().setSignatureType("RightCursive");
                    Navigator.pushNamed(context, SignatureScreen.routeName);
                  },
                  child: ListTile(
                    title: Text("Right Cursive"),
                  ),
                ),
                const Divider(),
              ],
            )));
  }
}
