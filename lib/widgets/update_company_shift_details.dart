import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_state.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/models/company_model.dart';

class UpdateCompanyShiftDetails extends StatelessWidget {
  const UpdateCompanyShiftDetails({Key? key}) : super(key: key);
  static const routeName = '/updatecompanyshiftscreen';

  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    List<String> lst = [
      '12:00:00 AM',
      '01:00:00 AM',
      '02:00:00 AM',
      '03:00:00 AM',
      '04:00:00 AM',
      '05:00:00 AM',
      '06:00:00 AM',
      '07:00:00 AM',
      '08:00:00 AM',
      '09:00:00 AM',
      '10:00:00 AM',
      '11:00:00 AM',
      '12:00:00 PM',
      '01:00:00 PM',
      '02:00:00 PM',
      '03:00:00 PM',
      '04:00:00 PM',
      '05:00:00 PM',
      '06:00:00 PM',
      '07:00:00 PM',
      '08:00:00 PM',
      '09:00:00 PM',
      '10:00:00 PM',
      '11:00:00 PM',
    ];
    List<DropdownMenuItem<String>> lstStartTime() {
      return lst
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList();
    }

    List lstStartDropdownValue = [];
    List lstEndDropdownValue = [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Shifts"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 7),
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7)
                ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    companyProvider
                                .state
                                .lstcompany![
                                    companyProvider.state.selectedIndex!]
                                .image !=
                            null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: MemoryImage(
                                Uint8List.fromList(companyProvider
                                    .state
                                    .lstcompany![
                                        companyProvider.state.selectedIndex!]
                                    .image!
                                    .codeUnits),
                              ),
                            ),
                          )
                        : const Padding(padding: EdgeInsets.zero),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(companyProvider
                            .state
                            .lstcompany![companyProvider.state.selectedIndex!]
                            .companyName
                            .toString()),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(companyProvider
                            .state
                            .lstcompany![companyProvider.state.selectedIndex!]
                            .companyEmail
                            .toString()),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: companyProvider
                    .state
                    .lstcompany![companyProvider.state.selectedIndex!]
                    .lstShifts
                    .length,
                itemBuilder: ((context, index) {
                  String selectedStartValue = companyProvider
                      .state
                      .lstcompany![companyProvider.state.selectedIndex!]
                      .lstShifts[index]
                      .split('-')[0];
                  String selectedEndValue = companyProvider
                      .state
                      .lstcompany![companyProvider.state.selectedIndex!]
                      .lstShifts[index]
                      .split('-')[1];
                  lstStartDropdownValue.add(selectedStartValue);
                  lstEndDropdownValue.add(selectedEndValue);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Shift: ${index + 1}",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily:
                                  context.watch<UserCubit>().state.font),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<CompanyCubit, CompanyState>(
                              buildWhen: ((previous, current) =>
                                  previous.selectedStartTime !=
                                  current.selectedStartTime),
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: DropdownButton<String>(
                                      value: selectedStartValue,
                                      items: lstStartTime(),
                                      onChanged: (value) {
                                        selectedStartValue = value.toString();
                                        lstStartDropdownValue[index] =
                                            selectedStartValue;
                                        context
                                            .read<CompanyCubit>()
                                            .setSelectedStartTime(
                                                value.toString(),
                                                state.selectedIndex!);
                                      }),
                                );
                              }),
                          BlocBuilder<CompanyCubit, CompanyState>(
                              buildWhen: (previous, current) =>
                                  previous.selectedEndTime !=
                                  current.selectedEndTime,
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: DropdownButton<String>(
                                      value: selectedEndValue,
                                      items: lstStartTime(),
                                      onChanged: (value) {
                                        selectedEndValue = value.toString();
                                        lstEndDropdownValue[index] =
                                            selectedEndValue;
                                        context
                                            .read<CompanyCubit>()
                                            .setSelectedEndTime(
                                                value.toString(),
                                                state.selectedIndex!);
                                      }),
                                );
                              }),
                        ],
                      ),
                    ],
                  );
                })),
            Center(
              child: Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: TextButton(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      companyProvider
                          .state
                          .lstcompany![companyProvider.state.selectedIndex!]
                          .lstShifts = [];
                      for (int i = 0; i < lstStartDropdownValue.length; i++) {
                        companyProvider
                            .state
                            .lstcompany![companyProvider.state.selectedIndex!]
                            .lstShifts
                            .add(
                                "${lstStartDropdownValue[i]}-${lstEndDropdownValue[i]}");
                      }
                      DbHelper db = DbHelper.instance;

                      await db
                          .updateCompanyData(companyProvider.state.lstcompany![
                              companyProvider.state.selectedIndex!])
                          .then((value) {
                        List<Company> templst =
                            context.read<CompanyCubit>().state.lstcompany ?? [];

                        context.read<CompanyCubit>().setlstCompany(templst);
                        alertDialog(context, "Company Updated");
                      });
                    }),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
