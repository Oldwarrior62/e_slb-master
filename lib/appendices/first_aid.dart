import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/appendices/appendices_title.dart';
import '../appendices/appendices_drawer.dart';

class FirstAid extends StatelessWidget {
  const FirstAid({Key? key}) : super(key: key);
  static const routeName = '/firstAid';

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width * 8;
    return Scaffold(
      appBar: AppBar(
        title: Text('First Aid'),
      ),
      drawer: AppendicesDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppendicesTitle(
                  conversionTitle: 'First Aid',
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    child: Text(
                      'Choking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If a choking person can speak, breath or cough: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '\n\u2022 Stand by - Do not interfer. \n',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If a choking person can\'t speak, breath or cough: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\n\u2022 Obtain permission to help (adult). \n\u2022 Give five back blows followed by five abdominal \nthrusts. \n\u2022 Repeat until obstruction removed or person \ngoes unconscious.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If a person goes unconscious: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '\n\u2022 Call 9-1-1.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\u2022 Begin CPR start with thirty compressions. Each time you give the first ventilation check the mouth for the object that caused the obstrution.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    child: Text(
                      'CPR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    child: Text(
                      'Warning: Only people who did an appropriate \ntraining are allowed to do CPR.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Check for unresponsiveness: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '\n\u2022 Shake and shout. \n\n\u2022 Call for help.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Open airway: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '\n\u2022Head tilt / Chin lift. \n\n\u2022 Check for normal breathing for at least five \nseconds and no more than 10 seconds.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If not breathing, begin CPR: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\n\u2022 Give 30 hard and fast compressions, 2 breaths for all ages.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If no pulse and no breathing, continue CPR: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\n\u2022 Check pulse / breathing every few minutes.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      ' Continue intil help arrives.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    child: Text(
                      'Choking - Infant',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If infant is struggling to breathe or is making high pitched noises: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\u2022 Place infant over one arm of your arms \n\u2022 Using force, use a combination of 5 back blows between the shoulder blades \n\u2022 Then turn the infant over and place two fingers in the middle af the breastbone, just below the nipple line and give 5 chest thrusts \n\u2022 Repeat untill the obstruction is expelled.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If infant becomes unconcious: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\u2022 Call for help. \n\u2022 Begin the first ventilation check the mouth for the object that caused the obstruction.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    child: Text(
                      'Choking - Child or Adult',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If a choking person can speak, breathe or cough: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\u2022 Stand by - Do not interfere.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If a choking person cannot speak, breathe or cough: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\u2022 Obtain permission to help. \n\u2022 Give five blows followed by 5 abdominal thrusts',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If the person becomes unconscious: ',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      '\u2022 Ease them to the ground and check for responsiveness (shake and shout). \n\u2022 Call for help. \n\u2022 Begin CPR, Each time you five the first ventilation check the mouth for an abstruction.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    child: Text(
                      'CPR - Infant',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\u2022 Give 30 compressions using 2 fingers pressing down firmly in the middle of the breat bone \n\u2022 Give 2 breaths placing your mouth over the infants mouth and nose.',
                  // textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    child: Text(
                      'CPR - Adult or Child',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\u2022 Interlock your hands. \n\u2022 Place in the center of the chest with your shoulders directly over your hands. \n\u2022 Give 30 compressions. \n\u2022 Give 2 breaths (Open the mouth, pinch the nose closed, create a seal with your mouth and give 2 breaths).',
                  // textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      'Continue the 30 compression and 2 breaths untill help arrives.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
