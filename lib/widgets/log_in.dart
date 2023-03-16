import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';

import '../widgets/main_log_entry.dart';
import 'user_form.dart';

class LogIn extends StatelessWidget {
  void selectMainLogEntry(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(MainLogEntry.routeName);
  }

  // void selectNewUser(BuildContext ctx) {
  //   Navigator.of(ctx).pushReplacementNamed(User.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure Log in'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'lib/images/logo.png',
            width: mediaQuery.size.width * .7,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 20,
              child: GestureDetector(
                onTap: () => selectMainLogEntry(context),
                child: Container(
                  child: Text(
                    'Log in',
                    style: TextStyle(
                        fontFamily: context.watch<UserCubit>().state.font),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(UserForm.routeName),
            child: Container(
              child: Text('Create New User'),
            ),
          ),
        ],
      ),
    );
  }
}
