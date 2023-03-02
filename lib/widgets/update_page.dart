//So user can update what is for now header information
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdatePage extends StatefulWidget {
  static const routeName = '/update_user';

  @override
  State<UpdatePage> createState() => _NewUserState();
}

class _NewUserState extends State<UpdatePage> {
  final locationController = TextEditingController();
  final weatherController = TextEditingController();
  final companyNameController = TextEditingController();
  final logoUrlController = TextEditingController();

  bool _validate = false;
  var location;
  var weather;
  var companyName;
  var logoUrl;
  String date = DateFormat.yMMMMd().format(DateTime.now());

  // void selectUpdate(BuildContext ctx) {

  // }

  void _NewWeather(BuildContext ctx) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: TextStyle(
                  fontSize: 10 * curScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter weather',
                  errorText: _validate ? 'Weather Can\'t Be Empty' : null,
                ),
                controller: weatherController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Add weather',
                    style: TextStyle(
                      fontSize: 10 * curScaleFactor,
                    ),
                  ),
                  // textColor: Colors.purple,
                  onPressed: () {
                    setState(
                      () {
                        weatherController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        weather = weatherController.text;
                      },
                    );
                    // clearText();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _NewLogoUrl(BuildContext ctx) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: TextStyle(
                  fontSize: 10 * curScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter logo url',
                  errorText: _validate ? 'Logo url Can\'t Be Empty' : null,
                ),
                controller: logoUrlController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Add logo url',
                    style: TextStyle(
                      fontSize: 10 * curScaleFactor,
                    ),
                  ),
                  // textColor: Colors.purple,
                  onPressed: () {
                    setState(
                      () {
                        logoUrlController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        logoUrl = logoUrlController.text;
                      },
                    );
                    // clearText();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _NewCompany(BuildContext ctx) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: TextStyle(
                  fontSize: 10 * curScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter company name',
                  errorText: _validate ? 'Company namer Can\'t Be Empty' : null,
                ),
                controller: companyNameController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Add company name',
                    style: TextStyle(
                      fontSize: 10 * curScaleFactor,
                    ),
                  ),
                  // textColor: Colors.purple,
                  onPressed: () {
                    setState(
                      () {
                        companyNameController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        companyName = companyNameController.text;
                      },
                    );
                    // clearText();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _newLocation(BuildContext ctx) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: TextStyle(
                  fontSize: 10 * curScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter Location',
                  errorText: _validate ? 'Location Can\'t Be Empty' : null,
                ),
                controller: locationController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    child: Text(
                      'Add location',
                      style: TextStyle(
                        fontSize: 10 * curScaleFactor,
                      ),
                    ),
                    // textColor: Colors.purple,
                    onPressed: () {
                      setState(
                        () {
                          locationController.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          location = locationController.text;
                        },
                      );
                      //clearText();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text('E-SLB New user'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'CompanyName: ${companyName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14 * curScaleFactor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _NewCompany(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text('update company name'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'location: ${location}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14 * curScaleFactor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _newLocation(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Text('update location'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'logoUrl: ${logoUrl}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14 * curScaleFactor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _NewLogoUrl(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text('update logo url'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            // display for current year month day is submitted
                            Text(
                              date,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12 * curScaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child:
                                    //display weather bottom left of header_info
                                    //currently hard coded in
                                    Text(
                                  'Weather: ${weather}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _NewWeather(context),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text('update weather'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 50,
                      // ),
                      // TextButton(
                      //   child: const Text('Submit'),
                      //   onPressed: () {
                      //      selectUpdate(context);
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 50,
                      // ),
                      // TextButton(
                      //     child: Text('update'),
                      //     onPressed: () {
                      //       selectUpdate(context);
                      //     }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
