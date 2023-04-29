import 'dart:convert';

final String companyTable = 'company';

class CompanyNotes {
  static final List<String> values = [
    companyId,
    companyName,
    companyEmail,
    logoUrl,
  ];
  static final String companyId = 'companyId';
  static final String companyName = 'companyName';
  static final String companyEmail = 'companyEmail';
  static final String logoUrl = 'logoUrl';
}

List<String> convertToString(List lst) {
  return lst.map((e) => e.toString()).toList();
}

class Company {
  int? companyId;
  String? companyName;
  String? companyEmail;
  String? image;
  List<String> lstShifts = [];
  Company(
      {this.companyId,
      this.companyName,
      this.companyEmail,
      this.image,
      required this.lstShifts});

  Company.fromMap(dynamic obj) {
    this.companyEmail = obj['companyEmail'];
    this.companyId = obj['companyId'];
    this.companyName = obj['comapnyName'];
    this.image = obj['image'];
    this.lstShifts = convertToString(jsonDecode(obj['lstShifts']));
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'companyEmail': companyEmail,
      'comapnyName': companyName,
      'image': image,
      'lstShifts': jsonEncode(lstShifts)
    };
    return map;
  }
}
