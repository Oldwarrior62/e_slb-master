import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_state.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/models/daily_report_model.dart';
import 'package:flutter_complete_guide/widgets/detail.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);

    return Scaffold(
      drawer: Drawer(
        child: MainDrawer(
          lstcompany: companyProvider.state.lstcompany ?? [],
        ),
      ),
      appBar: AppBar(
          title: Text(
        'Search',
        style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
      )),
      body: SingleChildScrollView(
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
                      onChanged: (value) =>
                          context.read<DailyReportsCubit>().setTempList(value),
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
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.tempdailyreports.length,
                  itemBuilder: ((context, index) => InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DetailScreen(
                                      dailyReportNotes:
                                          state.tempdailyreports[index],
                                    )))),
                        child: card(
                            state.tempdailyreports[index].dateCreated
                                .toString(),
                            state.tempdailyreports[index].company.toString(),
                            state.tempdailyreports,
                            index,
                            context),
                      )));
            }),
          ],
        ),
      ),
    );
  }

  Padding card(String date, String company, List<DailyReportNotes> lst,
      int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 7),
                    spreadRadius: 3,
                    blurRadius: 7,
                    color: Colors.grey.withOpacity(0.5))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: context.watch<UserCubit>().state.font),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        company,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: context.watch<UserCubit>().state.font),
                      )
                    ],
                  ),
                  lst[index].logo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Image.memory(
                              Uint8List.fromList(lst[index].logo!.codeUnits),
                              fit: BoxFit.fill,
                              gaplessPlayback: true,
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.zero,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
