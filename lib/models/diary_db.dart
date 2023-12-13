import 'package:drift/drift.dart';

class DiaryDb extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get content => text()();
  DateTimeColumn get create => dateTime()();
}
