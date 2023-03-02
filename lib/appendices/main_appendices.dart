import 'package:flutter/material.dart';
import '../appendices/appendices_drawer.dart';
//import '../comm/genTextFormField.dart';

class AppendicesMain extends StatefulWidget {
  const AppendicesMain({Key? key}) : super(key: key);
  static const routeName = '/appendices';

  @override
  State<AppendicesMain> createState() => _AppendicesMainState();
}

class _AppendicesMainState extends State<AppendicesMain> {
  @override
  Widget build(BuildContext context) {
    // final _conUserName = TextEditingController();
    // final _conUserContact = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Appendices Main Page'),
      ),
      drawer: AppendicesDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Text(
                'Contact List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.person_2_outlined),
                  // getTextFormField(
                  //     controller: _conUserName,
                  //     icon: Icons.person,
                  //     hintName: 'Name'),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone),
                      Icon(Icons.email),
                    ],
                  ),
                  // getTextFormField(
                  //     controller: _conUserContact,
                  //     icon: Icons.person,
                  //     hintName: 'Contact'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
