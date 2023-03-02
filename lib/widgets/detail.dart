// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:typed_data';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/comm/loading.dart';
import 'package:flutter_complete_guide/models/company_model.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../Bloc/DailyReportNotes/dailyreports_state.dart';
import 'main_drawer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  List<Company> lstcompany = [];

  final String date = DateFormat.yMMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final userProvider = BlocProvider.of<UserCubit>(context);
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      drawer: Drawer(
          child: MainDrawer(
        lstcompany: companyProvider.state.lstcompany ?? [],
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CupertinoSearchTextField(
                        onChanged: (value) => context
                            .read<DailyReportsCubit>()
                            .setTempList(value),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                content: Container(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<DailyReportsCubit>(
                                                  context)
                                              .setFilter(false);
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          leading: Icon(Icons.date_range),
                                          title: Text("Date"),
                                        ),
                                      ),
                                      Divider(),
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<DailyReportsCubit>(
                                                  context)
                                              .setFilter(true);
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          leading: Icon(Icons.home_max),
                                          title: Text("Company"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                title: Text("Select Filter"),
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade700,
                          borderRadius: BorderRadius.circular(99.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.filter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              BlocBuilder<DailyReportsCubit, DailyReportsState>(
                  builder: (context, state) {
                return Screenshot(
                  controller: state.screenshotController,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.tempdailyreports.length,
                      itemBuilder: (context, index) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                mytext("Page Number", (index + 1).toString()),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                mytext(
                                    "UserName",
                                    userProvider.state.userModel!.name
                                        .toString()),
                                mytext(
                                    "Date",
                                    state.tempdailyreports[index].dateCreated
                                        .toString())
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ExpandablePanel(
                              header: mytext("Notes", ""),
                              collapsed: Text(
                                state.tempdailyreports[index].notes
                                            .toString()
                                            .length >
                                        50
                                    ? state.tempdailyreports[index].notes
                                        .toString()
                                        .substring(0, 49)
                                    : state.tempdailyreports[index].notes
                                        .toString(),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              expanded: Text(
                                state.tempdailyreports[index].notes.toString(),
                                softWrap: true,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    state.tempdailyreports[index].logs.length,
                                itemBuilder: (context, notes_index) {
                                  return logEntryItem(
                                      index, notes_index, context, state);
                                }),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  mytext("Signature", ""),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: state.tempdailyreports[index]
                                                .signature !=
                                            ""
                                        ? Image.memory(
                                            convertStringToUint8List(state
                                                .tempdailyreports[index]
                                                .signature
                                                .toString()),
                                            fit: BoxFit.fill,
                                          )
                                        : Text(""),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }),
              ElevatedButton(
                  onPressed: () async {
                    loading(context);
                    await BlocProvider.of<DailyReportsCubit>(context)
                        .state
                        .screenshotController
                        .capture(delay: Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      await getPdf(context, capturedImage);
                    }).catchError((onError) {
                      alertDialog(context, "Something went wrong.");
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Generate PDF"))
            ],
          ),
        ),
      ),
    );
  }

  Future getPdf(BuildContext context, Uint8List? screenShot) async {
    if (screenShot != null) {
      pw.Document pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Expanded(
              child:
                  pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
            );
          },
        ),
      );
      List<int> bytes = await pdf.save();
      final path = (await getExternalStorageDirectory())!.path;
      File pdfFile = File("${path}/$date.pdf");
      print("${path}/$date.pdf");
      await pdfFile.writeAsBytes(bytes, flush: true);
      await OpenFile.open("${path}/$date.pdf");

      alertDialog(context, "PDF Generated");
    } else {
      alertDialog(context, "Something went wrong");
    }
  }

  ListTile logEntryItem(int index, int notes_index, BuildContext context,
      DailyReportsState state) {
    return ListTile(
      leading: Text(
        "${state.tempdailyreports[index].logs[notes_index].timeCreated.toString()} |",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      title:
          Text(state.tempdailyreports[index].logs[notes_index].log.toString()),
      subtitle: Text(
          state.tempdailyreports[index].logs[notes_index].company.toString()),
      trailing: Text(
          "${state.tempdailyreports[index].logs[notes_index].location.toString()}\n${state.tempdailyreports[index].logs[notes_index].weather.toString()}"),
    );
  }

  Text mytext(String title, String text) {
    return Text(
      "$title: $text",
      style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
    );
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
