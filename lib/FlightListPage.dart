import 'package:flutter/material.dart';

/// Landing page for the Flights List part of the project.
class FlightListPage extends StatelessWidget {
  const FlightListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flights List')),
      body: const Center(child: Text('Coming soon')),
    );
  }
}