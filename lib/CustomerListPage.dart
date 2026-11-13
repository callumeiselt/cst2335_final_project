import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'CustomerRepository.dart';

/// The Customer List part of the project.
/// Tablet / desktop landscape: the list is on the left and the form is on the right.
/// Phone / portrait: the form replaces the list.
class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => CustomerListPageState();
}

/// Holds everything that changes on the Customer List page.
class CustomerListPageState extends State<CustomerListPage> {
  /// Saves the previous customer, encrypted, so it can be copied later.
  final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();

  static const String _kFirst = 'lastCustomerFirst';
  static const String _kLast = 'lastCustomerLast';
  static const String _kAddress = 'lastCustomerAddress';
  static const String _kBirthday = 'lastCustomerBirthday';

  /// The customers shown in the list (kept in CustomerRepository).
  List<Customer> get customers => CustomerRepository.customers;

  /// The customer that was tapped. null means none is selected.
  Customer? selectedItem;

  /// True while the "new customer" form is open.
  bool adding = false;

  /// True until the database has finished loading.
  bool _loading = true;

  /// True after a failed submit, so empty fields show "Required".
  bool _showErrors = false;

  late TextEditingController _first;
  late TextEditingController _last;
  late TextEditingController _address;
  late TextEditingController _birthday;

