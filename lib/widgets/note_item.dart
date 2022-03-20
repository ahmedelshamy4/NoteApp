import 'package:flutter/material.dart';
import 'package:note_app/services/firestore_service.dart';

import '../model/note_model.dart';
import '../screen/edit_note_screen.dart';

class NoteItem extends StatelessWidget {
  final NoteModel noteModel;
  final String docsid;

  NoteItem({required this.noteModel, required this.docsid});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: <Widget>[
            new Expanded(
              child: new Text(noteModel.title),
            ),
          ],
        ),
        subtitle: Text(noteModel.description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(
                docsid: docsid,
                note: noteModel,
              ),
            ),
          );
        },
      ),
    );
  }
}
