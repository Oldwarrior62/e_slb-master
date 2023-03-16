// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_state.dart';
import 'package:flutter_complete_guide/Comm/commHelper.dart';
import '../DatabaseHandler/DbHelper.dart';
import '../models/daily_report_model.dart';

class LogInfoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<DailyReportsCubit, DailyReportsState>(
        builder: (context, state) {
      return Container(
        child: state.lstdailyreports.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    width: mediaQuery.size.width * .8,
                  ),
                  Text(
                    'No log entered.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            : ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.lstdailyreports[index].logs.length,
                          itemBuilder: (context, notes_index) {
                            return logEntryItem(index, notes_index,
                                curScaleFactor, context, state);
                          });
                    },
                    itemCount: state.lstdailyreports.length,
                  ),
                  const SizedBox(
                    height: 140,
                  )
                ],
              ),
      );
    });
  }

  ListTile logEntryItem(int index, int notes_index, double curScaleFactor,
      BuildContext context, DailyReportsState state) {
    return ListTile(
        leading: Text(
          "${state.lstdailyreports[index].logs[notes_index].timeCreated.toString()} |",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16 * curScaleFactor,
          ),
        ),
        title: state.lstdailyreports[index].logs[notes_index].isline!
            ? Text(
                state.lstdailyreports[index].logs[notes_index].log.toString(),
                style: TextStyle(decoration: TextDecoration.lineThrough),
              )
            : Text(
                state.lstdailyreports[index].logs[notes_index].log.toString()),
        trailing: IconButton(
            onPressed: () async {
              DbHelper db = DbHelper.instance;
              state.lstdailyreports[index].logs[notes_index].isline =
                  !state.lstdailyreports[index].logs[notes_index].isline!;
              List<DailyReportNotes> templst = state.lstdailyreports;
              await db
                  .updateDailyReportNotes(state.lstdailyreports[index])
                  .then((value) {
                BlocProvider.of<DailyReportsCubit>(context).setListDailyReports(
                    templst,
                    BlocProvider.of<DailyReportsCubit>(context).state.log);
              });
            },
            icon: state.lstdailyreports[index].logs[notes_index].isline!
                ? Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.edit,
                    color: Colors.grey,
                  )));
  }
}
