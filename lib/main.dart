import 'package:flutter/material.dart';
import 'CustomerListPage.dart';
import 'AirplaneListPage.dart';
import 'FlightListPage.dart';
import 'ReservationPage.dart';

/// Starts the app.
void main() {
  runApp(const MyApp());
}

/// The root of the app. Each button on the main page goes to one route.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CST2335 Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/customers': (context) => const CustomerListPage(),
        '/airplanes': (context) => const AirplaneListPage(),
        '/flights': (context) => const FlightListPage(),
        '/reservations': (context) => const ReservationPage(),
      },
    );
  }
}

/// The main page. It has 4 buttons, one for each team member's part.
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  /// Builds one wide button with an icon, so all 4 look the same.
  Widget _menuButton(
      BuildContext context, String label, IconData icon, String route) {
    return SizedBox(
      width: 280,
      height: 64,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon, size: 28),
        label: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airline Manager'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _menuButton(context, 'Customer List', Icons.people, '/customers'),
              const SizedBox(height: 32),
              _menuButton(context, 'Airplane List', Icons.airplanemode_active,
                  '/airplanes'),
              const SizedBox(height: 32),
              _menuButton(
                  context, 'Flights List', Icons.flight_takeoff, '/flights'),
              const SizedBox(height: 32),
              _menuButton(context, 'Reservations', Icons.confirmation_number,
                  '/reservations'),
            ],
          ),
        ),
      ),
    );
  }
}