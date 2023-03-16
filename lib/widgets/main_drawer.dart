// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_state.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';

import 'package:flutter_complete_guide/widgets/add_company.dart';
import 'package:flutter_complete_guide/widgets/google_map.dart';
import 'package:flutter_complete_guide/widgets/loginForm.dart';
import 'package:flutter_complete_guide/widgets/main_log_entry.dart';
import 'package:flutter_complete_guide/widgets/signature.dart';
import 'package:flutter_complete_guide/widgets/updateProfile.dart';
import 'package:flutter_complete_guide/widgets/view_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bloc/Company/company_cubit.dart';
import '../models/company_model.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({required this.lstcompany});
  List<Company> lstcompany = [];
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List<DropdownMenuItem<Company>> getitems() {
    return widget.lstcompany
        .map((e) => DropdownMenuItem(
              child: Text(e.companyName.toString()),
              value: e,
            ))
        .toList();
  }

  Widget _buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: context.watch<UserCubit>().state.font),
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
            // Container(
            //   height: 120,
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(20),
            //   alignment: Alignment.centerLeft,
            //   color: Theme.of(context).colorScheme.secondary,
            //   child: Text(
            //     'Security log book',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w900,
            //       fontSize: 30,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            _buildListTile('Home', Icons.house, () {
              Navigator.of(context)
                  .pushReplacementNamed(MainLogEntry.routeName);
            }),
            _buildListTile('Update Profile', Icons.update, () {
              Navigator.of(context)
                  .pushReplacementNamed(UpdateProfile.routeName);
            }),
            _buildListTile('Add Company', Icons.house, () {
              Navigator.of(context)
                  .pushReplacementNamed(AddCompanyScreen.routeName);
            }),
            BlocBuilder<CompanyCubit, CompanyState>(builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 30),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<Company>(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Select Company"),
                    isExpanded: true,
                    items: getitems(),
                    onChanged: (value) {
                      context.read<CompanyCubit>().setCompany(value!);
                    },
                    value: state.company,
                  ),
                ),
              );
            }),
            _buildListTile('View Notes', Icons.view_agenda, () {
              Navigator.of(context).pushReplacementNamed(ViewNotes.routeName);
            }),
            _buildListTile('Signature', Icons.verified, () {
              Navigator.of(context)
                  .pushReplacementNamed(SignatureScreen.routeName);
            }),
            _buildListTile('Get Location', Icons.map, () {
              Navigator.of(context).pushReplacementNamed(GetLocation.routeName);
            }),
            _buildListTile('Log Out', Icons.logout, () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              await sp.setString('userData', "");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginForm()),
                  (Route<dynamic> route) => false);
            }),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   child: Text(
            //     'Preferances',
            //     style: TextStyle(
            //         fontFamily: context.watch<UserCubit>().state.font,
            //         fontSize: 18),
            //   ),
            // ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  // Builder(builder: (context) {
                  //   return SwitchListTile(
                  //     title: Text(
                  //       'Show Lisence',
                  //       style: TextStyle(
                  //           fontFamily: context.watch<UserCubit>().state.font),
                  //     ),
                  //     onChanged: (bool value) {
                  //       context.read<UserCubit>().setIsLisence(value);
                  //     },
                  //     value: context.watch<UserCubit>().state.islisence,
                  //   );
                  // }),

                  // Builder(builder: (context) {
                  //   return SwitchListTile(
                  //     title: Text(
                  //       'Show Warning',
                  //       style: TextStyle(
                  //           fontFamily: context.watch<UserCubit>().state.font),
                  //     ),
                  //     onChanged: (bool value) {
                  //       context.read<UserCubit>().setWarning(value);
                  //     },
                  //     value: context.watch<UserCubit>().state.isWarning,
                  //   );
                  // }),

                  // _buildListTileSwitch(
                  //   '24 clock',
                  //   'select 24 hour or standard time.',
                  //   _isTwentyFourHour,
                  //   (newValue) {
                  //     setState(() {
                  //       _isTwentyFourHour = newValue;
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
