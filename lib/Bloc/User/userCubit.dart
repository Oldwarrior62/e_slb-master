import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userState.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : super(UserState(
            islisence: false,
            isDyslexic: false,
            securityWarning: false,
            ofaWarning: false,
            isWarning: false,
            font: '',
            isUpdate: false));

  setUser(UserModel userModel) {
    emit(state.copywith(userModel: userModel));
  }

  isUpdate(bool val) {
    emit(state.copywith(isupdate: val));
  }

  setIsLisence(bool islisence) {
    emit(state.copywith(islisence: islisence));
  }

  setImage(XFile image) {
    emit(state.copywith(img: image));
  }

  setIsDyslexic(bool isDyslexic) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('dyslexic', isDyslexic);
    if (isDyslexic) {
      setFont("OpenDyslexic");
    } else {
      setFont("OpenSans");
    }

    emit(state.copywith(isDyslexic: isDyslexic));
  }

  setSecurityWarning(bool warn) {
    emit(state.copywith(securityWarning: warn));
  }

  setOfaWarning(bool warn) {
    emit(state.copywith(ofaWarning: warn));
  }

  setWarning(bool warn, {bool? iswarn}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('warn', warn);

    emit(state.copywith(isWarning: warn));
  }

  setWarningTwoWeeks(bool warn, bool isSecurity, {bool? iswarn}) async {
    String Date = DateTime.now().toString().split(' ')[0];
    if (isSecurity) {
      if (warn == true) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('warntwoweeksecurity', Date);
      } else {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('warntwoweeksecurity', "");
      }
    } else {
      if (warn == true) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('warntwoweekofa', Date);
      } else {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('warntwoweekofa', "");
      }
    }

    emit(state.copywith(isWarning: iswarn ?? warn));
  }

  setFont(String font) async {
    emit(state.copywith(font: font));
  }

  setPosition(Position position) {
    emit(state.copywith(position: position));
  }
}
