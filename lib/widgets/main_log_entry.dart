import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/comm/genTextFormField.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DatabaseHandler/DbHelper.dart';
import 'getLocation.dart';
import 'log_info_list.dart';
import 'new_log_entry.dart';
import 'header_info.dart';

class MainLogEntry extends StatefulWidget {
  static const routeName = '/main_log_entry';

  @override
  State<MainLogEntry> createState() => _MainLogEntryState();
}

class _MainLogEntryState extends State<MainLogEntry> {
  bool isloading = true;
  CompanyCubit? companyProvider;
  TextEditingController locationController = TextEditingController();
  TextEditingController weatherController = TextEditingController();
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    DbHelper db = DbHelper.instance;
    UserModel? userData = context.read<UserCubit>().state.userModel;
    context.read<DailyReportsCubit>().state.lstdailyreports =
        await db.getDailyReports();
    context.read<DailyReportsCubit>().state.tempdailyreports =
        await db.getDailyReports();
    if (userData != null) {
      db.checkNotes().then((value) {
        if (value != null) {
          if (value.notes != null) {
            value.ontap = true;
            BlocProvider.of<DailyReportsCubit>(context).setDailyReports(value);
          } else {
            BlocProvider.of<DailyReportsCubit>(context).setDailyReports(value);
          }
        }
      });
      String? id = sp.getString('userid');
      bool? warn = sp.getBool('warn');
      String? warntwoweeksecurity = sp.getString('warntwoweeksecurity');
      String? warntwoweekofa = sp.getString('warntwoweekofa');
      if (warn != null) {
        BlocProvider.of<UserCubit>(context).setWarning(true);
      }
      if (id == null) {
        sp.setString("userid", userData.userId.toString());
        sp.setString('securityLisence', '');
        sp.setString('ofa', '');
      } else {
        userData.securityLicense = sp.getString('securityLisence');
        userData.ofa = sp.getString("ofa");
        if (warn == true) {
          if (userData.securityLicenseExpiryDate != null) {
            DateTime securityLicenseExpiryDate = DateTime.parse(
                "${userData.securityLicenseExpiryDate} 00:00:00");

            if (securityLicenseExpiryDate
                    .compareTo(DateTime.now().add(Duration(days: 90))) <
                0) {
              BlocProvider.of<UserCubit>(context).setSecurityWarning(true);
            }
          }

          if (userData.ofaExpiryDate != null) {
            DateTime ofaExpiryDate =
                DateTime.parse("${userData.ofaExpiryDate} 00:00:00");

            if (ofaExpiryDate
                    .compareTo(DateTime.now().add(Duration(days: 90))) <
                0) {
              BlocProvider.of<UserCubit>(context).setOfaWarning(true);
            }
          }
        } else if (warntwoweeksecurity != null && warntwoweeksecurity != "") {
          DateTime warnDate = DateTime.parse("${warntwoweeksecurity} 00:00:00");
          if (DateTime.now().compareTo(warnDate.add(Duration(days: 14))) > 0) {
            if (userData.securityLicenseExpiryDate != null) {
              DateTime securityLicenseExpiryDate = DateTime.parse(
                  "${userData.securityLicenseExpiryDate} 00:00:00");

              if (securityLicenseExpiryDate
                      .compareTo(DateTime.now().add(Duration(days: 90))) <
                  0) {
                BlocProvider.of<UserCubit>(context).setSecurityWarning(true);
              }
            }
          }
        }
        if (warntwoweekofa != null && warntwoweekofa != "") {
          DateTime warnDate = DateTime.parse("${warntwoweekofa} 00:00:00");
          if (DateTime.now().compareTo(warnDate.add(Duration(days: 14))) > 0) {
            if (userData.ofaExpiryDate != null) {
              DateTime ofaExpiryDate =
                  DateTime.parse("${userData.ofaExpiryDate} 00:00:00");

              if (ofaExpiryDate
                      .compareTo(DateTime.now().add(Duration(days: 90))) <
                  0) {
                BlocProvider.of<UserCubit>(context).setOfaWarning(true);
              }
            }
          }
        }
      }
    }

    companyProvider = BlocProvider.of<CompanyCubit>(context);

