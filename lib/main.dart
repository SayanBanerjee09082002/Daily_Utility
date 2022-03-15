import 'package:flutter/material.dart';
import '/screns/notes.dart';
import 'note_database/note_model.dart';

Future<void> main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: notes(),
    );
  }

}