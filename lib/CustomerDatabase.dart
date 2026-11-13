import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'CustomerDatabase.g.dart';

/// The database that stores the customers.
@DriftDatabase(
  include: {'Customer.drift'},
)
class CustomerDatabase extends _$CustomerDatabase {
  /// Opens a database file named "customers", separate from the lab database.
  CustomerDatabase() : super(driftDatabase(name: 'customers'));

  @override
  int get schemaVersion => 1;
}