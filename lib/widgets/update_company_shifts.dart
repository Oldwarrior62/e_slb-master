import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/widgets/company_shift.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:flutter_complete_guide/widgets/update_company_shift_details.dart';

import '../Bloc/User/userCubit.dart';

class UpdateCompanyShifts extends StatelessWidget {
  const UpdateCompanyShifts({Key? key}) : super(key: key);
  static const routeName = '/updatecompanyshifts';
  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Company Shifts",
          style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(
          lstcompany: companyProvider.state.lstcompany ?? [],
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: companyProvider.state.lstcompany!.length,
              itemBuilder: ((context, index) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          companyProvider.setSelectedIndex(index);
                          Navigator.pushNamed(
                              context, UpdateCompanyShiftDetails.routeName);
                        },
                        child: ListTile(
                          leading:
                              companyProvider.state.lstcompany![index].image !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundImage: MemoryImage(
                                          Uint8List.fromList(companyProvider
                                              .state
                                              .lstcompany![index]
                                              .image!
                                              .codeUnits),
                                        ),
                                      ),
                                    )
                                  : const Padding(padding: EdgeInsets.zero),
                          title: Text(companyProvider
                              .state.lstcompany![index].companyName
                              .toString()),
                        ),
                      ),
                      const Divider()
                    ],
                  )))
        ],
      ),
    );
  }
}
