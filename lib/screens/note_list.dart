import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notekeeper/screens/note_detail.dart';
import 'dart:async';
import 'package:notekeeper/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notekeeper/utils/database_helper.dart';

class Notelist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
} // will return state of list

class NoteListState extends State<Notelist> {
  //////////// state is Notelist (remember)

  DatabaseHelper databaseHelper =
      DatabaseHelper(); // singleton object of database

  List<Note> noteList; // variable for note

  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNotelistview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('taaaped');
          navigateToDetails('ADD NOTE');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  // ListView method type
  ListView getNotelistview() {
    TextStyle titlestyle = Theme.of(context)
        .textTheme
        .subhead; // style of text for whole code base

    return ListView.builder(
        // this is builder for list view
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              // tile in list
              leading: CircleAvatar(
                  child: getPriorityIcon(this.noteList[position].priority),
                  backgroundColor: getPriorityColor(
                      this.noteList[position].priority) // chdck out [position]
                  ),
              title: Text(
                'Dummy Title',
                style: titlestyle,
              ),
              subtitle: Text(this.noteList[position].date),

              trailing: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, noteList[position]);
                  }),
            ),
          );
        });
  }

// Return priority color

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

// Return priority icon

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.play_arrow);
    }
  }

// Delete-ICON function

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted successfully');
    }
  }

// snackBar message
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  /// navigate-funtion to navigate to the details page

  void navigateToDetails(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title);
    }));
  }
}
