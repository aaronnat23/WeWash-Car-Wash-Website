import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatefulWidget {
  const CarRentalApp({Key? key}) : super(key: key);

  @override
  State<CarRentalApp> createState() => _CarRentalAppState();
}

class _CarRentalAppState extends State<CarRentalApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental Management',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: HomePage(onThemeToggle: toggleTheme, currentThemeMode: _themeMode),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode currentThemeMode;

  const HomePage({
    Key? key,
    required this.onThemeToggle,
    required this.currentThemeMode,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DashboardPage(),
      const CarsPage(),
      const BookingsPage(),
      ProfilePage(
        onThemeToggle: widget.onThemeToggle,
        isDarkMode: widget.currentThemeMode == ThemeMode.dark,
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: 'Cars',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Dashboard Page
class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const [
                _StatCard(
                  title: 'Total Cars',
                  value: '24',
                  icon: Icons.directions_car,
                  color: Colors.blue,
                ),
                _StatCard(
                  title: 'Active Rentals',
                  value: '12',
                  icon: Icons.key,
                  color: Colors.green,
                ),
                _StatCard(
                  title: 'Revenue',
                  value: '\$4,250',
                  icon: Icons.attach_money,
                  color: Colors.orange,
                ),
                _StatCard(
                  title: 'Pending',
                  value: '3',
                  icon: Icons.pending_actions,
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Bookings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _BookingCard(
              carName: 'Tesla Model 3',
              customer: 'John Doe',
              date: DateTime.now(),
              status: 'Active',
            ),
            const SizedBox(height: 12),
            _BookingCard(
              carName: 'BMW X5',
              customer: 'Jane Smith',
              date: DateTime.now().add(const Duration(days: 1)),
              status: 'Upcoming',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[400]
                        : Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String carName;
  final String customer;
  final DateTime date;
  final String status;

  const _BookingCard({
    required this.carName,
    required this.customer,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isDark ? Colors.blue.shade700 : Colors.blue.shade100,
          child: Icon(
            Icons.directions_car,
            color: isDark ? Colors.blue.shade200 : Colors.blue,
          ),
        ),
        title: Text(carName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Customer: $customer\n${DateFormat('MMM dd, yyyy').format(date)}'),
        trailing: Chip(
          label: Text(status),
          backgroundColor: status == 'Active'
              ? (isDark ? Colors.green.shade700 : Colors.green.shade100)
              : (isDark ? Colors.orange.shade700 : Colors.orange.shade100),
        ),
        isThreeLine: true,
      ),
    );
  }
}

// Cars Page with Search
class CarsPage extends StatefulWidget {
  const CarsPage({Key? key}) : super(key: key);

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Car> _allCars = [
    Car(name: 'Tesla Model 3', type: 'Electric', price: 89, available: true),
    Car(name: 'BMW X5', type: 'SUV', price: 120, available: true),
    Car(name: 'Mercedes C-Class', type: 'Sedan', price: 95, available: false),
    Car(name: 'Audi A4', type: 'Sedan', price: 85, available: true),
    Car(name: 'Toyota Camry', type: 'Sedan', price: 65, available: true),
    Car(name: 'Honda CR-V', type: 'SUV', price: 75, available: false),
    Car(name: 'Porsche 911', type: 'Sports', price: 250, available: true),
    Car(name: 'Ford Mustang', type: 'Sports', price: 120, available: true),
    Car(name: 'Chevrolet Tahoe', type: 'SUV', price: 110, available: true),
    Car(name: 'Nissan Altima', type: 'Sedan', price: 55, available: false),
  ];

  List<Car> get _filteredCars {
    if (_searchQuery.isEmpty) {
      return _allCars;
    }
    return _allCars.where((car) {
      final query = _searchQuery.toLowerCase();
      return car.name.toLowerCase().contains(query) ||
          car.type.toLowerCase().contains(query) ||
          car.price.toString().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Cars'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter dialog
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search cars by name, type, or price...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: _filteredCars.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No cars found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCars.length,
                    itemBuilder: (context, index) {
                      return CarCard(car: _filteredCars[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Car'),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Cars'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Available Only'),
              leading: const Icon(Icons.check_circle),
              onTap: () {
                // Implement filter
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('SUV'),
              leading: const Icon(Icons.directions_car),
              onTap: () {
                setState(() {
                  _searchQuery = 'SUV';
                  _searchController.text = 'SUV';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sedan'),
              leading: const Icon(Icons.directions_car),
              onTap: () {
                setState(() {
                  _searchQuery = 'Sedan';
                  _searchController.text = 'Sedan';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Electric'),
              leading: const Icon(Icons.electric_car),
              onTap: () {
                setState(() {
                  _searchQuery = 'Electric';
                  _searchController.text = 'Electric';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class Car {
  final String name;
  final String type;
  final double price;
  final bool available;

  Car({
    required this.name,
    required this.type,
    required this.price,
    required this.available,
  });
}

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[300],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Icon(
                Icons.directions_car,
                size: 80,
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        car.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text(car.available ? 'Available' : 'Rented'),
                      backgroundColor: car.available
                          ? (isDark ? Colors.green.shade700 : Colors.green.shade100)
                          : (isDark ? Colors.red.shade700 : Colors.red.shade100),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.category,
                      size: 16,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      car.type,
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${car.price}/day',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: car.available ? () {} : null,
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Book Now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Bookings Page with Search
class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Booking> _allBookings = [
    Booking(
      carName: 'Tesla Model 3',
      customer: 'John Doe',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
      status: 'Active',
      totalAmount: 267,
    ),
    Booking(
      carName: 'BMW X5',
      customer: 'Jane Smith',
      startDate: DateTime.now().add(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 5)),
      status: 'Upcoming',
      totalAmount: 480,
    ),
    Booking(
      carName: 'Mercedes C-Class',
      customer: 'Bob Johnson',
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      endDate: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Completed',
      totalAmount: 475,
    ),
    Booking(
      carName: 'Audi A4',
      customer: 'Alice Williams',
      startDate: DateTime.now().add(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 6)),
      status: 'Upcoming',
      totalAmount: 340,
    ),
    Booking(
      carName: 'Toyota Camry',
      customer: 'Charlie Brown',
      startDate: DateTime.now().subtract(const Duration(days: 14)),
      endDate: DateTime.now().subtract(const Duration(days: 10)),
      status: 'Completed',
      totalAmount: 260,
    ),
  ];

  List<Booking> get _filteredBookings {
    if (_searchQuery.isEmpty) {
      return _allBookings;
    }
    return _allBookings.where((booking) {
      final query = _searchQuery.toLowerCase();
      return booking.carName.toLowerCase().contains(query) ||
          booking.customer.toLowerCase().contains(query) ||
          booking.status.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by car, customer, or status...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: _filteredBookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No bookings found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredBookings.length,
                    itemBuilder: (context, index) {
                      return BookingListItem(booking: _filteredBookings[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class Booking {
  final String carName;
  final String customer;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double totalAmount;

  Booking({
    required this.carName,
    required this.customer,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalAmount,
  });
}

class BookingListItem extends StatelessWidget {
  final Booking booking;

  const BookingListItem({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    switch (booking.status) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Upcoming':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    booking.carName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(booking.status),
                  backgroundColor: isDark
                      ? statusColor.withOpacity(0.3)
                      : statusColor.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: isDark ? statusColor.shade200 : statusColor.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 8),
                Text(booking.customer),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(
                  '${DateFormat('MMM dd').format(booking.startDate)} - ${DateFormat('MMM dd, yyyy').format(booking.endDate)}',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${booking.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Page with Theme Toggle
class ProfilePage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ProfilePage({
    Key? key,
    required this.onThemeToggle,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: isDarkMode ? Colors.blue.shade700 : Colors.blue.shade100,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: isDarkMode ? Colors.blue.shade200 : Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Admin User',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'admin@carrental.com',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (_) => onThemeToggle(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment Methods'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
