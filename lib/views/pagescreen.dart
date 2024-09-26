import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPage extends StatefulWidget {
  final String date;

  NewPage({required this.date});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  List<String> notes = []; // List untuk menyimpan note
  final TextEditingController _noteController = TextEditingController(); // Controller untuk input note
  int? editingIndex; // Untuk mengidentifikasi index yang sedang di-edit
  late SharedPreferences prefs; // Instance dari SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Load catatan yang disimpan ketika widget diinisialisasi
  }

  // Fungsi untuk load catatan dari SharedPreferences
  Future<void> _loadNotes() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = prefs.getStringList(widget.date) ?? []; // Ambil catatan berdasarkan tanggal, default []
    });
  }

  // Fungsi untuk menyimpan catatan ke SharedPreferences
  Future<void> _saveNotes() async {
    await prefs.setStringList(widget.date, notes); // Simpan catatan berdasarkan tanggal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail for Date ${widget.date}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Enter note',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _noteController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (editingIndex == null) {
                    // Jika tidak dalam mode edit, tambahkan note baru
                    notes.add(_noteController.text);
                  } else {
                    // Jika dalam mode edit, update note yang dipilih
                    notes[editingIndex!] = _noteController.text;
                    editingIndex = null; // Kembali ke mode tambahkan
                  }
                  _noteController.clear(); // Bersihkan input field
                  _saveNotes(); // Simpan catatan setelah ada perubahan
                });
              },
              child: Text(editingIndex == null ? 'Add Note' : 'Update Note'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Text(note),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _noteController.text = note; // Isi textfield dengan note yang dipilih
                              editingIndex = index; // Set index yang sedang di-edit
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              notes.removeAt(index); // Hapus note
                              _saveNotes(); // Simpan setelah dihapus
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
