import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqflite/sqflite.dart';
import '/widgets/editnote.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '/note_database/note_helper.dart';
import '/note_database/note_model.dart';

class ScreenNote extends StatefulWidget {
  @override
  _ScreenNote createState() => _ScreenNote();
}

class _ScreenNote extends State<ScreenNote> {
  late List<Note>? noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Note>[];
      updateListView();
    }

    return ClipRRect(
        child: Slidable(child: GestureDetector(child: getNoteListView())));
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: Stack(
            children: [InkWell( onTap: () {
              editnote(this.noteList![position]);
            },),
              ListTile(
                title: Text(this.noteList![position].title as String),
                subtitle: Text(this.noteList![position].date as String),
              ),],
          )
        );
      },
    );
  }

  void editnote(Note note) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteEditor(note);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = NoteDatabaseHelper._initializeNoteDatabase();
    dbFuture.then((database) {
      Future<List<Map<String, dynamic>>?> noteListFuture = NoteDatabaseHelper.queryAll();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList?.cast<Note>();
          this.count = noteList?.length as int;
        });
      });
    });
  }
}

