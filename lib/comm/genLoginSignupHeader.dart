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
          // SizedBox(height: 2.0),
          Image.asset(
            'lib/images/logo-transparent-png.png',
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