    await db.getAllCompany().then((value) {
      companyProvider!.setlstCompany(value);
      if (companyProvider!.state.lstcompany!.length > 0) {
        BlocProvider.of<CompanyCubit>(context)
            .setCompany(companyProvider!.state.lstcompany![0]);
      }
    });
    if (BlocProvider.of<DailyReportsCubit>(context).state.location == "" ||
        BlocProvider.of<DailyReportsCubit>(context).state.weather == "")
      await getCurrentPosition(context);
    if (BlocProvider.of<DailyReportsCubit>(context).state.location == "" ||
        BlocProvider.of<DailyReportsCubit>(context).state.weather == "") {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text("No Internet"),
                clipBehavior: Clip.none,
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getTextFormField(
                        controller: locationController,
                        hintName: 'Enter Location',
                        icon: Icons.location_history,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextFormField(
                        controller: weatherController,
                        hintName: 'Enter Weather',
                        icon: Icons.cloud,
                      )
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        if (locationController.text.isNotEmpty &&
                            weatherController.text.isNotEmpty) {
                          BlocProvider.of<DailyReportsCubit>(context)
                              .setLocation(locationController.text.toString());
                          BlocProvider.of<DailyReportsCubit>(context)
                              .setWeather(weatherController.text.toString());
                          Navigator.pop(context);
                          isloading = false;
                          setState(() {});
                          BlocProvider.of<UserCubit>(context)
                                  .state
                                  .securityWarning!
                              ? showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text("Warning"),
                                        content: Text(
                                          "The security license will expire on ${BlocProvider.of<UserCubit>(context).state.userModel!.securityLicenseExpiryDate}",
                                          style: TextStyle(
                                              fontFamily: context
                                                  .watch<UserCubit>()
                                                  .state
                                                  .font),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setSecurityWarning(false);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarning(false);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarningTwoWeeks(
                                                        true, true);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                  "Remind me in two weeks")),
                                          ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setSecurityWarning(false);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarningTwoWeeks(
                                                        false, true);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarning(false);
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  Text("Don't Remind me again"))
                                        ],
                                      )))
                              : const Text("");
                          BlocProvider.of<UserCubit>(context).state.ofaWarning!
                              ? showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text("Warning"),
                                        content: Text(
                                          "The ofa license will expire on ${BlocProvider.of<UserCubit>(context).state.userModel!.ofaExpiryDate}",
                                          style: TextStyle(
                                              fontFamily: context
                                                  .watch<UserCubit>()
                                                  .state
                                                  .font),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setOfaWarning(true);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarning(false);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarningTwoWeeks(
                                                        true, false);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                  "Remind me in two weeks")),
                                          ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setOfaWarning(false);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarningTwoWeeks(
                                                        false, false);
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .setWarning(false);
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  Text("Don't Remind me again"))
                                        ],
                                      )))
                              : const Text("");
                        } else {
                          showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    title: Text("Warning!"),
                                    content: Text("Fill all fields"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Okay"))
                                    ],
                                  )));
                        }
                      },
                      child: Text("Save"))
                ],
              )));
    } else {
      isloading = false;
      setState(() {});
      BlocProvider.of<UserCubit>(context).state.securityWarning!
          ? showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    title: Text("Warning"),
                    content: Text(
                      "The security license will expire on ${BlocProvider.of<UserCubit>(context).state.userModel!.securityLicenseExpiryDate}",
                      style: TextStyle(
                          fontFamily: context.watch<UserCubit>().state.font),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<UserCubit>(context)
                                .setSecurityWarning(false);
                            BlocProvider.of<UserCubit>(context)
                                .setWarning(false);
                            BlocProvider.of<UserCubit>(context)
                                .setWarningTwoWeeks(true, true);
                            Navigator.pop(context);
                          },
                          child: Text("Remind me in two weeks")),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<UserCubit>(context)
                                .setSecurityWarning(false);
                            BlocProvider.of<UserCubit>(context)
                                .setWarningTwoWeeks(false, true);
                            BlocProvider.of<UserCubit>(context)
                                .setWarning(false);
                            Navigator.pop(context);
                          },
                          child: Text("Don't Remind me again"))
                    ],
                  )))
          : const Text("");
      BlocProvider.of<UserCubit>(context).state.ofaWarning!
          ? showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    title: Text("Warning"),
                    content: Text(
                      "The ofa license will expire on ${BlocProvider.of<UserCubit>(context).state.userModel!.ofaExpiryDate}",
                      style: TextStyle(
                          fontFamily: context.watch<UserCubit>().state.font),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<UserCubit>(context)
                                .setOfaWarning(true);
                            BlocProvider.of<UserCubit>(context)
                                .setWarning(false);
                            BlocProvider.of<UserCubit>(context)
                                .setWarningTwoWeeks(true, false);
                            Navigator.pop(context);
                          },
                          child: Text("Remind me in two weeks")),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<UserCubit>(context)
                                .setOfaWarning(false);
                            BlocProvider.of<UserCubit>(context)
                                .setWarningTwoWeeks(false, false);
                            BlocProvider.of<UserCubit>(context)
                                .setWarning(false);
                            Navigator.pop(context);
                          },
                          child: Text("Don't Remind me again"))
                    ],
                  )))
          : const Text("");
    }
  }

  bool _showHeader = false;

  String date = DateFormat.yMMMMd().format(DateTime.now());

