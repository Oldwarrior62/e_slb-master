// ignore_for_file: must_be_immutable

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_state.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_state.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/models/company_model.dart';
import 'package:flutter_complete_guide/models/daily_report_model.dart';
import 'package:intl/intl.dart';
import '../Bloc/Company/company_cubit.dart';
import '../Bloc/User/userCubit.dart';
import '../Comm/commHelper.dart';
//import 'package:flutter/services.dart';
//import 'package:geolocator/geolocator.dart';

class HeaderInfo extends StatefulWidget {
  HeaderInfo({required this.lstcompany});
  List<Company> lstcompany = [];
  @override
  State<HeaderInfo> createState() => _HeaderInfoState();
}

class _HeaderInfoState extends State<HeaderInfo> {
  // final Geolocator geolocator = Geolocator();
  final String date = DateFormat.yMMMMd().format(DateTime.now());
  bool isopen = false;
  List<DropdownMenuItem<Company>> getitems() {
    return widget.lstcompany
        .map((e) => DropdownMenuItem(
              child: Text(e.companyName.toString()),
              value: e,
            ))
        .toList();
  }

  TextEditingController notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: BlocBuilder<CompanyCubit, CompanyState>(
              builder: (context, state) {
            return Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
                state.company != null
                    ? Text(
                        state.company!.companyName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: context.watch<UserCubit>().state.font),
                      )
                    : Image.asset(
                        'lib/images/logo.png',
                        width: MediaQuery.of(context).size.width * .2,
                      ),
                const SizedBox(
                  width: 10,
                ),
              ],
            );
          }),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${BlocProvider.of<UserCubit>(context).state.userModel!.surname.toString()}${BlocProvider.of<UserCubit>(context).state.userModel!.name?.substring(0, 1)}',
                style: TextStyle(
                  fontFamily: context.watch<UserCubit>().state.font,
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * curScaleFactor,
                ),
              ),

              //display for current year month day is submitted
              Text(
                date,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14 * curScaleFactor,
                    fontFamily: context.watch<UserCubit>().state.font),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              '${context.read<DailyReportsCubit>().state.weather}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: context.watch<UserCubit>().state.font),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flexible(
            child: Text(
              '${context.read<DailyReportsCubit>().state.location}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * curScaleFactor,
                  fontFamily: context.watch<UserCubit>().state.font),
            ),
          ),
        ),
        // !isopen
        //     ? const Padding(padding: EdgeInsets.zero)
        //     : context.watch<UserCubit>().state.islisence
        //         ? Builder(builder: (context) {
        //             return Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 8.0, bottom: 8.0, right: 6.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'Security Lisence: ${context.read<UserCubit>().state.userModel!.securityLicense.toString()}',
        //                     style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 14 * curScaleFactor,
        //                         fontFamily:
        //                             context.watch<UserCubit>().state.font),
        //                   ),
        //                   const SizedBox(
        //                     height: 10,
        //                   ),
        //                   Text(
        //                     'OFA: ${context.read<UserCubit>().state.userModel!.ofa.toString()}',
        //                     style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 14 * curScaleFactor,
        //                         fontFamily:
        //                             context.watch<UserCubit>().state.font),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           })
        //         : const Padding(padding: EdgeInsets.zero),
        !isopen
            ? InkWell(
                onTap: () {
                  isopen = !isopen;
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              )
            : BlocBuilder<DailyReportsCubit, DailyReportsState>(
                builder: (context, state) {
                return state.dailyReportNotes != null && state.isedit == false
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Notes",
                                      style: TextStyle(
                                        fontFamily: context
                                            .watch<UserCubit>()
                                            .state
                                            .font,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      BlocProvider.of<DailyReportsCubit>(
                                              context)
                                          .state
                                          .dailyReportNotes!
                                          .notes
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: context
                                              .watch<UserCubit>()
                                              .state
                                              .font),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      notesController.text = context
                                          .read<DailyReportsCubit>()
                                          .state
                                          .dailyReportNotes!
                                          .notes
                                          .toString();
                                      context
                                          .read<DailyReportsCubit>()
                                          .setIsEdit(true);
                                    },
                                    child: Text("Edit")),
                              ],
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: TextFormField(
                                controller: notesController,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    label: Text("Notes"),
                                    hintText: "Notes",
                                    border: OutlineInputBorder()),
                                maxLines: null,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                state.dailyReportNotes != null
                                    ? state.dailyReportNotes!.ontap == true
                                        ? ElevatedButton(
                                            onPressed: () {
                                              DbHelper db = DbHelper.instance;
                                              if (notesController
                                                  .text.isNotEmpty) {
                                                state.dailyReportNotes!.notes =
                                                    notesController.text;

                                                db
                                                    .updateDailyReportNotes(
                                                        state.dailyReportNotes!)
                                                    .then((value) => BlocProvider
                                                            .of<DailyReportsCubit>(
                                                                context)
                                                        .setDailyReports(state
                                                            .dailyReportNotes!));
                                                context
                                                    .read<DailyReportsCubit>()
                                                    .state
                                                    .lstdailyreports
                                                    .last
                                                    .notes = notesController.text;
                                                BlocProvider.of<
                                                            DailyReportsCubit>(
                                                        context)
                                                    .setListDailyReports(
                                                        context
                                                            .read<
                                                                DailyReportsCubit>()
                                                            .state
                                                            .lstdailyreports,
                                                        false);
                                                BlocProvider.of<
                                                            DailyReportsCubit>(
                                                        context)
                                                    .setIsEdit(false);
                                              }
                                            },
                                            child: Text("Update"))
                                        : ElevatedButton(
                                            onPressed: () {
                                              DbHelper db = DbHelper.instance;
                                              if (notesController
                                                  .text.isNotEmpty) {
                                                state.dailyReportNotes!.notes =
                                                    notesController.text;

                                                db
                                                    .updateDailyReportNotes(
                                                        state.dailyReportNotes!)
                                                    .then((value) => BlocProvider
                                                            .of<DailyReportsCubit>(
                                                                context)
                                                        .setDailyReports(state
                                                            .dailyReportNotes!));
                                                context
                                                    .read<DailyReportsCubit>()
                                                    .state
                                                    .lstdailyreports
                                                    .last
                                                    .notes = notesController.text;
                                                BlocProvider.of<
                                                            DailyReportsCubit>(
                                                        context)
                                                    .setListDailyReports(
                                                        context
                                                            .read<
                                                                DailyReportsCubit>()
                                                            .state
                                                            .lstdailyreports,
                                                        false);
                                                BlocProvider.of<
                                                            DailyReportsCubit>(
                                                        context)
                                                    .setIsEdit(false);
                                              }
                                            },
                                            child: Text("Save"))
                                    : ElevatedButton(
                                        onPressed: () {
                                          if (notesController.text.isNotEmpty) {
                                            insertDailyReports(
                                                notesController.text);
                                          }
                                        },
                                        child: Text("Save")),
                              ],
                            ),
                          )
                        ],
                      );
              }),
        isopen
            ? InkWell(
                onTap: () {
                  isopen = !isopen;
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_drop_up),
                  ],
                ),
              )
            : const Padding(padding: EdgeInsets.zero)
      ],
    );
  }

  insertDailyReports(String note) {
    final provider = BlocProvider.of<DailyReportsCubit>(context);
    String Date = DateTime.now().toString().split(' ')[0];

    DbHelper db = DbHelper.instance;

    if (provider.state.dailyReportNotes == null) {
      DailyReportNotes dailyReport = DailyReportNotes(
          dailyReportId: 0,
          notes: note,
          logs: [],
          dateCreated: Date,
          signature: "");
      provider.setDailyReports(dailyReport);
      provider.state.lstdailyreports.add(dailyReport);
      List<DailyReportNotes> templst = provider.state.lstdailyreports;
      provider.setListDailyReports(templst, false);
      db.insertDailyReport(dailyReport).then((value) {
        alertDialog(context, "Notes Added");
      });
    }
  }
}
