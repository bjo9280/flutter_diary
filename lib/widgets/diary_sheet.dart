import 'package:diary/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:drift/drift.dart' hide Column;

class DiarySheet extends StatefulWidget {
  final DateTime selectedDate;

  const DiarySheet({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  State<DiarySheet> createState() => _DiarySheetState();
}

class _DiarySheetState extends State<DiarySheet> {
  late DateTime date;

  TextEditingController emptyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    date = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showConfirmationDialog(context, date);
              print('Delete button pressed');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("${_formattedDate(date)}"),
              onPressed: () {
                _selectDate(context);
              },
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildDiaryEntries(),
                  ElevatedButton(
                    onPressed: () {
                      _saveDiaryEntry(date);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      setState(() {
        date = selectedDate;
      });
    }
  }

  Widget _buildDiaryEntries() {
    return StreamBuilder<List<DiaryDbData>>(
      stream: GetIt.I<LocalDatabase>().watchSchedules(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error state
          return Text('Error: ${snapshot.error}');
        } else {
          // Data loaded successfully
          final diaryDataList = snapshot.data ?? [];
          if (diaryDataList.isEmpty) {
            return TextFormField(
              controller: emptyController,
              keyboardType: TextInputType.multiline,
              maxLines: 25,
              decoration: InputDecoration(
                hintText: '입력해주세요.',
                // Display hintText only if there are no entries
              ),
            );
          } else {
            return TextFormField(
              controller: getControllerText(diaryDataList[0].content),
              keyboardType: TextInputType.multiline,
              maxLines: 25,
              decoration: InputDecoration(
                hintText: '입력해주세요.',
                // Display hintText only if there are no entries
              ),
            );
          }
        }
      },
    );
  }

  void _saveDiaryEntry(DateTime date) async {
    try {
      await GetIt.I<LocalDatabase>().removeSchedule(date);
      await GetIt.I<LocalDatabase>().createSchedule(
        DiaryDbCompanion(
          content: Value(emptyController.text),
          date: Value(date),
        ),
      );
      print('Diary entry saved successfully.');
    } catch (e) {
      print('Failed to save diary entry: $e');
    }
  }

  Future<void> _showConfirmationDialog(
      BuildContext context, DateTime date) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('일정을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                // 취소 버튼 클릭 시, 알림창 닫기만 수행
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 확인 버튼 클릭 시, 일정 삭제 후 알림창 닫기와 뒤로 가기 수행
                GetIt.I<LocalDatabase>().removeSchedule(date);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  TextEditingController getControllerText(text) {
    emptyController = TextEditingController(text: text);
    return emptyController;
  }

  String _formattedDate(DateTime date) {
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
