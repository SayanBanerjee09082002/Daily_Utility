import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/note_database/note_model.dart';
import '/widgets/notes.dart';
import '/widgets/addnote.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '/note_database/note_helper.dart';


class notes extends StatefulWidget {
  @override
  _notes createState() => _notes();
}

class _notes extends State<notes> {


  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Screen1(),
          Screen2(),
          Screen1(),
        ],
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTappedBar,
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'To-Do'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed')
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => NoteAdder(),
          barrierDismissible: false,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('1'), backgroundColor: Colors.amber),
        body: ScreenNote());
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('NOTES'), backgroundColor: Colors.amber),
        body: Container(
      color: Colors.blueAccent,
    ));
  }
}

