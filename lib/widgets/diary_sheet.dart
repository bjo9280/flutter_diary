import 'package:flutter/material.dart';

class DiarySheet extends StatefulWidget {
  final DateTime selectedDate;

  const DiarySheet({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  State<DiarySheet> createState() => _DiarySheet();
}

class _DiarySheet extends State<DiarySheet> {
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.selectedDate; // Initialize date with selectedDate
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            ElevatedButton(
              child: Text(
                  "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}"),
              onPressed: () {
                selectDate(context, date, (selectedDate) {
                  setState(() {
                    date = selectedDate;
                  });
                });
              },
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ButtonBar(),
                  TextField(
                    controller: TextEditingController(),
                    keyboardType: TextInputType.multiline,
                    maxLines: 25,
                    decoration: InputDecoration(
                      hintText: "Enter Remarks",
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print('submit');
                      },
                      child: Text('Save'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context, DateTime date,
      Function(DateTime) onDateSelected) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      onDateSelected(selectedDate);
    }
  }
}
