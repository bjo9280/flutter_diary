import 'package:diary/database/drift_database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/diary_db_model.dart';

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

  TextEditingController contentController = TextEditingController();

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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
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

  // Widget _buildDiaryEntries() {
  //   return StreamBuilder<List<DiaryDbData>>(
  //     stream: GetIt.I<LocalDatabase>().watchSchedules(date),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // Loading state
  //         return CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         // Error state
  //         return Text('Error: ${snapshot.error}');
  //       } else {
  //         // Data loaded successfully
  //         final diaryDataList = snapshot.data ?? [];
  //         diaryDataList.sort((a, b) => a.create.compareTo(b.create));
  //
  //         for (var i in diaryDataList) {
  //           print(i);
  //         }
  //         if (diaryDataList.isEmpty) {
  //           return TextFormField(
  //             controller: contentController,
  //             keyboardType: TextInputType.multiline,
  //             maxLines: 25,
  //             decoration: InputDecoration(
  //               hintText: '입력해주세요.',
  //               // Display hintText only if there are no entries
  //             ),
  //           );
  //         } else {
  //           return TextFormField(
  //             controller: getControllerText(diaryDataList.last.content),
  //             keyboardType: TextInputType.multiline,
  //             maxLines: 25,
  //             decoration: InputDecoration(
  //               hintText: '입력해주세요.',
  //               // Display hintText only if there are no entries
  //             ),
  //           );
  //         }
  //       }
  //     },
  //   );
  // }

  Widget _buildDiaryEntries() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('diary')
          .where('date',
              isEqualTo: DateFormat('yyyy-MM-dd').format(
                  date)) // Adjust this condition based on your data model
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error state
          return Text('Error: ${snapshot.error}');
        } else {
          // Data loaded successfully
          final diaryDataList = snapshot.data!.docs
              .map(
                (QueryDocumentSnapshot e) => DiaryModel.fromJson(
                    json: (e.data() as Map<String, dynamic>)),
              )
              .toList();

          diaryDataList.sort((a, b) => a.create.compareTo(b.create));

          if (diaryDataList.isEmpty) {
            return TextFormField(
              controller: contentController,
              keyboardType: TextInputType.multiline,
              maxLines: 25,
              decoration: InputDecoration(
                hintText: '입력해주세요.',
                // Display hintText only if there are no entries
              ),
            );
          } else {
            return TextFormField(
              controller: getControllerText(diaryDataList.last.content),
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
      // await GetIt.I<LocalDatabase>().removeSchedule(date);
      // await GetIt.I<LocalDatabase>().createSchedule(
      //   DiaryDbCompanion(
      //       content: Value(contentController.text),
      //       date: Value(date),
      //       create: Value(DateTime.now())),
      // );

      var diary = DiaryModel(
        id: Uuid().v4(),
        content: contentController.text,
        date: date,
        create: DateTime.now(),
      );
      print(contentController.text);
      await FirebaseFirestore.instance
          .collection(
            'diary',
          )
          .doc(diary.id)
          .set(diary.toJson());

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
                // GetIt.I<LocalDatabase>().removeSchedule(date);
                deleteDiaryEntriesByDate(date);
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
    contentController = TextEditingController(text: text);
    return contentController;
  }

  String _formattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> deleteDiaryEntriesByDate(DateTime date) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('diary')
          .where('date', isEqualTo: DateFormat('yyyy-MM-dd').format(date))
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.delete();
      }

      print('Diary entries deleted successfully.');
    } catch (e) {
      print('Failed to delete diary entries: $e');
    }
  }
}
