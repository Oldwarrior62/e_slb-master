import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_state.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

import '../comm/notes_card.dart';

class ViewNotes extends StatelessWidget {
  static const routeName = '/viewnotes';
  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Notes",
          style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(
          lstcompany: companyProvider.state.lstcompany ?? [],
        ),
      ),
      body: BlocBuilder<DailyReportsCubit, DailyReportsState>(
          builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.lstdailyreports.length,
          itemBuilder: (context, index) =>
              NotesContainer(state, index, context),
        );
      }),
    );
  }
}
