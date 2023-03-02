import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Notes/notesState.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesState(isedit: false, lstNotes: []));

  setNote(Notes notes) async {
    emit(state.copywith(notes: notes));
  }

  setIsEdit(bool isedit) {
    emit(state.copywith(
      isedit: isedit,
    ));
  }

  setlstNote(List<Notes> lst) {
    emit(state.copywith(lstNotes: lst));
  }
}
