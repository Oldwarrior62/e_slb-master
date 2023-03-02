// this page is using user_information have to cross this over to the database
// this page will be use one time to create a single user for a stand alone app
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/Company/company_cubit.dart';
import 'main_drawer.dart';
import '../models/user_model.dart';

class UserForm extends StatefulWidget {
  static const routeName = '/user';

  @override
  State<UserForm> createState() => _UserState();
}

class _UserState extends State<UserForm> {
  final _nameFocusNode = FocusNode();
  final _surnameFocusNode = FocusNode();
  final _licenseExpiryDateFocusNode = FocusNode();
  final _companyNameFocusNode = FocusNode();
  final _siteLocationFocusNode = FocusNode();
  final _logoUrlFocusNode = FocusNode();

  final _dateController = TextEditingController();
  final _imageUrlControler = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameControler = TextEditingController();
  final _licenseExpiryDateController = TextEditingController();
  final _companyNameControler = TextEditingController();
  final _siteLocationControler = TextEditingController();

  final _form = GlobalKey<FormState>();

  var _editedUser = User(
    name: '',
    surname: '',
    email: '',
  );

  @override
  void initState() {
    _logoUrlFocusNode.addListener(_updateLogoUrl);
    super.initState();
  }

  @override
  void dispose() {
    _logoUrlFocusNode.removeListener(_updateLogoUrl);
    _surnameFocusNode.dispose();
    _companyNameFocusNode.dispose();
    _licenseExpiryDateFocusNode.dispose();
    _siteLocationFocusNode.dispose();
    _logoUrlFocusNode.dispose();

    _dateController.dispose();
    _imageUrlControler.dispose();
    _companyNameControler.dispose();
    _dateController.dispose();
    _imageUrlControler.dispose();
    _nameController.dispose();
    _surnameControler.dispose();
    _licenseExpiryDateController.dispose();

    super.dispose();
  }

  void _updateLogoUrl() {
    if (!_logoUrlFocusNode.hasFocus) {
      if (!_imageUrlControler.text.startsWith('http') &&
              !_imageUrlControler.text.startsWith('https') ||
          !_imageUrlControler.text.endsWith('png') &&
              !_imageUrlControler.text.endsWith('jpg') &&
              !_imageUrlControler.text.endsWith('jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _savedForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(_editedUser.name);
    print(_editedUser.surname);
  }

  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New user'),
        actions: [
          IconButton(
            onPressed: _savedForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(
        lstcompany: companyProvider.state.lstcompany ?? [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_nameFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedUser = User(
                      name: value,
                      surname: _editedUser.surname,
                    );
                  },
                ),
                TextFormField(
                  controller: _surnameControler,
                  decoration: InputDecoration(labelText: 'Surname'),
                  textInputAction: TextInputAction.next,
                  focusNode: _nameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_surnameFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a last name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedUser = User(
                      name: _editedUser.name,
                      surname: value,
                    );
                  },
                ),
                TextFormField(
                  controller: _licenseExpiryDateController,
                  decoration: InputDecoration(labelText: 'License expiry date'),
                  textInputAction: TextInputAction.next,
                  focusNode: _nameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_surnameFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the date your security license expirers on.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _editedCompany = Company(
                    //   logoUrl: value,
                    // );
                  },
                ),
                TextFormField(
                  controller: _companyNameControler,
                  decoration: InputDecoration(labelText: 'Company Name'),
                  textInputAction: TextInputAction.next,
                  focusNode: _companyNameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_siteLocationFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a company name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _editedCompany = Company(
                    //   companyName: value,
                    // );
                  },
                ),
                TextFormField(
                  controller: _siteLocationControler,
                  decoration: InputDecoration(labelText: 'Site Location'),
                  textInputAction: TextInputAction.next,
                  focusNode: _logoUrlFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a site location';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _editedLocation = Location(
                    //   location: value,
                    //   locationId: _editedLocation.locationId,
                    //);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlControler.text.isEmpty
                          ? Text(
                              'Company Logo',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            )
                          : FittedBox(
                              child: Image.network(_imageUrlControler.text),
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Logo URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlControler,
                        focusNode: _logoUrlFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a company logo URL';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'please inter a valid company log URl';
                          }
                          if (!value.endsWith('png') &&
                              !value.endsWith('jpg') &&
                              !value.endsWith('jpeg')) {
                            return 'please inter a valid company log URl';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // _editedCompany = Company(
                          //   companyName: _editedCompany.companyName,
                          //   logoUrl: value,
                          // );
                        },
                        onFieldSubmitted: (_) {
                          _savedForm();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
