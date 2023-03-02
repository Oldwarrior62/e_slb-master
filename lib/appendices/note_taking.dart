import 'package:flutter/material.dart';
import '../appendices/appendices_drawer.dart';

class NoteTaking extends StatelessWidget {
  const NoteTaking({Key? key}) : super(key: key);
  static const routeName = '/noteTaking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Taking'),
      ),
      drawer: AppendicesDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      'Note Taking',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'The importance and use of a notebook',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '\u2022  Your notebook contains the notes you compile during the course of your shift.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Your notebook is the bases and framework for all reports you generate.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Your notebook can be referred to in order to verify thet you completed the required tasks'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  If you lose your nootbook report it immediatly           '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  An officer\'s notes can serve as a general index to the officer\'s memory and may used when testifing.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  When taking a statement from a witness. It must be sogned, dated and has the name printed at the bigginning.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  When giving your notebook to a police officer or legal counsel for review, thst you have used elastic bands to hold closed pages not referencing the situatiion at hand.'),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rules of note taking',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      '\u2022  Notebooks are written in the first person (you can refer to your self as "I").'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Notebook pages are numbered: do not leave pages blank, or remove paes.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Official entrys only \u2022  e.g., no shopping lists.                          '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Record an entry each time you start or finish an activity, entries should be done every 20 minutes.                          '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Make your entries in point form and use simple launguage.                          '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Your notebook is a confidentail document.                          '),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Reports',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Every report must include the six basic elements of information',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Who - All parties involved (witnesses, police officers, etc.).'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  What - Details of the incident, including diagrams if possable. '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Where - Address, floor, location on property, etc'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  When - Time of incident, arrival of officials, etc.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Why - Facts only.                                                      '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  How - How did the details unfold/probable cause.'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Every report must be:',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Clear - Language & format must be simple. Do not use jargon, slang or inappropriate language.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Legible - Easy to read. Use a pen on clean report papers, print if your handwriting is not easily readable and ensure your spelling is accurate.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Complete - Contains all facts(name, dates, addresses, badge numbers, etc.).'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Accurate - All facts should be accurate. Do not assume or provide theories.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Brief - Simple and to the point. There is no need to use many descriptive words.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Promt - Reports should be completed before the end of the shift, Failure to do this could result in disciplanary action.'),
                  // SizedBox(
                  //   height: 2,
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Formal report writing rules:',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Write in chronological order, use exact times (do not round off the times).'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Reports are written in the third person (refer to yourself as "the writer").'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Always use the 24 hour clock.                                  '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Always use a four part date (Monday September 28 2023).'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Do not leave blank lines.                                            '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  All names including businesses must be written out in full.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Correct errors by striking out with a SINGLE LINE and initalling it.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  All names including businesses must be written out in full.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Fill in all required spaces in  a report.                    '),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '\u2022  Sign all reports when completed.                             '),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Incident report',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'An incident report will be completed if there is an issue outside the normal events at your client location. These reports will provide additional information that will highlight the nature of the inicident and the actions taken to return your site back to normal.'),
                  SizedBox(
                    height: 5,
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
