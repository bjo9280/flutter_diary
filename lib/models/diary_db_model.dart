import 'package:intl/intl.dart';

class DiaryModel {
  final String id;
  final DateTime date;
  final String content;
  final DateTime create;

  DiaryModel({
    required this.id,
    required this.content,
    required this.date,
    required this.create,
  });

  DiaryModel.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        content = json['content'],
        date = DateTime.parse(json['date']),
        create = DateTime.parse(json['create']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'date': DateFormat('yyyy-MM-dd').format(create),
      'create': DateFormat('yyyy-MM-dd HH:mm:ss').format(create),
    };
  }
}
