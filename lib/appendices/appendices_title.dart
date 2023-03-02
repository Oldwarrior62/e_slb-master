import 'package:flutter/material.dart';

class AppendicesTitle extends StatelessWidget {
  const AppendicesTitle({Key? key, required this.conversionTitle})
      : super(key: key);
  final String conversionTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border.all(
            width: 2,
          ),
        ),
        child: Text(
          conversionTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
