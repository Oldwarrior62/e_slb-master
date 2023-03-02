import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/appendices/appendices_title.dart';
import '../appendices/appendices_drawer.dart';

class FireProvention extends StatelessWidget {
  const FireProvention({Key? key}) : super(key: key);
  static const routeName = '/fireProvention';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Provention'),
      ),
      drawer: AppendicesDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            AppendicesTitle(conversionTitle: 'Fire Protection'),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '4 classes of fire:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'A. Combustible solids (wood, cloth, rubber, paper,)',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'B. Flammable liquids (gasoline, oil, paint, propane,)',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'C. Electrical (wiring, electrical)',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'D. Flammable metals',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Types of fire extinguishers:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '1. Carbone Dioxide',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '2. Dry Chemical Powder',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '3. A.P.W. - All purpose water',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            AppendicesTitle(
              conversionTitle: 'Fire observations',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Time, date, location',
                    ),
                  ), //
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Owner, occupant, visitor present',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Witnesses - (Full names, addresses, age...)',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Security of the buildiding - Doord not locked - Windows left open',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Location of bodies - Condition - Clothed',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Who found bodies and exhibits?',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Fire department units responding - Time of arrival - Officer in charge',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\u2022 Indication of forced entry - Vandalism - Theft',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Other helpful observations:',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Marital problems, Drugs/Alcohol, Personal belongings lost, Pet Dead.',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Strange ordors - Gasoline/Chlorine, etc...'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Anything over windows blocking view of fire, Drafts of air, usual or unusual..',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
