import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'FlightDatabase.g.dart';

@DriftDatabase(include: {'Flight.drift'})
class FlightDatabase extends _$FlightDatabase {
  FlightDatabase() : super(driftDatabase(name: 'flights'));

  @override
  int get schemaVersion => 1;
}