  @override
  void initState() {
    super.initState();
    _first = TextEditingController();
    _last = TextEditingController();
    _address = TextEditingController();
    _birthday = TextEditingController();

    // Open the database and load the saved customers.
    CustomerRepository.init().then((_) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _address.dispose();
    _birthday.dispose();
    super.dispose();
  }

  /// Puts text into the four form fields.
  void _fillForm(String f, String l, String a, String b) {
    _first.text = f;
    _last.text = l;
    _address.text = a;
    _birthday.text = b;
  }

  /// Shows a Snackbar with a message.
  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// True only when all four fields have a value.
  bool _allFilled() {
    return _first.text.trim().isNotEmpty &&
        _last.text.trim().isNotEmpty &&
        _address.text.trim().isNotEmpty &&
        _birthday.text.trim().isNotEmpty;
  }

  /// Turns a date into text like 2001-04-09.
  String _formatDate(DateTime d) {
    final String m = d.month.toString().padLeft(2, '0');
    final String day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }

  /// Opens a calendar so the user can choose the birthday.
  Future<void> _pickBirthday() async {
    final DateTime initial =
        DateTime.tryParse(_birthday.text) ?? DateTime(2000, 1, 1);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthday.text = _formatDate(picked);
      });
    }
  }

  /// Saves the customer in EncryptedSharedPreferences so it can be copied next time.
  Future<void> _saveLastCustomer(Customer c) async {
    await _prefs.setString(_kFirst, c.firstName);
    await _prefs.setString(_kLast, c.lastName);
    await _prefs.setString(_kAddress, c.address);
    await _prefs.setString(_kBirthday, c.birthday);
  }

  /// Called by the Add Customer button. If a previous customer was saved,
  /// asks whether to copy it or start with a blank form.
  Future<void> _startAdd() async {
    final String f = await _prefs.getString(_kFirst);
    final String l = await _prefs.getString(_kLast);
    final String a = await _prefs.getString(_kAddress);
    final String b = await _prefs.getString(_kBirthday);

    bool copy = false;
    if (f.isNotEmpty || l.isNotEmpty || a.isNotEmpty || b.isNotEmpty) {
      if (!mounted) return;
      final bool? answer = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => AlertDialog(
          title: const Text('Copy previous customer?'),
          content: const Text(
              'Copy the fields from the last customer you added, or start with a blank form?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Copy'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Blank'),
            ),
          ],
        ),
      );
      copy = answer ?? false;
    }

    if (!mounted) return;
    setState(() {
      selectedItem = null;
      adding = true;
      _showErrors = false;
      if (copy) {
        _fillForm(f, l, a, b);
      } else {
        _fillForm('', '', '', '');
      }
    });
  }

  /// Called when a customer in the list is tapped. Shows their details in the form.
  void _selectCustomer(Customer c) {
    setState(() {
      adding = false;
      selectedItem = c;
      _showErrors = false;
      _fillForm(c.firstName, c.lastName, c.address, c.birthday);
    });
  }

  /// Closes the form without saving anything.
  void _closeForm() {
    setState(() {
      adding = false;
      selectedItem = null;
      _showErrors = false;
      _fillForm('', '', '', '');
    });
  }

  /// Submit button: checks all fields, then adds the customer to the database and list.
  Future<void> _submit() async {
    if (!_allFilled()) {
      setState(() {
        _showErrors = true;
      });
      _snack('Please fill in all fields.');
      return;
    }

    final Customer c = Customer(
      _first.text.trim(),
      _last.text.trim(),
      _address.text.trim(),
      _birthday.text.trim(),
    );

    await CustomerRepository.addCustomer(c);
    await _saveLastCustomer(c);

    if (!mounted) return;
    setState(() {
      adding = false;
      _showErrors = false;
      _fillForm('', '', '', '');
    });
    _snack('Customer added.');
  }

  /// Update button: saves the changed details of the selected customer.
  Future<void> _update() async {
    if (!_allFilled()) {
      setState(() {
        _showErrors = true;
      });
      _snack('Please fill in all fields.');
      return;
    }

    final Customer updated = Customer(
      _first.text.trim(),
      _last.text.trim(),
      _address.text.trim(),
      _birthday.text.trim(),
      id: selectedItem!.id,
    );

    await CustomerRepository.updateCustomer(updated);

    if (!mounted) return;
    setState(() {
      selectedItem = updated;
      _showErrors = false;
    });
    _snack('Customer updated.');
  }

  /// Delete button: asks first, then removes the customer from the database and list.
  Future<void> _delete() async {
    final bool? sure = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Delete customer?'),
        content: Text(
            'Delete ${selectedItem!.firstName} ${selectedItem!.lastName}? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (sure != true) return;

    await CustomerRepository.deleteCustomer(selectedItem!);

    if (!mounted) return;
    setState(() {
      selectedItem = null;
      _fillForm('', '', '', '');
    });
    _snack('Customer deleted.');
  }

  /// The help action in the ActionBar: shows how to use this page.
  void _showHelp() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('How to use this page'),
        content: const Text(
            '1. Press "Add Customer" to open the form.\n'
                '2. Fill in every field and press Submit.\n'
                '3. Tap a customer in the list to see their details.\n'
                '4. Press Update to save changes or Delete to remove the customer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Builds one text field. Shows "Required" when it is empty after a failed submit.
  Widget _field(String label, TextEditingController controller,
      {bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: isDate,
        onTap: isDate ? _pickBirthday : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          suffixIcon: isDate ? const Icon(Icons.calendar_today) : null,
          errorText: (_showErrors && controller.text.trim().isEmpty)
              ? 'Required'
              : null,
        ),
      ),
    );
  }

  /// The list side: the Add Customer button and the list of customers.
  Widget listPage() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _startAdd,
              icon: const Icon(Icons.person_add),
              label: const Text('Add Customer'),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: customers.isEmpty
                ? const Center(child: Text('There are no customers yet'))
                : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, rowNum) {
                final Customer c = customers[rowNum];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('${c.firstName} ${c.lastName}'),
                    subtitle: Text(c.address),
                    selected: selectedItem?.id == c.id,
                    onTap: () => _selectCustomer(c),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// The form side: used for a new customer and for the details of a selected one.
  Widget detailsPage() {
    if (!adding && selectedItem == null) {
      return const Center(
        child: Text('Select a customer or press Add Customer'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            adding ? 'New Customer' : 'Customer ID: ${selectedItem!.id}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _field('First name', _first),
          _field('Last name', _last),
          _field('Address', _address),
          _field('Birthday', _birthday, isDate: true),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: adding
                ? [
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
              OutlinedButton(
                onPressed: _closeForm,
                child: const Text('Cancel'),
              ),
            ]
                : [
              ElevatedButton(
                onPressed: _update,
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: _delete,
                child: const Text('Delete'),
              ),
              OutlinedButton(
                onPressed: _closeForm,
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Chooses the layout from the screen size and orientation.
  Widget reactiveLayout() {
    final Size size = MediaQuery.of(context).size;

    if (size.width > size.height && size.width > 720) {
      // Tablet / desktop landscape: list on the left, form on the right.
      return Row(
        children: [
          Expanded(flex: 2, child: listPage()),
          Expanded(flex: 3, child: detailsPage()),
        ],
      );
    } else {
      // Phone / portrait: the form replaces the list.
      if (adding || selectedItem != null) {
        return detailsPage();
      } else {
        return listPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Help',
            onPressed: _showHelp,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : reactiveLayout(),
    );
  }
}