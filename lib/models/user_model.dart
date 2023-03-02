final String userTable = 'user';

class UserNotes {
  static final List<String> values = [
    name,
    surname,
    email,
  ];
  static final String name = 'name';
  static final String surname = 'surname';
  static final String email = 'email';
}

class User {
  String? name;
  String? surname;
  String? email;

  User({
    this.name,
    this.surname,
    this.email,
  });

  User.fromMap(dynamic obj) {
    this.name = obj['name'];
    this.surname = obj['surname'];
    this.email = obj['email'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
    };
    return map;
  }
}
