import 'package:flutter/material.dart';

class TenCodes extends StatelessWidget {
  const TenCodes({Key? key, required this.tenCodes}) : super(key: key);
  final String tenCodes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(tenCodes),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                //  hintText: 'Enter your 10 Codes',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
