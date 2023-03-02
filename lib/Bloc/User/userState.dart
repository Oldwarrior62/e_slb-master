// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:image_picker/image_picker.dart';

class UserState extends Equatable {
  @override
  List<Object?> get props => [userModel, islisence, img, isdyslexic];

  UserModel? userModel;
  bool islisence;
  XFile? img;
  bool? isdyslexic;
  UserState(
      {this.userModel,
      required this.islisence,
      this.img,
      required this.isdyslexic});

  UserState copywith(
      {UserModel? userModel, bool? islisence, XFile? img, bool? isdyslexic}) {
    return UserState(
        userModel: userModel ?? this.userModel,
        img: img ?? this.img,
        islisence: islisence ?? this.islisence,
        isdyslexic: isdyslexic ?? this.isdyslexic);
  }
}
