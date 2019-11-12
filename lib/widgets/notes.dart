import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import './new_note.dart';
import '../service.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  GetIt getIt = GetIt.I;
  // User _user;
  List _notes;

  @override
  void initState() {
    getIt<UserModel>().userObservable.listen((user) {
      setState(() {
        _notes = user.notes;
      });
    });
    super.initState();
  }

  update() => setState(() => {});

  @override
  void dispose() {
    getIt<UserModel>().removeListener(update);
    super.dispose();
  }

  _startAddNewNote(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Note(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_notes != null) ? buildNotesList() : Text('loading'),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewNote(context),
        ));
  }

  Widget buildNotesList() {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        final date = DateFormat.yMMMd().format(note.when);
        return Card(
          child:
              ListTile(title: Text('${note.what}'), subtitle: Text('${date}')),
        );
      },
    );
  }
}
