import 'package:flutter/material.dart';

/// Landing page for the Reservations part of the project.
class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservations')),
      body: const Center(child: Text('Coming soon')),
    );
  }
}