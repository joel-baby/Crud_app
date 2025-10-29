import 'package:app/note.dart';
import 'package:app/note_database.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final noteDatabse = NoteDatabase();

  final noteController = TextEditingController();

  // user wants to add new note

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Note'),
        content: TextField(controller: noteController),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newNote = Note(content: noteController.text);

              noteDatabse.createNote(newNote);

              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  // update a note

  void updateNote(Note note) {
    // pre-fill text controller with existing note
    noteController.text = note.content;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Note'),
        content: TextField(controller: noteController),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              noteDatabse.updateNote(note, noteController.text);

              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  // delete a note
  void deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              noteDatabse.deleteNote(note);

              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewNote();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        // will listen to this stream
        stream: noteDatabse.stream,
        builder: (context, snapshot) {
          // loading
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // loaded
          final notes = snapshot.data!;

          // Ui
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              return ListTile(
                title: Text(note.content),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => deleteNote(note),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
