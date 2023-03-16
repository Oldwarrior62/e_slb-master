import 'dart:convert';

final String dailyReportTable = 'dailyReport';

class DailyReportNotes {
  String? notes;
  int? dailyReportId;
  String? signature;
  String? dateCreated;
  bool? ontap;

  List<Log> logs;

  DailyReportNotes(
      {required this.notes,
      required this.dailyReportId,
      required this.dateCreated,
      required this.logs,
      this.ontap,
      required this.signature});

  factory DailyReportNotes.fromJson(Map<String, dynamic> mp) {
    return DailyReportNotes(
        notes: mp['notes'],
        dailyReportId: mp['dailyReportId'],
        dateCreated: mp['dateCreated'],
        logs: mp['logs'] == null ? [] : lstlog(jsonDecode(mp['logs'])),
        signature: mp['signature']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = {};
    mp['notes'] = notes;
    mp['dateCreated'] = dateCreated;
    mp['logs'] = jsonEncode(lstlogtpmap(logs));
    mp['signature'] = signature;
    return mp;
  }
}

List<Log> lstlog(List data) {
  return data.map((e) => Log.fromMap(e)).toList();
}

List<Map<String, dynamic>> lstlogtpmap(List<Log> data) {
  return data.map((e) => e.toMap()).toList();
}

class Log {
  String? log;
  String? timeCreated;
  String? weather;
  String? company;
  String? location;
  int? reportInformation;
  String? logo;
  bool? isline;

  Log(this.log, this.timeCreated, this.weather, this.company, this.location,
      this.reportInformation, this.logo,
      {required this.isline});

  Log.fromMap(dynamic obj) {
    this.log = obj['log'];
    this.timeCreated = obj['timeCreated'];
    this.weather = obj['weather'];
    this.company = obj['companyName'];
    this.location = obj['location'];
    this.logo = obj['logo'];
    this.isline = obj['isline'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'log': log,
      'timeCreated': timeCreated,
      'weather': weather,
      'companyName': company,
      'location': location,
      'logo': logo,
      'isline': isline
    };
    return map;
  }
}
