import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userState.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(islisence: false, isdyslexic: false));

  setUser(UserModel userModel) {
    state.userModel = userModel;
  }

  setIsLisence(bool islisence) {
    emit(state.copywith(islisence: islisence));
  }

  setIsDyslexic(bool val) {
    emit(state.copywith(isdyslexic: val));
  }

  setImage(XFile image) {
    emit(state.copywith(img: image));
  }
}
