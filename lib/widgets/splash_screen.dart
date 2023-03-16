import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:flutter_complete_guide/widgets/loginForm.dart';
import 'package:flutter_complete_guide/widgets/main_log_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getAuth();
    super.initState();
  }

  getAuth() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? data = sp.getString("userData");
    UserModel? userData;
    if (data != null && data != "") {
      userData = UserModel.fromMap(jsonDecode(data));
      BlocProvider.of<UserCubit>(context).setUser(userData);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MainLogEntry()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginForm()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset(
            'lib/images/logo.png',
          ),
        ),
      ),
    );
  }
}
