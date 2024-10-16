import 'package:flutter/material.dart';

class TugasPage extends StatefulWidget {
  const TugasPage({super.key});

  @override
  _TugasPageState createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage> {
  bool isAllDay = false;
  String eventType = 'Tugas'; // Default selection is 'Tugas'
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan judul'),
        actions: [
          TextButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Booking Tersimpan'),
                    content: Text('Judul: ${_titleController.text}\nTipe: $eventType'),
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
              }
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Acara'),
                  selected: eventType == 'Acara',
                  onSelected: (selected) {
                    setState(() {
                      eventType = 'Acara';
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Tugas'),
                  selected: eventType == 'Tugas',
                  onSelected: (selected) {
                    setState(() {
                      eventType = 'Tugas';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tambahkan judul',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),

              ],
            ),
            const SizedBox(height: 20),


            const SizedBox(height: 20),


            const Spacer(),
          ],
        ),
      ),
    );
  }
}
