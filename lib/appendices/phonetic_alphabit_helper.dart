import 'package:flutter/material.dart';

class PhoneticAlphabetHelper extends StatelessWidget {
  const PhoneticAlphabetHelper({
    Key? key,
    required this.phoneticAlphabet,
    required this.phoneticSound,
    required this.phoneticAlphabetTwo,
    required this.phoneticSoundTwo,
  }) : super(key: key);
  final String phoneticAlphabet;
  final String phoneticSound;
  final String phoneticAlphabetTwo;
  final String phoneticSoundTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1),
              left: BorderSide(
                width: 1,
              ),
              // bottom: BorderSide(
              //   width: 1,
              // ),
            ),
          ),
          child: Text(
            phoneticAlphabet,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1),
              left: BorderSide(
                width: 1,
              ),
              // bottom: BorderSide(
              //   width: 1,
              // ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              phoneticSound,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1),
              left: BorderSide(
                width: 1,
              ),
              // bottom: BorderSide(
              //   width: 1,
              // ),
            ),
          ),
          child: Text(
            phoneticAlphabetTwo,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1),
              left: BorderSide(
                width: 1,
              ),
              right: BorderSide(
                width: 1,
              ),
              // bottom: BorderSide(
              //   width: 1,
              // ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              phoneticSoundTwo,
            ),
          ),
        ),
      ],
    );
  }
}
