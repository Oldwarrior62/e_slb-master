import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_state.dart';
import 'package:flutter_complete_guide/models/company_model.dart';
import 'package:image_picker/image_picker.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyState());

  setCompany(Company company) {
    emit(state.copywith(company: company));
  }

  setlstCompany(List<Company> lstcompany) {
    emit(state.copywith(lstcompany: lstcompany));
  }

  setImage(XFile image) {
    emit(state.copywith(img: image));
  }
}
