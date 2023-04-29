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
    emit(state.copywith(dailyReportNotes: dailyReportsState));
  }

  setListDailyReports(List<DailyReportNotes> dailyReportsState, bool islog) {
    List<DailyReportNotes> temp = [];
    for (DailyReportNotes i in dailyReportsState) {
      // i.logs.sort((a, b) {
      //   int nameComparison = a.company!.compareTo(b.company!);
      //   return nameComparison;
      // });
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
          weather: i.weather,
          location: i.location,
          company: i.company,
          logo: i.logo);
      temp.add(d);
    }
    if (state.filter) {
      temp = temp
          .where((element) => element.company!
              .toLowerCase()
              .toString()
              .contains(text.toLowerCase()))
          .toList();
    } else {
      temp = temp.where((e) => e.dateCreated!.contains(text)).toList();
    }
    emit(state.copywith(
        tempdailyreports: temp,
        lstdailyreports: state.lstdailyreports,
        screenshotController: state.screenshotController));
  }

  setLocation(String location) {
    emit(state.copywith(location: location));
  }

  setWeather(String weather) {
    emit(state.copywith(weather: weather));
  }
  // setLog(bool log) {
  //   emit(state.copywith(log: log));
  // }
}
