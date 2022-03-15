import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '/note_database/note_helper.dart';
import '/note_database/note_model.dart';

class NoteAdder extends StatefulWidget {

  @override
  _NoteAdder createState() => _NoteAdder();
}

class _NoteAdder extends State<NoteAdder> {
  late Note note;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.lime,
        content: Column(
          children: [
            const Text(
              'ADD NOTE',
              style: TextStyle(fontSize: 25),
            ),

            const SizedBox(height: 30),

            Container(
              alignment: Alignment.topLeft,
              child: const Text('Title:'),
            ),

            const TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              alignment: Alignment.topLeft,
              child: const Text('Description:'),
            ),

            const TextField(
              maxLines: 13,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(height: 35),

            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      setState(() {
                        save();
                      });
                    },
                    child: const Text('Save')))
          ],
        ));
  }

  void save() async {
    note.date = DateFormat.yMMMd().format(DateTime.now()) as DateTime?;
    if (note.id != null) {
      await NoteDatabaseHelper.update(note);
    } else {
      await NoteDatabaseHelper.insert(note);
    }
  }

}
