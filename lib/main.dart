import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'tugas.dart';  // Impor file tugas.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kalender',
      theme: ThemeData(
        primaryColor: Colors.grey[800], // Warna primer abu-abu gelap
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.grey[800], // Warna utama
          secondary: Colors.grey,    // Warna sekunder
        ),
        scaffoldBackgroundColor: Colors.grey[300], // Latar belakang abu-abu terang
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey, // Warna latar belakang AppBar
        ),
      ),
      home: const BookingPage(),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void _saveBooking() {
    if (_selectedDay != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Konfirmasi Booking'),
          content: Text('Tanggal: ${_selectedDay.toString().substring(0, 10)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Tanggal harus dipilih!'),
          actions: [
            TextButton(
              onPressed: null,
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _navigateToTugasPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TugasPage(),  // Navigasi ke halaman TugasPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Kalender'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Aksi back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',  // Tampilkan hanya bulan
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _saveBooking,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToTugasPage,  // Tombol + untuk menuju halaman Tugas
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Pindahkan FAB ke tengah bawah
    );
  }
}
