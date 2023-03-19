// ignore_for_file: equal_keys_in_map

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/Notes/notesCubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userState.dart';
import 'package:flutter_complete_guide/appendices/10_codes_display.dart';
import 'package:flutter_complete_guide/widgets/detail.dart';
import 'package:flutter_complete_guide/widgets/google_map.dart';
import 'package:flutter_complete_guide/widgets/signature.dart';
import 'package:flutter_complete_guide/widgets/splash_screen.dart';
import 'package:flutter_complete_guide/widgets/updateProfile.dart';
import 'package:flutter_complete_guide/widgets/add_company.dart';
import 'package:flutter_complete_guide/widgets/view_notes.dart';
import './widgets/main_log_entry.dart';
import 'appendices/conversion_table.dart';
import 'appendices/discription_of_person.dart';
import 'appendices/fire_prevention.dart';
import 'appendices/first_aid.dart';
import 'appendices/main_appendices.dart';
import 'appendices/national_use_of_force_framework.dart';
import 'appendices/note_taking.dart';
import 'appendices/patrols.dart';
import 'appendices/phonetic_alphabet.dart';
import 'appendices/power_of_citizen_arrest.dart';
import 'appendices/whimis.dart';
import 'widgets/user_form.dart';
import 'widgets/LoginForm.dart';

//import 'widgets/main_log_entry.dart';
StreamController<bool> isDyslexic = StreamController();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => UserCubit())),
        BlocProvider(
          create: ((context) => CompanyCubit()),
        ),
        BlocProvider(
          create: ((context) => NotesCubit()),
        ),
        BlocProvider(
          create: ((context) => DailyReportsCubit()),
        )
      ],
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-SLB',
          theme: state.isDyslexic
              ? ThemeData(
                  fontFamily: 'OpenDyslexic',
                  textTheme: ThemeData.light().textTheme.copyWith(
                        subtitle1: TextStyle(
                          fontFamily: 'OpenDyslexic',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        button: TextStyle(color: Colors.white),
                      ),
                  appBarTheme: AppBarTheme(
                    toolbarTextStyle: ThemeData.light()
                        .textTheme
                        .copyWith(
                          subtitle2: TextStyle(
                            fontFamily: 'OpenDyslexic',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        .bodyText2,
                    titleTextStyle: ThemeData.light()
                        .textTheme
                        .copyWith(
                          subtitle2: TextStyle(
                            fontFamily: 'OpenDyslexic',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        .headline6,
                  ),
                  colorScheme:
                      ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                          .copyWith(secondary: Colors.amber))
              : ThemeData(
                  colorScheme:
                      ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                          .copyWith(secondary: Colors.amber)),
          // home: LogIn(),
          routes: {
            '/': (ctx) => SplashScreen(),
            '/log_in': (ctx) => LoginForm(),
            MainLogEntry.routeName: (ctx) => MainLogEntry(),
            UserForm.routeName: (ctx) => UserForm(),
            AddCompanyScreen.routeName: ((context) => AddCompanyScreen()),
            UpdateProfile.routeName: ((context) => UpdateProfile()),
            ViewNotes.routeName: ((context) => ViewNotes()),
            SignatureScreen.routeName: ((context) => SignatureScreen()),
            GetLocation.routeName: ((context) => GetLocation()),
            SignatureScreen.routeName: (context) => SignatureScreen(),
            AppendicesMain.routeName: (context) => AppendicesMain(),
            DiscriptionOfPerson.routeName: (context) => DiscriptionOfPerson(),
            FireProvention.routeName: (context) => FireProvention(),
            FirstAid.routeName: (context) => FirstAid(),
            NationalForceFramwork.routeName: (context) =>
                NationalForceFramwork(),
            NoteTaking.routeName: (context) => NoteTaking(),
            Patrols.routeName: (context) => Patrols(),
            PhoneticAlphabit.routeName: (context) => PhoneticAlphabit(),
            PowerOfCitizenArrest.routeName: (context) => PowerOfCitizenArrest(),
            Whimis.routeName: (context) => Whimis(),
            ConversionTable.routeName: (context) => ConversionTable(),
            AppendicesMain.routeName: (context) => AppendicesMain(),
            TenCodesDisplay.routeName: (context) => TenCodesDisplay(),
            GetLocation.routeName: ((context) => GetLocation()),
            DetailScreen.routeName: (context) => DetailScreen(),
          },
        ),
      ),
    );
  }
}
