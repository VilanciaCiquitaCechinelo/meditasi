import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meditasi/views/pagescreen.dart';
import 'package:meditasi/models/date_box.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<String> dateList = []; // List untuk menyimpan tanggal-tanggal
  late SharedPreferences prefs; // Instance SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadDates(); // Memuat tanggal dari Shared Preferences saat inisialisasi
  }

  // Fungsi untuk memuat daftar tanggal dari Shared Preferences
  Future<void> _loadDates() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      dateList = prefs.getStringList('dates') ?? []; // Memuat daftar tanggal atau inisialisasi kosong
    });
  }

  // Fungsi untuk menyimpan daftar tanggal ke Shared Preferences
  Future<void> _saveDates() async {
    await prefs.setStringList('dates', dateList); // Simpan daftar tanggal ke Shared Preferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Ganti dengan path ke gambar latar belakang Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Your Schedule',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemExtent: 70, // Tinggi total per item (termasuk jarak)
                    itemCount: dateList.length,
                    itemBuilder: (context, index) {
                      final date = dateList[index];
                      return Container(
                        height: 70, // Sesuaikan tinggi dengan itemExtent
                        child: DateBox(
                          date: date,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewPage(date: date)));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 30), // Atur jarak dari bawah
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (dateList.isEmpty) {
                  // Jika tidak ada kotak, tambahkan kotak pertama dengan tanggal saat ini
                  final currentDate = DateTime.now();
                  final formattedDate = DateFormat('d MMM y').format(currentDate);
                  dateList.add(formattedDate);
                } else {
                  // Jika sudah ada kotak, tambahkan kotak baru dengan tanggal berikutnya
                  final lastDate = DateFormat('d MMM y').parse(dateList.last);
                  final nextDate = lastDate.add(Duration(days: 1));
                  final formattedDate = DateFormat('d MMM y').format(nextDate);
                  dateList.add(formattedDate);
                  if (dateList.length > 8) {
                    // Jika jumlah kotak lebih dari 7, hapus kotak paling bawah
                    dateList.removeAt(0);
                  }
                }
                _saveDates(); // Simpan daftar tanggal setelah ada perubahan
              });
            },
            child: Icon(Icons.add), // Ikon +
          ),
        ),
      ),
    );
  }
}
