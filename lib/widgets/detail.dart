// ignore_for_file: must_be_immutable
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userState.dart';
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
  String? currentValue;
  int pageNumber = 0;

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
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
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
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    state.tempdailyreports[index].logs.length,
                                itemBuilder: (context, notes_index) {
                                  bool status = false;
                                  bool signatureStatus = false;
                                  bool headerSatus = false;
                                  if (notes_index == 0) {
                                    status = true;
                                    currentValue = state.tempdailyreports[index]
                                        .logs[notes_index].company;
                                  } else if (currentValue !=
                                      state.tempdailyreports[index]
                                          .logs[notes_index].company) {
                                    status = true;
                                    currentValue = state.tempdailyreports[index]
                                        .logs[notes_index].company;
                                  } else {
                                    status = false;
                                    signatureStatus = false;
                                    headerSatus = false;
                                  }
                                  if (state
                                          .tempdailyreports[index].logs.length >
                                      notes_index + 1) {
                                    if (currentValue !=
                                        state.tempdailyreports[index]
                                            .logs[notes_index + 1].company) {
                                      signatureStatus = true;
                                      headerSatus = true;
                                      pageNumber++;
                                    }
                                  } else if (state.tempdailyreports[index].logs
                                              .length -
                                          1 ==
                                      notes_index) {
                                    signatureStatus = true;
                                    pageNumber++;
                                  }
                                  return logEntryItem(
                                      index,
                                      notes_index,
                                      context,
                                      state,
                                      status,
                                      signatureStatus,
                                      headerSatus,
                                      userProvider);
                                }),
                            const SizedBox(
                              height: 5,
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

  Column header(UserCubit userProvider, DailyReportsState state, int index,
      {int? logIndex}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mytext("",
                "${userProvider.state.userModel!.surname.toString()}${userProvider.state.userModel!.name.toString().substring(0, 1)}"),
            mytext("", state.tempdailyreports[index].dateCreated.toString())
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            mytext(
                "",
                state.tempdailyreports[index].logs[logIndex ?? 0].weather
                    .toString()),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: mytext(
                  "",
                  state.tempdailyreports[index].logs[logIndex ?? 0].location
                      .toString()),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        userProvider.state.userModel!.ofaExpiryDate != null
            ? mytext(
                "oFA: ", userProvider.state.userModel!.ofaExpiryDate.toString())
            : const Padding(padding: EdgeInsets.zero),
        userProvider.state.userModel!.ofaExpiryDate != null
            ? const SizedBox(
                height: 10,
              )
            : const Padding(padding: EdgeInsets.zero),
        userProvider.state.userModel!.securityLicenseExpiryDate != null
            ? mytext(
                "Security: ",
                userProvider.state.userModel!.securityLicenseExpiryDate
                    .toString())
            : const Padding(padding: EdgeInsets.zero),
        userProvider.state.userModel!.securityLicenseExpiryDate != null
            ? const SizedBox(
                height: 15,
              )
            : const Padding(padding: EdgeInsets.zero),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              state.tempdailyreports[index].notes.toString(),
              softWrap: true,
            ),
          ],
        ),
      ],
    );
  }

  Padding signature(DailyReportsState state, int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          mytext("Signature", ""),
          Container(
            height: 100,
            width: 100,
            child: state.tempdailyreports[index].signature != ""
                ? Image.memory(
                    convertStringToUint8List(
                        state.tempdailyreports[index].signature.toString()),
                    fit: BoxFit.fill,
                  )
                : Text(""),
          ),
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
              child:
                  pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
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

  Widget logEntryItem(
    int index,
    int notes_index,
    BuildContext context,
    DailyReportsState state,
    bool status,
    bool signatureStatus,
    bool headerStatus,
    UserCubit userProvider,
  ) {
    return Column(
      children: [
        status
            ? state.tempdailyreports[index].logs[notes_index].logo != null
                ? Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: MemoryImage(Uint8List.fromList(state
                            .tempdailyreports[index]
                            .logs[notes_index]
                            .logo!
                            .codeUnits)),
                      ),
                      header(userProvider, state, index, logIndex: notes_index),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                : Text(
                    "${state.tempdailyreports[index].logs[notes_index].company.toString()}")
            : const Padding(padding: EdgeInsets.zero),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Text(
            "${state.tempdailyreports[index].logs[notes_index].timeCreated.toString()} |",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          title: state.lstdailyreports[index].logs[notes_index].isline!
              ? Text(
                  state.lstdailyreports[index].logs[notes_index].log.toString(),
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                )
              : Text(state.tempdailyreports[index].logs[notes_index].log
                  .toString()),
        ),
        signatureStatus
            ? signature(state, index)
            : const Padding(padding: EdgeInsets.zero),
        signatureStatus
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      mytext("Page ", (pageNumber).toString()),
                    ],
                  ),
                  const Divider()
                ],
              )
            : const Padding(padding: EdgeInsets.zero),
        // headerStatus
        //     ? Padding(
        //         padding: const EdgeInsets.only(top: 16.0),
        //         child:
        //             header(userProvider, state, index, logIndex: notes_index),
        //       )
        //     : const Padding(padding: EdgeInsets.zero)
      ],
    );
  }

  Text mytext(String title, String text) {
    return Text(
      "$title $text",
      style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
    );
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
