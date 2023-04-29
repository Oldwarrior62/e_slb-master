// ignore_for_file: must_be_immutable
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userState.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/comm/loading.dart';
import 'package:flutter_complete_guide/models/daily_report_model.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../Bloc/Company/company_state.dart';
import '../Bloc/DailyReportNotes/dailyreports_state.dart';
import 'main_drawer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, this.dailyReportNotes}) : super(key: key);
  static const routeName = '/detail';

  final String date = DateFormat.yMMMMd().format(DateTime.now());
  DailyReportNotes? dailyReportNotes;

  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    final userProvider = BlocProvider.of<UserCubit>(context);
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    List<DailyReportNotes> lst = BlocProvider.of<DailyReportsCubit>(context)
        .state
        .lstdailyreports
        .where((element) =>
            element.dateCreated == DateTime.now().toString().split(' ')[0])
        .toList();
    if (dailyReportNotes != null) {
      lst = [];
      lst.add(dailyReportNotes!);
    }
    return Scaffold(
      key: _key,
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
              BlocBuilder<DailyReportsCubit, DailyReportsState>(
                  builder: (context, state) {
                return Screenshot(
                    controller: state.screenshotController,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lst.length,
                      itemBuilder: (context, index) => ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                              ),
                              Text(
                                lst[index].company.toString(),
                                style: TextStyle(
                                    fontFamily:
                                        context.watch<UserCubit>().state.font,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          header(userProvider, state, lst, index, context),
                          Container(
                            child: Stack(
                              children: [
                                BlocBuilder<CompanyCubit, CompanyState>(
                                    builder: (context, state) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Positioned(
                                          child: lst[index].logo != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              99),
                                                    ),
                                                    child: ColorFiltered(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.2),
                                                              BlendMode
                                                                  .dstATop),
                                                      child: Image.memory(
                                                        Uint8List.fromList(
                                                            lst[index]
                                                                .logo!
                                                                .codeUnits),
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
                                      ],
                                    ),
                                  );
                                }),
                                ListView(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, notes_index) {
                                        return Column(
                                          children: [
                                            logEntryItem(index, notes_index,
                                                context, state, lst),
                                            Divider(
                                              indent: 20,
                                              endIndent: 20,
                                              height: 0.8,
                                              thickness: 2,
                                            )
                                          ],
                                        );
                                      },
                                      itemCount: lst[index].logs.length,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        signature(lst, index, context),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: mytext(
                                                  "Page ",
                                                  (index + 1).toString(),
                                                  context),
                                            ),
                                          ],
                                        ),
                                        const Divider()
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ));
              }),
              ElevatedButton(
                  onPressed: () async {
                    loading(context);
                    await BlocProvider.of<DailyReportsCubit>(context)
                        .state
                        .screenshotController
                        .capture(delay: Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      await getPdf(context, capturedImage, userProvider.state);
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

  ListTile logEntryItem(int index, int notes_index, BuildContext context,
      DailyReportsState state, List<DailyReportNotes> lst) {
    return ListTile(
      leading: Text(
        "${lst[index].logs[notes_index].timeCreated.toString()} |",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      title: lst[index].logs[notes_index].isline!
          ? Text(
              lst[index].logs[notes_index].log.toString(),
              style: TextStyle(decoration: TextDecoration.lineThrough),
            )
          : Text(lst[index].logs[notes_index].log.toString()),
    );
  }

  Column header(UserCubit userProvider, DailyReportsState state,
      List<DailyReportNotes> lst, int index, BuildContext context,
      {int? logIndex}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mytext(
                "",
                "${userProvider.state.userModel!.surname.toString()}${userProvider.state.userModel!.name.toString().substring(0, 1)}",
                context),
            mytext("", state.dailyReportNotes!.dateCreated.toString(), context)
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        mytext("", state.dailyReportNotes!.weather.toString(), context),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Flexible(
              child: mytext(
                  "", state.dailyReportNotes!.location.toString(), context),
            )
          ],
        ),
        userProvider.state.userModel!.ofaExpiryDate.toString() == "null"
            ? const Padding(padding: EdgeInsets.zero)
            : mytext(
                "OFA: ",
                userProvider.state.userModel!.ofaExpiryDate.toString(),
                context),
        const SizedBox(
          height: 10,
        ),
        userProvider.state.userModel!.ofaExpiryDate.toString() == "null"
            ? const Padding(padding: EdgeInsets.zero)
            : mytext(
                "Security: ",
                userProvider.state.userModel!.securityLicenseExpiryDate
                    .toString(),
                context),
        const SizedBox(
          height: 15,
        ),
        lst[index].notes != null
            ? state.dailyReportNotes!.notes != ""
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notes:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        lst[index].notes.toString(),
                        softWrap: true,
                      ),
                    ],
                  )
                : const Padding(padding: EdgeInsets.zero)
            : const Padding(padding: EdgeInsets.zero),
      ],
    );
  }

  Padding signature(
      List<DailyReportNotes> lst, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          mytext("Signature", "", context),
          Container(
              height: 100,
              child: Image.memory(
                convertStringToUint8List(context
                    .read<UserCubit>()
                    .state
                    .userModel!
                    .signature
                    .toString()),
                fit: BoxFit.fill,
              )),
        ],
      ),
    );
  }

  Future getPdf(
      BuildContext context, Uint8List? screenShot, UserState userState) async {
    if (screenShot != null) {
      pw.Document pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Expanded(
              child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.fill),
            );
          },
        ),
      );
      List<int> bytes = await pdf.save();
      final path = (await getExternalStorageDirectory())!.path;
      File pdfFile = File(
          "${path}/$date ${userState.userModel?.surname.toString()}${userState.userModel?.name!.substring(0, 1)}.pdf");
      print("${path}/$date.pdf");
      await pdfFile.writeAsBytes(bytes, flush: true);
      await OpenFile.open(
          "${path}/$date ${userState.userModel?.surname.toString()}${userState.userModel?.name!.substring(0, 1)}.pdf");

      alertDialog(context, "PDF Generated");
    } else {
      alertDialog(context, "Something went wrong");
    }
  }

  Text mytext(String title, String text, BuildContext context) {
    return Text(
      "$title $text",
      style: TextStyle(fontFamily: context.read<UserCubit>().state.font),
    );
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
