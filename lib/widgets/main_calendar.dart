import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:diary/widgets/diary_sheet.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  MainCalendar({
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // onDaySelected: onDaySelected,
      onDaySelected: (selectedDate, focusedDate) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DiarySheet(selectedDate: selectedDate),
          ),
        );
      },
      selectedDayPredicate: (date) {
        return isSameDay(selectedDate, date);
      },
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2200, 1, 1),
      focusedDay: DateTime.now(),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
