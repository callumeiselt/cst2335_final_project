// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomerDatabase.dart';

// ignore_for_file: type=lint
class CustomerRecords extends Table
    with TableInfo<CustomerRecords, CustomerRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CustomerRecords(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  late final GeneratedColumn<String> birthday = GeneratedColumn<String>(
    'birthday',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    address,
    birthday,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      birthday: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birthday'],
      )!,
    );
  }

  @override
  CustomerRecords createAlias(String alias) {
    return CustomerRecords(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CustomerRecord extends DataClass implements Insertable<CustomerRecord> {
  final int id;
  final String firstName;
  final String lastName;
  final String address;
  final String birthday;
  const CustomerRecord({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.birthday,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['address'] = Variable<String>(address);
    map['birthday'] = Variable<String>(birthday);
    return map;
  }

  CustomerRecordsCompanion toCompanion(bool nullToAbsent) {
    return CustomerRecordsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      address: Value(address),
      birthday: Value(birthday),
    );
  }

  factory CustomerRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerRecord(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['first_name']),
      lastName: serializer.fromJson<String>(json['last_name']),
      address: serializer.fromJson<String>(json['address']),
      birthday: serializer.fromJson<String>(json['birthday']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'first_name': serializer.toJson<String>(firstName),
      'last_name': serializer.toJson<String>(lastName),
      'address': serializer.toJson<String>(address),
      'birthday': serializer.toJson<String>(birthday),
    };
  }

  CustomerRecord copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? address,
    String? birthday,
  }) => CustomerRecord(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    address: address ?? this.address,
    birthday: birthday ?? this.birthday,
  );
  CustomerRecord copyWithCompanion(CustomerRecordsCompanion data) {
    return CustomerRecord(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      address: data.address.present ? data.address.value : this.address,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRecord(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('address: $address, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, address, birthday);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerRecord &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.address == this.address &&
          other.birthday == this.birthday);
}

class CustomerRecordsCompanion extends UpdateCompanion<CustomerRecord> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> address;
  final Value<String> birthday;
  const CustomerRecordsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.address = const Value.absent(),
    this.birthday = const Value.absent(),
  });
  CustomerRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String address,
    required String birthday,
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       address = Value(address),
       birthday = Value(birthday);
  static Insertable<CustomerRecord> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? address,
    Expression<String>? birthday,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (address != null) 'address': address,
      if (birthday != null) 'birthday': birthday,
    });
  }

  CustomerRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? address,
    Value<String>? birthday,
  }) {
    return CustomerRecordsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRecordsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('address: $address, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }
}

abstract class _$CustomerDatabase extends GeneratedDatabase {
  _$CustomerDatabase(QueryExecutor e) : super(e);
  $CustomerDatabaseManager get managers => $CustomerDatabaseManager(this);
  late final CustomerRecords customerRecords = CustomerRecords(this);
  Future<int> saveCustomer(
    String firstName,
    String lastName,
    String address,
    String birthday,
  ) {
    return customInsert(
      'INSERT INTO customer_records (first_name, last_name, address, birthday) VALUES (?1, ?2, ?3, ?4)',
      variables: [
        Variable<String>(firstName),
        Variable<String>(lastName),
        Variable<String>(address),
        Variable<String>(birthday),
      ],
      updates: {this.customerRecords},
    );
  }

  Selectable<CustomerRecord> getAllCustomers() {
    return customSelect(
      'SELECT * FROM customer_records',
      variables: [],
      readsFrom: {this.customerRecords},
    ).asyncMap(this.customerRecords.mapFromRow);
  }

  Future<int> updateCustomer(
    String firstName,
    String lastName,
    String address,
    String birthday,
    int id,
  ) {
    return customUpdate(
      'UPDATE customer_records SET first_name = ?1, last_name = ?2, address = ?3, birthday = ?4 WHERE id = ?5',
      variables: [
        Variable<String>(firstName),
        Variable<String>(lastName),
        Variable<String>(address),
        Variable<String>(birthday),
        Variable<int>(id),
      ],
      updates: {this.customerRecords},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteCustomer(int id) {
    return customUpdate(
      'DELETE FROM customer_records WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {this.customerRecords},
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [customerRecords];
}

typedef $CustomerRecordsCreateCompanionBuilder =
    CustomerRecordsCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      required String address,
      required String birthday,
    });
typedef $CustomerRecordsUpdateCompanionBuilder =
    CustomerRecordsCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> address,
      Value<String> birthday,
    });

class $CustomerRecordsFilterComposer
    extends Composer<_$CustomerDatabase, CustomerRecords> {
  $CustomerRecordsFilterComposer({
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

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );
}

class $CustomerRecordsOrderingComposer
    extends Composer<_$CustomerDatabase, CustomerRecords> {
  $CustomerRecordsOrderingComposer({
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

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );
}

class $CustomerRecordsAnnotationComposer
    extends Composer<_$CustomerDatabase, CustomerRecords> {
  $CustomerRecordsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);
}

class $CustomerRecordsTableManager
    extends
        RootTableManager<
          _$CustomerDatabase,
          CustomerRecords,
          CustomerRecord,
          $CustomerRecordsFilterComposer,
          $CustomerRecordsOrderingComposer,
          $CustomerRecordsAnnotationComposer,
          $CustomerRecordsCreateCompanionBuilder,
          $CustomerRecordsUpdateCompanionBuilder,
          (
            CustomerRecord,
            BaseReferences<_$CustomerDatabase, CustomerRecords, CustomerRecord>,
          ),
          CustomerRecord,
          PrefetchHooks Function()
        > {
  $CustomerRecordsTableManager(_$CustomerDatabase db, CustomerRecords table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CustomerRecordsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CustomerRecordsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CustomerRecordsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> birthday = const Value.absent(),
              }) => CustomerRecordsCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                address: address,
                birthday: birthday,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                required String address,
                required String birthday,
              }) => CustomerRecordsCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                address: address,
                birthday: birthday,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<CustomerRecords, CustomerRecord>(table),
                  BaseReferences<
                    _$CustomerDatabase,
                    CustomerRecords,
                    CustomerRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $CustomerRecordsProcessedTableManager =
    ProcessedTableManager<
      _$CustomerDatabase,
      CustomerRecords,
      CustomerRecord,
      $CustomerRecordsFilterComposer,
      $CustomerRecordsOrderingComposer,
      $CustomerRecordsAnnotationComposer,
      $CustomerRecordsCreateCompanionBuilder,
      $CustomerRecordsUpdateCompanionBuilder,
      (
        CustomerRecord,
        BaseReferences<_$CustomerDatabase, CustomerRecords, CustomerRecord>,
      ),
      CustomerRecord,
      PrefetchHooks Function()
    >;

class $CustomerDatabaseManager {
  final _$CustomerDatabase _db;
  $CustomerDatabaseManager(this._db);
  $CustomerRecordsTableManager get customerRecords =>
      $CustomerRecordsTableManager(_db, _db.customerRecords);
}
