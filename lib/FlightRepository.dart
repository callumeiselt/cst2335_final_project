import 'FlightDatabase.dart';

class Flight {
  final int id;
  final String departureCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;

  Flight(
      this.departureCity,
      this.destinationCity,
      this.departureTime,
      this.arrivalTime, {
        this.id = 0,
      });
}

class FlightRepository {
  static FlightDatabase? _db;

  static final List<Flight> flights = [];

  static Future<void> init() async {
    if (_db != null) return;

    _db = FlightDatabase();
    await loadFlights();
  }

  static Future<void> loadFlights() async {
    flights.clear();

    final rows = await _db!.getAllFlights().get();

    flights.addAll(
      rows.map(
            (r) => Flight(
          r.departureCity,
          r.destinationCity,
          r.departureTime,
          r.arrivalTime,
          id: r.id,
        ),
      ),
    );
  }

  static Future<void> addFlight(Flight flight) async {
    final int id = await _db!.saveFlight(
      flight.departureCity,
      flight.destinationCity,
      flight.departureTime,
      flight.arrivalTime,
    );

    flights.add(
      Flight(
        flight.departureCity,
        flight.destinationCity,
        flight.departureTime,
        flight.arrivalTime,
        id: id,
      ),
    );
  }

  static Future<void> updateFlight(Flight flight) async {
    await _db!.updateFlight(
      flight.departureCity,
      flight.destinationCity,
      flight.departureTime,
      flight.arrivalTime,
      flight.id,
    );

    final int index = flights.indexWhere(
          (item) => item.id == flight.id,
    );

    if (index != -1) {
      flights[index] = flight;
    }
  }

  static Future<void> deleteFlight(Flight flight) async {
    await _db!.deleteFlight(flight.id);

    flights.removeWhere(
          (item) => item.id == flight.id,
    );
  }
}