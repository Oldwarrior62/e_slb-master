import 'package:flutter/material.dart';

import '../Bloc/DailyReportNotes/dailyreports_state.dart';

Padding NotesContainer(DailyReportsState state, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 7),
            blurRadius: 7,
            spreadRadius: 3)
      ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notes:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  state.lstdailyreports[index].dateCreated.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(state.lstdailyreports[index].notes.toString()),
          ],
        ),
      ),
    ),
  );
}