// bottom modal type in your log entry
  void _startNewLogEntry(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewLogEntry(
            selectedvalue: BlocProvider.of<CompanyCubit>(context).state.company,
            lstcompany: companyProvider!.state.lstcompany ?? [],
            location: context.read<DailyReportsCubit>().state.location,
            weather: context.read<DailyReportsCubit>().state.weather);
      },
    );
  }

//landscape view
  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    logWidget,
  ) {
    // String weather;
    // String location;
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
// creates more room removing the header in landsacpe view
          const Text('Show header'),
          Switch.adaptive(
            activeColor: Theme.of(context).shadowColor,
            value: _showHeader,
            onChanged: (val) {
              setState(() {
                _showHeader = val;
              });
            },
          ),
        ],
      ),
      _showHeader
          ? Column(children: [
              // Image.asset(
              //   'lib/images/logo.png',
              //   width: mediaQuery.size.width * .2,
              // ),
              // const SizedBox(
              //   height: 4,
              // ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    1,
                width: mediaQuery.size.width * 0.95,
                child: HeaderInfo(
                  lstcompany: companyProvider?.state.lstcompany ?? [],
                ),
              ),
              const Divider(
                height: 3,
                thickness: 2,
                color: Colors.black,
              ),
            ])
          : logWidget,
    ];
  }

// portrate view
  List<Widget> _buildPortrateContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    logWidget,
  ) {
    // String weather;
    // String location;
    return [
      Column(
        children: [
// this is hard coded for now I want to beable
//to upload url or image found on the device
          // Image.asset(
          //   'lib/images/logo.png',
          //   width: mediaQuery.size.width * .2,
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          Container(
              width: mediaQuery.size.width * 0.95,
              child: HeaderInfo(
                lstcompany: companyProvider?.state.lstcompany ?? [],
              )),
          const Divider(
            height: 3,
            thickness: 2,
            color: Colors.black,
          ),
        ],
      ),
      logWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Security Log Book'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startNewLogEntry(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Security Log Book',
              style:
                  TextStyle(fontFamily: context.watch<UserCubit>().state.font),
            ),
            actions: [
              IconButton(
                onPressed: () => _startNewLogEntry(context),
                icon: Icon(Icons.add),
              ),
            ],
          )) as PreferredSizeWidget;

    // is the log entrys list with the delete icon to be turned into strike out
    final logWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: LogInfoList(),
    );

    // body creates a single scrool view
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            if (isLandScape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar as AppBar,
                logWidget,
              ),
// ! is not landscape
            if (!isLandScape)
              ..._buildPortrateContent(
                mediaQuery,
                appBar as AppBar,
                logWidget,
              ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );

// is IPS
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget?,
          )
        : Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: appBar,
            body: isloading
                ? Center(child: const CircularProgressIndicator())
                : pageBody,
            drawer: Drawer(
                child: MainDrawer(
              lstcompany: companyProvider?.state.lstcompany ?? [],
            )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
                FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => _startNewLogEntry(context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Text(
                  "Page ${BlocProvider.of<DailyReportsCubit>(context).state.lstdailyreports.length + 1}",
                  style: TextStyle(
                      fontFamily: context.watch<UserCubit>().state.font),
                )
              ],
            ),
          );
  }
}
