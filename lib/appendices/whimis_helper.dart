import 'package:flutter/material.dart';

class WhimisHelper extends StatelessWidget {
  const WhimisHelper({
    Key? key,
    required this.whimisSymble,
    required this.whimisClass,
  }) : super(key: key);
  final String whimisSymble;
  final String whimisClass;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.15,
          child: Image.asset(
            whimisSymble,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          alignment: Alignment.topLeft,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              whimisClass,
            ),
          ),
        ),
      ],
    );
  }
}
