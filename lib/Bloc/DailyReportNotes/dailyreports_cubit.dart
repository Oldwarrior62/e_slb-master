import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_state.dart';
import 'package:flutter_complete_guide/models/daily_report_model.dart';
import 'package:screenshot/screenshot.dart';

class DailyReportsCubit extends Cubit<DailyReportsState> {
  DailyReportsCubit()
      : super(DailyReportsState(
            lstdailyreports: [],
            log: false,
            isedit: false,
            weather: '',
            location: '',
            tempdailyreports: [],
            filter: false,
            screenshotController: ScreenshotController()));

  setDailyReports(DailyReportNotes dailyReportsState) {
    emit(state.copywith(company: dailyReportsState));
  }

  setListDailyReports(List<DailyReportNotes> dailyReportsState, bool islog) {
    List<DailyReportNotes> temp = [];
    for (DailyReportNotes i in dailyReportsState) {
      temp.add(i);
    }
    emit(state.copywith(
        tempdailyreports: temp,
        lstdailyreports: dailyReportsState,
        log: !islog));
  }

  setIsEdit(bool isedit) {
    emit(state.copywith(
      isedit: isedit,
    ));
  }

  setFilter(bool val) {
    emit(state.copywith(
        filter: val, screenshotController: state.screenshotController));
  }

  setScreenShotController() {
    emit(state.copywith(screenshotController: ScreenshotController()));
  }

  setTempList(String text) {
    List<DailyReportNotes> temp = [];
    for (DailyReportNotes i in state.lstdailyreports) {
      DailyReportNotes d = DailyReportNotes(
          notes: i.notes,
          dailyReportId: i.dailyReportId,
          dateCreated: i.dateCreated,
          logs: i.logs,
          signature: i.signature);
      temp.add(d);
    }
    if (state.filter) {
      for (DailyReportNotes dailyReportNotes in state.lstdailyreports) {
        List<Log> lst = [];
        for (Log i in dailyReportNotes.logs) {
          if (i.company!.contains(text)) {
            lst.add(i);
          }
        }

        if (lst.length == 0) {
          temp.removeWhere((element) =>
              element.dailyReportId == dailyReportNotes.dailyReportId);
        } else {
          if (state.tempdailyreports.length > 0) {
            temp
                .where((element) =>
                    element.dailyReportId == dailyReportNotes.dailyReportId)
                .first
                .logs = lst;
          }
        }
      }
    } else {
      temp = temp.where((e) => e.dateCreated!.contains(text)).toList();
    }
    emit(state.copywith(
        tempdailyreports: temp,
        lstdailyreports: state.lstdailyreports,
        screenshotController: state.screenshotController));
  }
  // setLog(bool log) {
  //   emit(state.copywith(log: log));
  // }
}
