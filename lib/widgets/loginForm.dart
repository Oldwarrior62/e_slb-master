import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/comm/loading.dart';
import 'package:flutter_complete_guide/widgets/main_log_entry.dart';
import '../comm/commHelper.dart';
import '../comm/genLoginSignupHeader.dart';
import '../comm/genTextFormField.dart';
import '../DatabaseHandler/DbHelper.dart';
import '../widgets/SignupForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
  static const routeName = '/login';
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = new GlobalKey<FormState>();
  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper.instance;
  }

  login() async {
    String name = _conUserId.text;
    String passwd = _conPassword.text;

    if (name.isEmpty) {
      alertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      loading(context);
      DbHelper db = DbHelper.instance;
      context.read<DailyReportsCubit>().state.lstdailyreports =
          await db.getDailyReports();
      context.read<DailyReportsCubit>().state.tempdailyreports =
          await db.getDailyReports();
      db.getLoginUser(name, passwd).then((userData) async {
        if (userData != null) {
          db.checkNotes().then((value) {
            if (value != null) {
              if (value.notes != null) {
                value.ontap = true;
                BlocProvider.of<DailyReportsCubit>(context)
                    .setDailyReports(value);
              } else {
                BlocProvider.of<DailyReportsCubit>(context)
                    .setDailyReports(value);
              }
            }
          });

          SharedPreferences sp = await SharedPreferences.getInstance();
          String? id = sp.getString('userid');
          if (id == null) {
            sp.setString("userid", userData.userId.toString());
            sp.setString('securityLisence', '');
            sp.setString('ofa', '');
          } else {
            userData.securityLicense = sp.getString('securityLisence');
            userData.ofa = sp.getString("ofa");
          }
          BlocProvider.of<UserCubit>(context).setUser(userData);
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainLogEntry()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.pop(context);
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        Navigator.pop(context);
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure log'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Login'),
                  getTextFormField(
                      controller: _conUserId,
                      icon: Icons.person,
                      hintName: 'Name'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: login,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do not have account? '),
                        TextButton(
                          child: Text(
                            'Signup',
                            selectionColor: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupForm()));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
