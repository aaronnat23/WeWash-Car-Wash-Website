import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const CarsPage(),
    const BookingsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
              children: [
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
      elevation: 2,
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
                    color: Colors.grey[600],
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
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.directions_car, color: Colors.blue),
        ),
        title: Text(carName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Customer: $customer\n${DateFormat('MMM dd, yyyy').format(date)}'),
        trailing: Chip(
          label: Text(status),
          backgroundColor: status == 'Active' ? Colors.green.shade100 : Colors.orange.shade100,
        ),
        isThreeLine: true,
      ),
    );
  }
}

// Cars Page
class CarsPage extends StatelessWidget {
  const CarsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = [
      Car(name: 'Tesla Model 3', type: 'Electric', price: 89, available: true),
      Car(name: 'BMW X5', type: 'SUV', price: 120, available: true),
      Car(name: 'Mercedes C-Class', type: 'Sedan', price: 95, available: false),
      Car(name: 'Audi A4', type: 'Sedan', price: 85, available: true),
      Car(name: 'Toyota Camry', type: 'Sedan', price: 65, available: true),
      Car(name: 'Honda CR-V', type: 'SUV', price: 75, available: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Cars'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return CarCard(car: cars[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Car'),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Icon(
                Icons.directions_car,
                size: 80,
                color: Colors.grey[600],
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
                    Text(
                      car.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      label: Text(car.available ? 'Available' : 'Rented'),
                      backgroundColor: car.available ? Colors.green.shade100 : Colors.red.shade100,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.category, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(car.type, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${car.price}/day',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
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

// Bookings Page
class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BookingListItem(
            carName: 'Tesla Model 3',
            customer: 'John Doe',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 3)),
            status: 'Active',
            totalAmount: 267,
          ),
          BookingListItem(
            carName: 'BMW X5',
            customer: 'Jane Smith',
            startDate: DateTime.now().add(const Duration(days: 1)),
            endDate: DateTime.now().add(const Duration(days: 5)),
            status: 'Upcoming',
            totalAmount: 480,
          ),
          BookingListItem(
            carName: 'Mercedes C-Class',
            customer: 'Bob Johnson',
            startDate: DateTime.now().subtract(const Duration(days: 7)),
            endDate: DateTime.now().subtract(const Duration(days: 2)),
            status: 'Completed',
            totalAmount: 475,
          ),
        ],
      ),
    );
  }
}

class BookingListItem extends StatelessWidget {
  final String carName;
  final String customer;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double totalAmount;

  const BookingListItem({
    Key? key,
    required this.carName,
    required this.customer,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
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
                Text(
                  carName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(status),
                  backgroundColor: statusColor.withOpacity(0.2),
                  labelStyle: TextStyle(color: statusColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 8),
                Text(customer),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text('${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd, yyyy').format(endDate)}'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
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

// Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, size: 50, color: Colors.blue),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Admin User',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'admin@carrental.com',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
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
