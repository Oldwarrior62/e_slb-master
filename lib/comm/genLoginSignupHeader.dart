import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          SvgPicture.asset(
            'lib/images/logo-svg.svg',
            height: 150.0,
            width: 150.0,
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
