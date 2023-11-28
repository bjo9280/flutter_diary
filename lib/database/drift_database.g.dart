// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DiaryDbTable extends DiaryDb with TableInfo<$DiaryDbTable, DiaryDbData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryDbTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'PRIMARY KEY');
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [date, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diary_db';
  @override
  VerificationContext validateIntegrity(Insertable<DiaryDbData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DiaryDbData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaryDbData(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $DiaryDbTable createAlias(String alias) {
    return $DiaryDbTable(attachedDatabase, alias);
  }
}

class DiaryDbData extends DataClass implements Insertable<DiaryDbData> {
  final DateTime date;
  final String content;
  const DiaryDbData({required this.date, required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['content'] = Variable<String>(content);
    return map;
  }

  DiaryDbCompanion toCompanion(bool nullToAbsent) {
    return DiaryDbCompanion(
      date: Value(date),
      content: Value(content),
    );
  }

  factory DiaryDbData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryDbData(
      date: serializer.fromJson<DateTime>(json['date']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'content': serializer.toJson<String>(content),
    };
  }

  DiaryDbData copyWith({DateTime? date, String? content}) => DiaryDbData(
        date: date ?? this.date,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('DiaryDbData(')
          ..write('date: $date, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryDbData &&
          other.date == this.date &&
          other.content == this.content);
}

class DiaryDbCompanion extends UpdateCompanion<DiaryDbData> {
  final Value<DateTime> date;
  final Value<String> content;
  final Value<int> rowid;
  const DiaryDbCompanion({
    this.date = const Value.absent(),
    this.content = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiaryDbCompanion.insert({
    required DateTime date,
    required String content,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        content = Value(content);
  static Insertable<DiaryDbData> custom({
    Expression<DateTime>? date,
    Expression<String>? content,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiaryDbCompanion copyWith(
      {Value<DateTime>? date, Value<String>? content, Value<int>? rowid}) {
    return DiaryDbCompanion(
      date: date ?? this.date,
      content: content ?? this.content,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryDbCompanion(')
          ..write('date: $date, ')
          ..write('content: $content, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $DiaryDbTable diaryDb = $DiaryDbTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [diaryDb];
}
