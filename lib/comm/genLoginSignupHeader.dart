import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';

class genLoginSignupHeader extends StatelessWidget {
  final String headerName;

  genLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Text(
            headerName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 40.0,
                fontFamily: context.watch<UserCubit>().state.font),
          ),
          SizedBox(height: 10.0),
          Image.asset(
            'lib/images/logo.png',
            height: 50.0,
            width: 150.0,
          ),
          SizedBox(height: 10.0),
          Text(
            'Observe and report',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25.0,
                fontFamily: context.watch<UserCubit>().state.font),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
