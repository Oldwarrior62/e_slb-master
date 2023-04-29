// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/models/daily_report_model.dart';

import '../models/company_model.dart';

class NewLogEntry extends StatefulWidget {
  NewLogEntry(
      {required this.selectedvalue,
      required this.lstcompany,
      required this.location,
      required this.weather});
  Company? selectedvalue;
  List<Company> lstcompany = [];
  String location;
  String weather;

  @override
  State<NewLogEntry> createState() => _NewLogEntryState();
}

class _NewLogEntryState extends State<NewLogEntry> {
  final entryController = TextEditingController();

  void submitData() {
    final enteredLog = entryController.text;
    if (enteredLog.isEmpty) {
      return;
    } else if (widget.selectedvalue == null) {
      alertDialog(context, "Company Must be Selected or Shift not Started..");
      Navigator.of(context).pop();
    } else {
      final provider = BlocProvider.of<DailyReportsCubit>(context);
      String Date = DateTime.now().toString().split(' ')[0];
      String tempTime = DateTime.now().toString().split(' ')[1].split('.')[0];
      String Time = "${tempTime.split(':')[0]}:${tempTime.split(':')[1]}";
      DbHelper db = DbHelper.instance;
      Log log = Log(entryController.text, Time, 0, isline: false);
      if (provider.state.dailyReportNotes == null ||
          provider.state.lstdailyreports
              .where((e) =>
                  e.dateCreated == Date &&
                  e.company == widget.selectedvalue!.companyName)
              .toList()
              .isEmpty) {
        DailyReportNotes dailyReport = DailyReportNotes(
            dailyReportId: 0,
            notes: "",
            logs: [log],
            dateCreated: Date,
            weather: widget.weather,
            company: widget.selectedvalue!.companyName,
            location: widget.location,
            logo: widget.selectedvalue!.image);
        db.insertDailyReport(dailyReport).then((value) {
          dailyReport.dailyReportId = value;
          alertDialog(context, "Report Added");
        });
        provider.setDailyReports(dailyReport);
        provider.state.lstdailyreports.add(dailyReport);
        List<DailyReportNotes> templst = provider.state.lstdailyreports;
        provider.setListDailyReports(
            templst, BlocProvider.of<DailyReportsCubit>(context).state.log);
      } else {
        List<DailyReportNotes> templst = [];
        for (DailyReportNotes dailyReportNotes
            in provider.state.lstdailyreports) {
          if (dailyReportNotes.dateCreated == Date &&
              dailyReportNotes.company == widget.selectedvalue!.companyName) {
            dailyReportNotes.logs.add(log);
          }
          templst.add(dailyReportNotes);
        }

        // provider.state.dailyReportNotes!.logs.add(log);
        // provider.state.lstdailyreports
        //     .removeAt(provider.state.lstdailyreports.length - 1);
        // provider.state.lstdailyreports.add(provider.state.dailyReportNotes!);

        provider.setListDailyReports(
            templst, BlocProvider.of<DailyReportsCubit>(context).state.log);
        db
            .updateDailyReportNotes(templst
                .where((e) =>
                    e.dateCreated == Date &&
                    e.company == widget.selectedvalue!.companyName)
                .first)
            .then((value) {
          alertDialog(context, "Report Added");
        });
      }

      Navigator.of(context).pop();
      entryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child:
                //requesting the user to input log entry.
                TextField(
              decoration: const InputDecoration(labelText: 'Enter log'),
              controller: entryController,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: const Text('Add log'),

              // textColor: Colors.purple,
              onPressed: submitData,
            ),
          ],
        ),
      ],
    );
  }
}
