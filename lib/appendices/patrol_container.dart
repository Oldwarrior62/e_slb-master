import 'package:flutter/material.dart';

class PatrolContainer extends StatelessWidget {
  const PatrolContainer({
    Key? key,
    required this.patrolText,
    required this.patrolTextA,
  }) : super(key: key);
  final String patrolText;
  final String patrolTextA;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(patrolText),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(patrolTextA),
        ),
      ],
    );
  }
}
