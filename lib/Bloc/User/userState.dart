// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class UserState extends Equatable {
  @override
  List<Object?> get props => [
        userModel,
        islisence,
        img,
        isDyslexic,
        securityWarning,
        ofaWarning,
        isWarning,
        font,
        position,
        isUpdate
      ];

  UserModel? userModel;
  bool islisence;
  XFile? img;
  bool isDyslexic;
  bool? securityWarning;
  bool? ofaWarning;
  bool isWarning;
  String font;
  Position? position;
  bool? isUpdate;
  UserState(
      {this.userModel,
      required this.islisence,
      this.img,
      required this.isDyslexic,
      required this.securityWarning,
      required this.ofaWarning,
      required this.isWarning,
      required this.font,
      this.position,
      required this.isUpdate});

  UserState copywith(
      {UserModel? userModel,
      bool? islisence,
      XFile? img,
      bool? isDyslexic,
      bool? securityWarning,
      bool? ofaWarning,
      bool? isWarning,
      String? font,
      Position? position,
      bool? isupdate}) {
    return UserState(
        userModel: userModel ?? this.userModel,
        img: img ?? this.img,
        islisence: islisence ?? this.islisence,
        isDyslexic: isDyslexic ?? this.isDyslexic,
        securityWarning: securityWarning ?? this.securityWarning,
        ofaWarning: ofaWarning ?? this.ofaWarning,
        isWarning: isWarning ?? this.isWarning,
        font: font ?? this.font,
        position: position ?? this.position,
        isUpdate: isupdate ?? this.isUpdate);
  }
}
