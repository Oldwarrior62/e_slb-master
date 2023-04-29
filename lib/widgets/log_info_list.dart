// ignore_for_file: must_be_immutable

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_state.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_state.dart';

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
        child: state.lstdailyreports.isEmpty ||
                context.read<CompanyCubit>().state.company == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'lib/images/logo-transparent-png.png',
                    width: mediaQuery.size.width * .8,
                  ),
                  Text(
                    'No log entered.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            : Stack(
                children: [
                  BlocBuilder<CompanyCubit, CompanyState>(
                      builder: (context, state) {
                    return Center(
                      child: Positioned(
                        child: state.company!.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(99),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.dstATop),
                                    child: Image.memory(
                                      Uint8List.fromList(
                                          state.company!.image!.codeUnits),
                                      fit: BoxFit.fill,
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.zero,
                              ),
                      ),
                    );
                  }),
                  state.dailyReportNotes == null
                      ? const Padding(padding: EdgeInsets.zero)
                      : ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.dailyReportNotes!.logs.length,
                                itemBuilder: (context, notes_index) {
                                  return Column(
                                    children: [
                                      logEntryItem(notes_index, curScaleFactor,
                                          context, state),
                                      Divider(
                                        indent: 20,
                                        endIndent: 20,
                                        height: 0.8,
                                        thickness: 2,
                                      )
                                    ],
                                  );
                                }),
                            const SizedBox(
                              height: 140,
                            )
                          ],
                        ),
                ],
              ),
      );
    });
  }

  ListTile logEntryItem(int notes_index, double curScaleFactor,
      BuildContext context, DailyReportsState state) {
    return ListTile(
        leading: Text(
          "${state.dailyReportNotes!.logs[notes_index].timeCreated.toString()} |",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16 * curScaleFactor,
          ),
        ),
        title: state.dailyReportNotes!.logs[notes_index].isline!
            ? Text(
                state.dailyReportNotes!.logs[notes_index].log.toString(),
                style: TextStyle(decoration: TextDecoration.lineThrough),
              )
            : Text(state.dailyReportNotes!.logs[notes_index].log.toString()),
        trailing: IconButton(
            onPressed: () async {
              DbHelper db = DbHelper.instance;
              state.dailyReportNotes!.logs[notes_index].isline =
                  !state.dailyReportNotes!.logs[notes_index].isline!;
              List<DailyReportNotes> templst = state.lstdailyreports;
              await db
                  .updateDailyReportNotes(state.dailyReportNotes!)
                  .then((value) {
                BlocProvider.of<DailyReportsCubit>(context).setListDailyReports(
                    templst,
                    BlocProvider.of<DailyReportsCubit>(context).state.log);
              });
            },
            icon: state.dailyReportNotes!.logs[notes_index].isline!
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
