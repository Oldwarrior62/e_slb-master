import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/appendices/10_codes_display.dart';
import 'package:flutter_complete_guide/appendices/conversion_table.dart';
import 'package:flutter_complete_guide/appendices/discription_of_person.dart';
import 'package:flutter_complete_guide/appendices/fire_prevention.dart';
import 'package:flutter_complete_guide/appendices/first_aid.dart';
import 'package:flutter_complete_guide/appendices/main_appendices.dart';
import 'package:flutter_complete_guide/appendices/national_use_of_force_framework.dart';
import 'package:flutter_complete_guide/appendices/note_taking.dart';
import 'package:flutter_complete_guide/appendices/patrols.dart';
import 'package:flutter_complete_guide/appendices/phonetic_alphabet.dart';
import 'package:flutter_complete_guide/appendices/power_of_citizen_arrest.dart';
import 'package:flutter_complete_guide/appendices/whimis.dart';

import '../widgets/main_log_entry.dart';

//import '../Bloc/DailyReportNotes/dailyreports_cubit.dart';

class AppendicesDrawer extends StatefulWidget {
  @override
  State<AppendicesDrawer> createState() => _AppendicesDrawerState();
}

class _AppendicesDrawerState extends State<AppendicesDrawer> {
  Widget _buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler as void Function()?,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(99.0)),
                        child: BlocProvider.of<UserCubit>(context)
                                    .state
                                    .userModel ==
                                null
                            ? Icon(
                                Icons.person,
                                size: 80,
                              )
                            : BlocProvider.of<UserCubit>(context)
                                        .state
                                        .userModel!
                                        .image !=
                                    null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: MemoryImage(
                                        Uint8List.fromList(
                                            BlocProvider.of<UserCubit>(context)
                                                .state
                                                .userModel!
                                                .image!
                                                .codeUnits)),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 80,
                                  ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          child: ListView(
                            children: [
                              Text(
                                "${BlocProvider.of<UserCubit>(context).state.userModel!.email.toString()}",
                                style: TextStyle(
                                    fontFamily:
                                        context.watch<UserCubit>().state.font),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          child: ListView(
                            children: [
                              Text(
                                "Name:${BlocProvider.of<UserCubit>(context).state.userModel!.name.toString()}",
                                style: TextStyle(
                                    fontFamily:
                                        context.watch<UserCubit>().state.font),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _buildListTile('Home', Icons.house, () {
              Navigator.of(context)
                  .pushReplacementNamed(MainLogEntry.routeName);
            }),
            _buildListTile('Appendices Home Page', Icons.details, () {
              Navigator.of(context)
                  .pushReplacementNamed(AppendicesMain.routeName);
            }),
            _buildListTile('Note Taking', Icons.notes, () {
              Navigator.of(context).pushReplacementNamed(NoteTaking.routeName);
            }),
            _buildListTile('Discription of Persons/Vehicles', Icons.person_3,
                () {
              Navigator.of(context)
                  .pushReplacementNamed(DiscriptionOfPerson.routeName);
            }),
            _buildListTile('Convertion table', Icons.compare, () {
              Navigator.of(context)
                  .pushReplacementNamed(ConversionTable.routeName);
            }),
            _buildListTile('10 Codes', Icons.code, () {
              Navigator.of(context)
                  .pushReplacementNamed(TenCodesDisplay.routeName);
            }),
            _buildListTile('Phonetic alphabit', Icons.abc, () {
              Navigator.of(context)
                  .pushReplacementNamed(PhoneticAlphabit.routeName);
            }),
            _buildListTile('Patrols', Icons.person_2, () {
              Navigator.of(context).pushReplacementNamed(Patrols.routeName);
            }),
            _buildListTile(
                'Fire prevention/observation', Icons.fire_extinguisher, () {
              Navigator.of(context)
                  .pushReplacementNamed(FireProvention.routeName);
            }),
            _buildListTile('WHIMIS', Icons.emergency, () {
              Navigator.of(context).pushReplacementNamed(Whimis.routeName);
            }),
            _buildListTile('National Use of Force Framwork', Icons.verified,
                () {
              Navigator.of(context)
                  .pushReplacementNamed(NationalForceFramwork.routeName);
            }),
            _buildListTile('Power of Citizen Arrest', Icons.person, () {
              Navigator.of(context)
                  .pushReplacementNamed(PowerOfCitizenArrest.routeName);
            }),
            _buildListTile('First Aid', Icons.health_and_safety, () {
              Navigator.of(context).pushReplacementNamed(FirstAid.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
