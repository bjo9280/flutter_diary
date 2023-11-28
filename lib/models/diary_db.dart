import 'package:drift/drift.dart';

class DiaryDb extends Table {
  // IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().customConstraint('PRIMARY KEY')();
  TextColumn get content => text()();
}
