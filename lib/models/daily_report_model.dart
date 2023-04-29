import 'dart:convert';

final String dailyReportTable = 'dailyReport';

class DailyReportNotes {
  String? notes;
  int? dailyReportId;
  String? dateCreated;
  bool? ontap;
  String? weather;
  String? company;
  String? location;
  String? logo;
  List<Log> logs;

  DailyReportNotes(
      {required this.notes,
      required this.dailyReportId,
      required this.dateCreated,
      required this.logs,
      this.ontap,
      this.weather,
      this.company,
      this.location,
      this.logo});

  factory DailyReportNotes.fromJson(Map<String, dynamic> mp) {
    return DailyReportNotes(
      notes: mp['notes'],
      dailyReportId: mp['dailyReportId'],
      dateCreated: mp['dateCreated'],
      logs: mp['logs'] == null ? [] : lstlog(jsonDecode(mp['logs'])),
      weather: mp['weather'],
      company: mp['company'],
      location: mp['location'],
      logo: mp["logo"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = {};
    mp['notes'] = notes;
    mp['dateCreated'] = dateCreated;
    mp['logs'] = jsonEncode(lstlogtpmap(logs));
    mp['weather'] = weather;
    mp['company'] = company;
    mp['location'] = location;
    mp['logo'] = logo;
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
  int? reportInformation;

  bool? isline;

  Log(this.log, this.timeCreated, this.reportInformation,
      {required this.isline});

  Log.fromMap(dynamic obj) {
    this.log = obj['log'];
    this.timeCreated = obj['timeCreated'];
    this.isline = obj['isline'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'log': log,
      'timeCreated': timeCreated,
      'isline': isline
    };
    return map;
  }
}
