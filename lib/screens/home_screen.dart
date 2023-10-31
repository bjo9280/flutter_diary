import 'package:diary/widgets/main_calendar.dart';
import 'package:flutter/material.dart';
import 'package:diary/widgets/diary_sheet.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

  @override
  State<MyDiaryScreen> createState() => _MyCalendarScreenState();
}

class _MyCalendarScreenState extends State<MyDiaryScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('menu button is clicked');
          },
        ),
        title: Text('Diary'),
      ),
      body: Center(
          child: SizedBox(
              width: screenWidth * 0.9,
              height: screenHeight * 0.7,
              child: MainCalendar(
                selectedDate: selectedDate,
                onDaySelected: onDaySelected,
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DiarySheet(selectedDate: selectedDate)),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
