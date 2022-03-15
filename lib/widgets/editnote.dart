import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../note_database/note_model.dart';
import '/note_database/note_helper.dart';

class NoteEditor extends StatefulWidget {
  final Note note;

  NoteEditor(this.note);

  @override
  _NoteEditor createState() {
    return _NoteEditor(this.note);
  }
}

class _NoteEditor extends State<NoteEditor> {
  late Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _NoteEditor(this.note);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title!;
    descriptionController.text = note.description!;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => delete(),
                barrierDismissible: false,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('Edit Title'),
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
              controller: titleController,
              onChanged: (value) {
                updateTitle();
              },
            ),
            SizedBox(
              height: 50,
            ),
            Text('Edit Description'),
            TextField(
              maxLines: 13,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
              controller: descriptionController,
              onChanged: (value) {
                updateDescription();
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        save();
                      });
                    },
                    child: Text('Save')))
          ],
        ));
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
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

class delete extends StatelessWidget {

  late Note note;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ARE YOU SURE'),
      content: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                child: FloatingActionButton(
                  child: Text('Yes'),
                  onPressed: _delete,
                ),
              ),
              Container(
                child: FloatingActionButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  void _delete() async {
    await NoteDatabaseHelper.delete(note);
  }
}
