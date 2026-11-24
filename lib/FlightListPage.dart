import 'package:flutter/material.dart';
import 'FlightRepository.dart';

class FlightListPage extends StatefulWidget {
  const FlightListPage({super.key});

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  final TextEditingController _departure = TextEditingController();
  final TextEditingController _destination = TextEditingController();
  final TextEditingController _departureTime = TextEditingController();
  final TextEditingController _arrivalTime = TextEditingController();

  Flight? _selectedFlight;

  bool _showForm = false;
  bool _showErrors = false;
  bool _isLoading = true;

  String _language = 'US';

  @override
  void initState() {
    super.initState();
    _loadFlights();
  }

  Future<void> _loadFlights() async {
    try {
      await FlightRepository.init();

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showMessage('Could not load flights: $e');
    }
  }

  @override
  void dispose() {
    _departure.dispose();
    _destination.dispose();
    _departureTime.dispose();
    _arrivalTime.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _allFilled() {
    return _departure.text.trim().isNotEmpty &&
        _destination.text.trim().isNotEmpty &&
        _departureTime.text.trim().isNotEmpty &&
        _arrivalTime.text.trim().isNotEmpty;
  }

  TimeOfDay? _parseTime(String value) {
    final match = RegExp(
      r'^(\d{1,2}):(\d{2})\s*(AM|PM)$',
      caseSensitive: false,
    ).firstMatch(value.trim());

    if (match == null) return null;

    int hour = int.parse(match.group(1)!);
    final int minute = int.parse(match.group(2)!);
    final String period = match.group(3)!.toUpperCase();

    if (hour < 1 || hour > 12 || minute > 59) {
      return null;
    }

    if (period == 'PM' && hour != 12) {
      hour += 12;
    }

    if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> _pickTime(
      TextEditingController controller,
      TimeOfDay defaultTime,
      ) async {
    final TimeOfDay initialTime =
        _parseTime(controller.text) ?? defaultTime;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  Widget _field(
      String label,
      TextEditingController controller, {
        bool isTime = false,
        VoidCallback? onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: isTime,
        onTap: onTap,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          suffixIcon:
          isTime ? const Icon(Icons.access_time) : null,
          errorText:
          (_showErrors && controller.text.trim().isEmpty)
              ? 'Required'
              : null,
        ),
      ),
    );
  }

  void _clearForm() {
    _departure.clear();
    _destination.clear();
    _departureTime.clear();
    _arrivalTime.clear();

    _selectedFlight = null;
    _showErrors = false;
  }

  void _addNewFlight() {
    setState(() {
      _clearForm();
      _showForm = true;
    });
  }

  void _selectFlight(Flight flight) {
    setState(() {
      _selectedFlight = flight;

      _departure.text = flight.departureCity;
      _destination.text = flight.destinationCity;
      _departureTime.text = flight.departureTime;
      _arrivalTime.text = flight.arrivalTime;

      _showForm = true;
      _showErrors = false;
    });
  }

  Future<void> _submitFlight() async {
    setState(() {
      _showErrors = true;
    });

    if (!_allFilled()) {
      _showMessage('Please fill in all fields.');
      return;
    }

    try {
      final flight = Flight(
        _departure.text.trim(),
        _destination.text.trim(),
        _departureTime.text.trim(),
        _arrivalTime.text.trim(),
      );

      await FlightRepository.addFlight(flight);

      setState(() {
        _clearForm();
        _showForm = false;
      });

      _showMessage('Flight added successfully.');
    } catch (e) {
      _showMessage('Could not add flight: $e');
    }
  }

  Future<void> _updateFlight() async {
    if (_selectedFlight == null) return;

    setState(() {
      _showErrors = true;
    });

    if (!_allFilled()) {
      _showMessage('Please fill in all fields.');
      return;
    }

    try {
      final flight = Flight(
        _departure.text.trim(),
        _destination.text.trim(),
        _departureTime.text.trim(),
        _arrivalTime.text.trim(),
        id: _selectedFlight!.id,
      );

      await FlightRepository.updateFlight(flight);

      setState(() {
        _clearForm();
        _showForm = false;
      });

      _showMessage('Flight updated successfully.');
    } catch (e) {
      _showMessage('Could not update flight: $e');
    }
  }

  Future<void> _deleteFlight() async {
    if (_selectedFlight == null) return;

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flight'),
        content: const Text(
          'Are you sure you want to delete this flight?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await FlightRepository.deleteFlight(_selectedFlight!);

      setState(() {
        _clearForm();
        _showForm = false;
      });

      _showMessage('Flight deleted successfully.');
    } catch (e) {
      _showMessage('Could not delete flight: $e');
    }
  }

  Widget _flightList() {
    if (FlightRepository.flights.isEmpty) {
      return const Center(
        child: Text('No flights have been added yet.'),
      );
    }

    return ListView.builder(
      itemCount: FlightRepository.flights.length,
      itemBuilder: (context, index) {
        final flight = FlightRepository.flights[index];

        return Card(
          child: ListTile(
            leading: const Icon(Icons.flight),
            title: Text(
              '${flight.departureCity} → ${flight.destinationCity}',
            ),
            subtitle: Text(
              'Departure: ${flight.departureTime}\n'
                  'Arrival: ${flight.arrivalTime}',
            ),
            isThreeLine: true,
            selected: _selectedFlight?.id == flight.id,
            onTap: () => _selectFlight(flight),
          ),
        );
      },
    );
  }

  Widget _detailsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _selectedFlight == null
                ? 'Add Flight'
                : 'Update Flight',
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: 20),

