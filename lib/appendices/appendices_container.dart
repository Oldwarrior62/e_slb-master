import 'package:flutter/material.dart';

class AppendicesContainer extends StatelessWidget {
  const AppendicesContainer({Key? key, required this.appendicesText})
      : super(key: key);
  final String appendicesText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1,
          ),
          right: BorderSide(
            width: 1,
          ),
          bottom: BorderSide(
            width: 1,
          ),
        ),
      ),
      child: Text(appendicesText),
    );
  }
}
