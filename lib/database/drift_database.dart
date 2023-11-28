import 'package:diary/models/diary_db.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    DiaryDb,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Stream<List<DiaryDbData>> watchSchedules(DateTime date) =>
      (select(diaryDb)..where((tbl) => tbl.date.equals(date))).watch();

  Future<int> createSchedule(DiaryDbCompanion data) =>
      into(diaryDb).insert(data);

  Future<int> removeSchedule(DateTime date) =>
      (delete(diaryDb)..where((tbl) => tbl.date.equals(date))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
