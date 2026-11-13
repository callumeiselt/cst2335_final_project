import 'CustomerDatabase.dart';

/// One customer.
class Customer {
  final int id;
  final String firstName;
  final String lastName;
  final String address;
  final String birthday;

  /// id is optional so a new customer can be built before the database gives it one.
  Customer(this.firstName, this.lastName, this.address, this.birthday,
      {this.id = 0});
}

/// Keeps the customer list in memory and saves every change to the database.
class CustomerRepository {
  static CustomerDatabase? _db;

  /// The customers shown in the list.
  static final List<Customer> customers = [];

  /// Opens the database and loads the customers. Safe to call more than once.
  static Future<void> init() async {
    if (_db != null) return;
    _db = CustomerDatabase();
    await loadCustomers();
  }

  /// Reads every customer from the database into the list.
  static Future<void> loadCustomers() async {
    customers.clear();
    final rows = await _db!.getAllCustomers().get();
    customers.addAll(rows.map((r) =>
        Customer(r.firstName, r.lastName, r.address, r.birthday, id: r.id)));
  }

  /// Inserts a customer, then adds it to the list with the id the database made.
  static Future<void> addCustomer(Customer c) async {
    final int id = await _db!
        .saveCustomer(c.firstName, c.lastName, c.address, c.birthday);
    customers.add(
        Customer(c.firstName, c.lastName, c.address, c.birthday, id: id));
  }

  /// Saves the changed details of a customer.
  static Future<void> updateCustomer(Customer c) async {
    await _db!.updateCustomer(
        c.firstName, c.lastName, c.address, c.birthday, c.id);
    final int i = customers.indexWhere((x) => x.id == c.id);
    if (i != -1) customers[i] = c;
  }

  /// Deletes a customer from the database and the list.
  static Future<void> deleteCustomer(Customer c) async {
    await _db!.deleteCustomer(c.id);
    customers.removeWhere((x) => x.id == c.id);
  }
}