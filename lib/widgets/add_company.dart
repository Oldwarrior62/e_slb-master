import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/models/company_model.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:image_picker/image_picker.dart';
import '../Bloc/User/userCubit.dart';
import '../comm/genTextFormField.dart';

class AddCompanyScreen extends StatelessWidget {
  const AddCompanyScreen({Key? key}) : super(key: key);
  static const routeName = '/email';
  @override
  Widget build(BuildContext context) {
    TextEditingController companyName = TextEditingController();
    TextEditingController companyEmail = TextEditingController();
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    XFile? img;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Add Company",
        style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
      )),
      drawer: Drawer(
        child: MainDrawer(
          lstcompany: companyProvider.state.lstcompany ?? [],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Builder(builder: (context) {
                return InkWell(
                  onTap: () async {
                    img = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (img != null)
                      context.read<CompanyCubit>().setImage(img!);
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99.0),
                        border: Border.all(color: Colors.black)),
                    child: context.watch<CompanyCubit>().state.img == null
                        ? Icon(
                            Icons.person,
                            size: 50,
                          )
                        : CircleAvatar(
                            backgroundImage: MemoryImage(
                              File(context
                                      .watch<CompanyCubit>()
                                      .state
                                      .img!
                                      .path)
                                  .readAsBytesSync(),
                            ),
                          ),
                  ),
                );
              }),
              const SizedBox(
                height: 15,
              ),
              getTextFormField(
                  controller: companyName,
                  icon: Icons.person,
                  hintName: 'Company Name'),
              const SizedBox(
                height: 10,
              ),
              getTextFormField(
                  controller: companyEmail,
                  icon: Icons.person,
                  hintName: 'Company Email'),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: TextButton(
                  child: Text(
                    'Add Company',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    DbHelper db = DbHelper.instance;
                    if (companyName.text.isNotEmpty) {
                      Company company = Company(
                          companyEmail: companyEmail.text,
                          companyName: companyName.text,
                          image: context.read<CompanyCubit>().state.img == null
                              ? null
                              : String.fromCharCodes(File(context
                                      .read<CompanyCubit>()
                                      .state
                                      .img!
                                      .path)
                                  .readAsBytesSync()));
                      await db.insertCompanyData(company).then((value) {
                        List<Company> templst =
                            context.read<CompanyCubit>().state.lstcompany ?? [];
                        templst.add(company);
                        context.read<CompanyCubit>().setlstCompany(templst);
                        alertDialog(context, "Company Added");
                      });
                    } else {
                      alertDialog(context, "Company Name required");
                    }
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
