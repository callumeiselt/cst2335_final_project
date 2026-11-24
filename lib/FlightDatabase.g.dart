// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FlightDatabase.dart';

// ignore_for_file: type=lint
class FlightRecords extends Table with TableInfo<FlightRecords, FlightRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FlightRecords(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _departureCityMeta = const VerificationMeta(
    'departureCity',
  );
  late final GeneratedColumn<String> departureCity = GeneratedColumn<String>(
    'departure_city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _destinationCityMeta = const VerificationMeta(
    'destinationCity',
  );
  late final GeneratedColumn<String> destinationCity = GeneratedColumn<String>(
    'destination_city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _departureTimeMeta = const VerificationMeta(
    'departureTime',
  );
  late final GeneratedColumn<String> departureTime = GeneratedColumn<String>(
    'departure_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _arrivalTimeMeta = const VerificationMeta(
    'arrivalTime',
  );
  late final GeneratedColumn<String> arrivalTime = GeneratedColumn<String>(
    'arrival_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    departureCity,
    destinationCity,
    departureTime,
    arrivalTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flight_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlightRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('departure_city')) {
      context.handle(
        _departureCityMeta,
        departureCity.isAcceptableOrUnknown(
          data['departure_city']!,
          _departureCityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_departureCityMeta);
    }
    if (data.containsKey('destination_city')) {
      context.handle(
        _destinationCityMeta,
        destinationCity.isAcceptableOrUnknown(
          data['destination_city']!,
          _destinationCityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationCityMeta);
    }
    if (data.containsKey('departure_time')) {
      context.handle(
        _departureTimeMeta,
        departureTime.isAcceptableOrUnknown(
          data['departure_time']!,
          _departureTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_departureTimeMeta);
    }
    if (data.containsKey('arrival_time')) {
      context.handle(
        _arrivalTimeMeta,
        arrivalTime.isAcceptableOrUnknown(
          data['arrival_time']!,
          _arrivalTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arrivalTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlightRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlightRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      departureCity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}departure_city'],
      )!,
      destinationCity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_city'],
      )!,
      departureTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}departure_time'],
      )!,
      arrivalTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arrival_time'],
      )!,
    );
  }

  @override
  FlightRecords createAlias(String alias) {
    return FlightRecords(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class FlightRecord extends DataClass implements Insertable<FlightRecord> {
  final int id;
  final String departureCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;
  const FlightRecord({
    required this.id,
    required this.departureCity,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['departure_city'] = Variable<String>(departureCity);
    map['destination_city'] = Variable<String>(destinationCity);
    map['departure_time'] = Variable<String>(departureTime);
    map['arrival_time'] = Variable<String>(arrivalTime);
    return map;
  }

  FlightRecordsCompanion toCompanion(bool nullToAbsent) {
    return FlightRecordsCompanion(
      id: Value(id),
      departureCity: Value(departureCity),
      destinationCity: Value(destinationCity),
      departureTime: Value(departureTime),
      arrivalTime: Value(arrivalTime),
    );
  }

  factory FlightRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlightRecord(
      id: serializer.fromJson<int>(json['id']),
      departureCity: serializer.fromJson<String>(json['departure_city']),
      destinationCity: serializer.fromJson<String>(json['destination_city']),
      departureTime: serializer.fromJson<String>(json['departure_time']),
      arrivalTime: serializer.fromJson<String>(json['arrival_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'departure_city': serializer.toJson<String>(departureCity),
      'destination_city': serializer.toJson<String>(destinationCity),
      'departure_time': serializer.toJson<String>(departureTime),
      'arrival_time': serializer.toJson<String>(arrivalTime),
    };
  }

  FlightRecord copyWith({
    int? id,
    String? departureCity,
    String? destinationCity,
    String? departureTime,
    String? arrivalTime,
  }) => FlightRecord(
    id: id ?? this.id,
    departureCity: departureCity ?? this.departureCity,
    destinationCity: destinationCity ?? this.destinationCity,
    departureTime: departureTime ?? this.departureTime,
    arrivalTime: arrivalTime ?? this.arrivalTime,
  );
  FlightRecord copyWithCompanion(FlightRecordsCompanion data) {
    return FlightRecord(
      id: data.id.present ? data.id.value : this.id,
      departureCity: data.departureCity.present
          ? data.departureCity.value
          : this.departureCity,
      destinationCity: data.destinationCity.present
          ? data.destinationCity.value
          : this.destinationCity,
      departureTime: data.departureTime.present
          ? data.departureTime.value
          : this.departureTime,
      arrivalTime: data.arrivalTime.present
          ? data.arrivalTime.value
          : this.arrivalTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlightRecord(')
          ..write('id: $id, ')
          ..write('departureCity: $departureCity, ')
          ..write('destinationCity: $destinationCity, ')
          ..write('departureTime: $departureTime, ')
          ..write('arrivalTime: $arrivalTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    departureCity,
    destinationCity,
    departureTime,
    arrivalTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlightRecord &&
          other.id == this.id &&
          other.departureCity == this.departureCity &&
          other.destinationCity == this.destinationCity &&
          other.departureTime == this.departureTime &&
          other.arrivalTime == this.arrivalTime);
}

class FlightRecordsCompanion extends UpdateCompanion<FlightRecord> {
  final Value<int> id;
  final Value<String> departureCity;
  final Value<String> destinationCity;
  final Value<String> departureTime;
  final Value<String> arrivalTime;
  const FlightRecordsCompanion({
    this.id = const Value.absent(),
    this.departureCity = const Value.absent(),
    this.destinationCity = const Value.absent(),
    this.departureTime = const Value.absent(),
    this.arrivalTime = const Value.absent(),
  });
  FlightRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String departureCity,
    required String destinationCity,
    required String departureTime,
    required String arrivalTime,
  }) : departureCity = Value(departureCity),
       destinationCity = Value(destinationCity),
       departureTime = Value(departureTime),
       arrivalTime = Value(arrivalTime);
  static Insertable<FlightRecord> custom({
    Expression<int>? id,
    Expression<String>? departureCity,
    Expression<String>? destinationCity,
    Expression<String>? departureTime,
    Expression<String>? arrivalTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (departureCity != null) 'departure_city': departureCity,
      if (destinationCity != null) 'destination_city': destinationCity,
      if (departureTime != null) 'departure_time': departureTime,
      if (arrivalTime != null) 'arrival_time': arrivalTime,
    });
  }

  FlightRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? departureCity,
    Value<String>? destinationCity,
    Value<String>? departureTime,
    Value<String>? arrivalTime,
  }) {
    return FlightRecordsCompanion(
      id: id ?? this.id,
      departureCity: departureCity ?? this.departureCity,
      destinationCity: destinationCity ?? this.destinationCity,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (departureCity.present) {
      map['departure_city'] = Variable<String>(departureCity.value);
    }
    if (destinationCity.present) {
      map['destination_city'] = Variable<String>(destinationCity.value);
    }
    if (departureTime.present) {
      map['departure_time'] = Variable<String>(departureTime.value);
    }
    if (arrivalTime.present) {
      map['arrival_time'] = Variable<String>(arrivalTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlightRecordsCompanion(')
          ..write('id: $id, ')
          ..write('departureCity: $departureCity, ')
          ..write('destinationCity: $destinationCity, ')
          ..write('departureTime: $departureTime, ')
          ..write('arrivalTime: $arrivalTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$FlightDatabase extends GeneratedDatabase {
  _$FlightDatabase(QueryExecutor e) : super(e);
  $FlightDatabaseManager get managers => $FlightDatabaseManager(this);
  late final FlightRecords flightRecords = FlightRecords(this);
  Future<int> saveFlight(
    String departureCity,
    String destinationCity,
    String departureTime,
    String arrivalTime,
  ) {
    return customInsert(
      'INSERT INTO flight_records (departure_city, destination_city, departure_time, arrival_time) VALUES (?1, ?2, ?3, ?4)',
      variables: [
        Variable<String>(departureCity),
        Variable<String>(destinationCity),
        Variable<String>(departureTime),
        Variable<String>(arrivalTime),
      ],
      updates: {this.flightRecords},
    );
  }

  Selectable<FlightRecord> getAllFlights() {
    return customSelect(
      'SELECT * FROM flight_records',
      variables: [],
      readsFrom: {this.flightRecords},
    ).asyncMap(this.flightRecords.mapFromRow);
  }

  Future<int> updateFlight(
    String departureCity,
    String destinationCity,
    String departureTime,
    String arrivalTime,
    int id,
  ) {
    return customUpdate(
      'UPDATE flight_records SET departure_city = ?1, destination_city = ?2, departure_time = ?3, arrival_time = ?4 WHERE id = ?5',
      variables: [
        Variable<String>(departureCity),
        Variable<String>(destinationCity),
        Variable<String>(departureTime),
        Variable<String>(arrivalTime),
        Variable<int>(id),
      ],
      updates: {this.flightRecords},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteFlight(int id) {
    return customUpdate(
      'DELETE FROM flight_records WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {this.flightRecords},
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [flightRecords];
}

typedef $FlightRecordsCreateCompanionBuilder = FlightRecordsCompanion Function({
  Value<int> id,
  required String departureCity,
  required String destinationCity,
  required String departureTime,
  required String arrivalTime,
});
typedef $FlightRecordsUpdateCompanionBuilder = FlightRecordsCompanion Function({
  Value<int> id,
  Value<String> departureCity,
  Value<String> destinationCity,
  Value<String> departureTime,
  Value<String> arrivalTime,
});

class $FlightRecordsFilterComposer
    extends Composer<_$FlightDatabase, FlightRecords> {
  $FlightRecordsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get departureCity => $composableBuilder(
    column: $table.departureCity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationCity => $composableBuilder(
    column: $table.destinationCity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get departureTime => $composableBuilder(
    column: $table.departureTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arrivalTime => $composableBuilder(
    column: $table.arrivalTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $FlightRecordsOrderingComposer
    extends Composer<_$FlightDatabase, FlightRecords> {
  $FlightRecordsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get departureCity => $composableBuilder(
    column: $table.departureCity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationCity => $composableBuilder(
    column: $table.destinationCity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get departureTime => $composableBuilder(
    column: $table.departureTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arrivalTime => $composableBuilder(
    column: $table.arrivalTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $FlightRecordsAnnotationComposer
    extends Composer<_$FlightDatabase, FlightRecords> {
  $FlightRecordsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get departureCity => $composableBuilder(
    column: $table.departureCity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationCity => $composableBuilder(
    column: $table.destinationCity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get departureTime => $composableBuilder(
    column: $table.departureTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arrivalTime => $composableBuilder(
    column: $table.arrivalTime,
    builder: (column) => column,
  );
}

class $FlightRecordsTableManager
    extends
        RootTableManager<
          _$FlightDatabase,
          FlightRecords,
          FlightRecord,
          $FlightRecordsFilterComposer,
          $FlightRecordsOrderingComposer,
          $FlightRecordsAnnotationComposer,
          $FlightRecordsCreateCompanionBuilder,
          $FlightRecordsUpdateCompanionBuilder,
          (
            FlightRecord,
            BaseReferences<_$FlightDatabase, FlightRecords, FlightRecord>,
          ),
          FlightRecord,
          PrefetchHooks Function()
        > {
  $FlightRecordsTableManager(_$FlightDatabase db, FlightRecords table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $FlightRecordsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $FlightRecordsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $FlightRecordsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> departureCity = const Value.absent(),
                Value<String> destinationCity = const Value.absent(),
                Value<String> departureTime = const Value.absent(),
                Value<String> arrivalTime = const Value.absent(),
              }) => FlightRecordsCompanion(
                id: id,
                departureCity: departureCity,
                destinationCity: destinationCity,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String departureCity,
                required String destinationCity,
                required String departureTime,
                required String arrivalTime,
              }) => FlightRecordsCompanion.insert(
                id: id,
                departureCity: departureCity,
                destinationCity: destinationCity,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<FlightRecords, FlightRecord>(table),
                  BaseReferences<_$FlightDatabase, FlightRecords, FlightRecord>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $FlightRecordsProcessedTableManager =
    ProcessedTableManager<
      _$FlightDatabase,
      FlightRecords,
      FlightRecord,
      $FlightRecordsFilterComposer,
      $FlightRecordsOrderingComposer,
      $FlightRecordsAnnotationComposer,
      $FlightRecordsCreateCompanionBuilder,
      $FlightRecordsUpdateCompanionBuilder,
      (
        FlightRecord,
        BaseReferences<_$FlightDatabase, FlightRecords, FlightRecord>,
      ),
      FlightRecord,
      PrefetchHooks Function()
    >;

class $FlightDatabaseManager {
  final _$FlightDatabase _db;
  $FlightDatabaseManager(this._db);
  $FlightRecordsTableManager get flightRecords =>
      $FlightRecordsTableManager(_db, _db.flightRecords);
}
