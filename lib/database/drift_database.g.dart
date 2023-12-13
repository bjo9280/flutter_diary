// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DiaryDbTable extends DiaryDb with TableInfo<$DiaryDbTable, DiaryDbData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryDbTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createMeta = const VerificationMeta('create');
  @override
  late final GeneratedColumn<DateTime> create = GeneratedColumn<DateTime>(
      'create', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, content, create];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
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
    if (data.containsKey('create')) {
      context.handle(_createMeta,
          create.isAcceptableOrUnknown(data['create']!, _createMeta));
    } else if (isInserting) {
      context.missing(_createMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiaryDbData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaryDbData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      create: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create'])!,
    );
  }

  @override
  $DiaryDbTable createAlias(String alias) {
    return $DiaryDbTable(attachedDatabase, alias);
  }
}

class DiaryDbData extends DataClass implements Insertable<DiaryDbData> {
  final int id;
  final DateTime date;
  final String content;
  final DateTime create;
  const DiaryDbData(
      {required this.id,
      required this.date,
      required this.content,
      required this.create});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['content'] = Variable<String>(content);
    map['create'] = Variable<DateTime>(create);
    return map;
  }

  DiaryDbCompanion toCompanion(bool nullToAbsent) {
    return DiaryDbCompanion(
      id: Value(id),
      date: Value(date),
      content: Value(content),
      create: Value(create),
    );
  }

  factory DiaryDbData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryDbData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      content: serializer.fromJson<String>(json['content']),
      create: serializer.fromJson<DateTime>(json['create']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'content': serializer.toJson<String>(content),
      'create': serializer.toJson<DateTime>(create),
    };
  }

  DiaryDbData copyWith(
          {int? id, DateTime? date, String? content, DateTime? create}) =>
      DiaryDbData(
        id: id ?? this.id,
        date: date ?? this.date,
        content: content ?? this.content,
        create: create ?? this.create,
      );
  @override
  String toString() {
    return (StringBuffer('DiaryDbData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('content: $content, ')
          ..write('create: $create')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, content, create);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryDbData &&
          other.id == this.id &&
          other.date == this.date &&
          other.content == this.content &&
          other.create == this.create);
}

class DiaryDbCompanion extends UpdateCompanion<DiaryDbData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> content;
  final Value<DateTime> create;
  const DiaryDbCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.content = const Value.absent(),
    this.create = const Value.absent(),
  });
  DiaryDbCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String content,
    required DateTime create,
  })  : date = Value(date),
        content = Value(content),
        create = Value(create);
  static Insertable<DiaryDbData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? content,
    Expression<DateTime>? create,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (content != null) 'content': content,
      if (create != null) 'create': create,
    });
  }

  DiaryDbCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? content,
      Value<DateTime>? create}) {
    return DiaryDbCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      content: content ?? this.content,
      create: create ?? this.create,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (create.present) {
      map['create'] = Variable<DateTime>(create.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryDbCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('content: $content, ')
          ..write('create: $create')
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
