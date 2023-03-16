import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/widgets/detail.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatelessWidget {
  SignatureScreen({Key? key}) : super(key: key);
  static const routeName = '/signature';

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Signature"),
      ),
      drawer: Drawer(
        child: MainDrawer(
          lstcompany: companyProvider.state.lstcompany ?? [],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Signature(
              controller: _controller,
              height: 300,
              backgroundColor: Colors.lightBlueAccent,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    child: const Text("Clear"),
                  ),
                  BlocProvider.of<DailyReportsCubit>(context)
                              .state
                              .dailyReportNotes !=
                          null
                      ? BlocProvider.of<DailyReportsCubit>(context)
                                  .state
                                  .dailyReportNotes!
                                  .signature !=
                              null
                          ? Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      if (_controller.isNotEmpty) {
                                        final Uint8List? data =
                                            await _controller.toPngBytes();
                                        if (data != null &&
                                            BlocProvider.of<DailyReportsCubit>(
                                                        context)
                                                    .state
                                                    .dailyReportNotes !=
                                                null) {
                                          BlocProvider.of<DailyReportsCubit>(
                                                      context)
                                                  .state
                                                  .lstdailyreports
                                                  .last
                                                  .signature =
                                              String.fromCharCodes(data);
                                          BlocProvider.of<DailyReportsCubit>(
                                                      context)
                                                  .state
                                                  .tempdailyreports
                                                  .last
                                                  .signature =
                                              String.fromCharCodes(data);
                                          BlocProvider.of<DailyReportsCubit>(
                                                      context)
                                                  .state
                                                  .dailyReportNotes!
                                                  .signature =
                                              String.fromCharCodes(data);
                                          DbHelper db = DbHelper.instance;
                                          db.updateDailyReportNotes(BlocProvider
                                                  .of<DailyReportsCubit>(
                                                      context)
                                              .state
                                              .dailyReportNotes!);
                                          alertDialog(
                                              context, "Signature Saved");
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      DetailScreen())));
                                        }
                                      }
                                    },
                                    child: Text("Edit")),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  DetailScreen())));
                                    },
                                    child: Text("Next")),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (_controller.isNotEmpty) {
                                  final Uint8List? data =
                                      await _controller.toPngBytes();
                                  if (data != null &&
                                      BlocProvider.of<DailyReportsCubit>(
                                                  context)
                                              .state
                                              .dailyReportNotes !=
                                          null) {
                                    BlocProvider.of<DailyReportsCubit>(context)
                                        .state
                                        .lstdailyreports
                                        .last
                                        .signature = String.fromCharCodes(data);
                                    BlocProvider.of<DailyReportsCubit>(context)
                                        .state
                                        .dailyReportNotes!
                                        .signature = String.fromCharCodes(data);
                                    DbHelper db = DbHelper.instance;
                                    db.updateDailyReportNotes(
                                        BlocProvider.of<DailyReportsCubit>(
                                                context)
                                            .state
                                            .dailyReportNotes!);
                                    alertDialog(context, "Signature Saved");
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                DetailScreen())));
                                  }
                                }
                              },
                              child: const Text("Save"),
                            )
                      : const Text("")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
