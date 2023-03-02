// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_complete_guide/models/company_model.dart';
import 'package:image_picker/image_picker.dart';

class CompanyState extends Equatable {
  Company? company;
  XFile? img;
  List<Company>? lstcompany = [];
  CompanyState({this.company, this.img, this.lstcompany});
  @override
  List<Object?> get props => [company, img, lstcompany];

  CompanyState copywith(
      {Company? company, XFile? img, List<Company>? lstcompany}) {
    return CompanyState(
        company: company ?? this.company,
        img: img ?? this.img,
        lstcompany: lstcompany ?? this.lstcompany);
  }
}
