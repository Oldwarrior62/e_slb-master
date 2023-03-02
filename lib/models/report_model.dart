final String reportInformationTable = 'reportInformation';

class reportInformationNotes {
  static final List<String> values = [
    reportInformationId,
    logEntry,
    createdTime,
  ];
  static final String reportInformationId = 'reportInformationId';
  static final String logEntry = 'logEntry';
  static final String createdTime = 'createdTime';
}

class ReportInformation {
  String? reportInformationId;
  String? logEntry;
  DateTime? createdTime;

  ReportInformation({
    this.reportInformationId,
    this.logEntry,
    this.createdTime,
  });

  ReportInformation.fromMap(dynamic obj) {
    this.createdTime = obj['createdTime'];
    this.logEntry = obj['logEntry'];
    this.reportInformationId = obj['reportInformationId'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'reportInformationId': reportInformationId,
      'logEntry': logEntry,
      'createdTime': createdTime,
    };
    return map;
  }
}
