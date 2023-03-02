import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/report_model.dart';

class LogEntryItem extends StatelessWidget {
  final bool isLandScape;
  final MediaQueryData mediaQuery;
  final ReportInformation logEntry;
  final double curScaleFactor;
  final Function strikeOutLog;

  const LogEntryItem({
    Key? key,
    required this.isLandScape,
    required this.mediaQuery,
    required this.logEntry,
    required this.curScaleFactor,
    required this.strikeOutLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 40,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 1.5, color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isLandScape)
            Container(
              height: mediaQuery.size.height * 0.08,
              margin: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(1.5),
              child:
                  //display for current time log entry is submitted
                  //this is automatically done in 24 hour clock
                  Text(
                DateFormat.Hm().format(logEntry.createdTime!),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16 * curScaleFactor,
                ),
              ),
            ),
          if (!isLandScape)
            Row(
              children: [
                Container(
                  alignment: Alignment(0.0, -1.0),
                  //   height: mediaQuery.size.height * 0.08,
                  margin: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(width: 2),
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 5),
                  child:
                      //display for current time log entry is submitted
                      //this is automatically done in 24 hour clock
                      Text(
                    DateFormat.Hm().format(logEntry.createdTime!),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16 * curScaleFactor,
                    ),
                  ),
                ),
              ],
            ),

          //text submited by user in the log entry field
          //curently hard coded in

          Container(
            width: mediaQuery.size.width * 0.6,
            // height: mediaQuery.size.height * 0.08,

            child: Text(
              logEntry.logEntry!,
              style: TextStyle(fontSize: 12 * curScaleFactor),
              maxLines: 10,
            ),
          ),

          mediaQuery.size.width > 360
              ? TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(color: Colors.red, width: 5),
                  ),
                  onPressed: () => strikeOutLog(logEntry.reportInformationId),
                  icon: Icon(Icons.delete),
                  label: const Text('Delete'),
                )
              : IconButton(
                  onPressed: () => strikeOutLog(logEntry.reportInformationId),
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
        ],
      ),
    );
  }
}
