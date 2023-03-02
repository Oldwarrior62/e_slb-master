// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class NotesState extends Equatable {
  Notes? notes;
  bool isedit;
  List<Notes> lstNotes = [];
  NotesState({this.notes, required this.isedit, required this.lstNotes});

  @override
  List<Object?> get props => [notes, isedit];

  NotesState copywith({Notes? notes, bool? isedit, List<Notes>? lstNotes}) {
    return NotesState(
        notes: notes ?? this.notes,
        isedit: isedit ?? this.isedit,
        lstNotes: lstNotes ?? this.lstNotes);
  }
}

class Notes {
  String? note;
  String? date;
  bool? ontap;

  Notes({this.note, this.date, this.ontap});

  factory Notes.fromjson(Map<String, dynamic> mp) {
    return Notes(note: mp['notes'], date: mp['date']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = {};
    mp["notes"] = note;
    mp["date"] = date;
    return mp;
  }
}
