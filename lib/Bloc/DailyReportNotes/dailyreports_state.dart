// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_complete_guide/models/daily_report_model.dart';
import 'package:screenshot/screenshot.dart';

class DailyReportsState extends Equatable {
  DailyReportNotes? dailyReportNotes;
  List<DailyReportNotes> lstdailyreports;
  List<DailyReportNotes> tempdailyreports;
  bool log;
  bool isedit, filter;
  String weather, location;
  ScreenshotController screenshotController;
  String? currentValue;

  DailyReportsState(
      {this.dailyReportNotes,
      required this.lstdailyreports,
      required this.tempdailyreports,
      required this.log,
      required this.isedit,
      required this.weather,
      required this.location,
      required this.filter,
      required this.screenshotController,
      this.currentValue});
  @override
  List<Object?> get props => [
        dailyReportNotes,
        lstdailyreports,
        log,
        isedit,
        weather,
        location,
        tempdailyreports,
        filter,
        screenshotController,
        currentValue
      ];

  DailyReportsState copywith(
      {DailyReportNotes? dailyReportNotes,
      List<DailyReportNotes>? lstdailyreports,
      bool? log,
      bool? isedit,
      filter,
      String? weather,
      location,
      ScreenshotController? screenshotController,
      List<DailyReportNotes>? tempdailyreports,
      String? currentValue}) {
    return DailyReportsState(
        dailyReportNotes: dailyReportNotes ?? this.dailyReportNotes,
        lstdailyreports: lstdailyreports ?? this.lstdailyreports,
        log: log ?? this.log,
        isedit: isedit ?? this.isedit,
        weather: weather ?? this.weather,
        location: location ?? this.location,
        filter: filter ?? this.filter,
        tempdailyreports: tempdailyreports ?? this.tempdailyreports,
        screenshotController: screenshotController ?? this.screenshotController,
        currentValue: currentValue ?? this.currentValue);
  }
}