          _field('Departure city', _departure),

          _field('Destination city', _destination),

          _field(
            'Departure time',
            _departureTime,
            isTime: true,
            onTap: () => _pickTime(
              _departureTime,
              const TimeOfDay(hour: 9, minute: 0),
            ),
          ),

          _field(
            'Arrival time',
            _arrivalTime,
            isTime: true,
            onTap: () => _pickTime(
              _arrivalTime,
              const TimeOfDay(hour: 11, minute: 0),
            ),
          ),

          const SizedBox(height: 10),

          if (_selectedFlight == null)
            ElevatedButton(
              onPressed: _submitFlight,
              child: const Text('Submit'),
            )
          else
            ElevatedButton(
              onPressed: _updateFlight,
              child: const Text('Update'),
            ),

          if (_selectedFlight != null)
            ElevatedButton(
              onPressed: _deleteFlight,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),

          OutlinedButton(
            onPressed: () {
              setState(() {
                _clearForm();
                _showForm = false;
              });
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _helpButton() {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      tooltip: 'Help',
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Flight List Help'),
            content: const Text(
              'Use this page to add, view, update, and delete flights.\n\n'
                  'Select a flight to edit its information. '
                  'Use the clock icons to choose departure and arrival times.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide =
        MediaQuery.of(context).size.width >= 700;

    final String subtitle = _language == 'US'
        ? 'Traveling between destinations'
        : 'Travelling between destinations';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight List'),
        actions: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'US',
                label: Text('US'),
              ),
              ButtonSegment(
                value: 'UK',
                label: Text('UK'),
              ),
            ],
            selected: {_language},
            onSelectionChanged: (selection) {
              setState(() {
                _language = selection.first;
              });
            },
          ),
          _helpButton(),
          const SizedBox(width: 8),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: isWide
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children: [
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _addNewFlight,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Flight'),
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: _flightList()),
                ],
              ),
            ),
            const VerticalDivider(width: 24),
            Expanded(
              child: _showForm
                  ? _detailsPage()
                  : const Center(
                child: Text(
                  'Select a flight or add a new flight.',
                ),
              ),
            ),
          ],
        )
            : _showForm
            ? _detailsPage()
            : Column(
          children: [
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addNewFlight,
              icon: const Icon(Icons.add),
              label: const Text('Add Flight'),
            ),
            const SizedBox(height: 12),
            Expanded(child: _flightList()),
          ],
        ),
      ),
    );
  }
}