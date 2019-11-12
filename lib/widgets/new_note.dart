import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../bloc.dart';

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  GetIt getIt = GetIt.I;
  List _notes;

  @override
  void initState() {
    getIt<UserModel>().userObservable.listen((user) {
      if (this.mounted) {
        setState(() {
          _notes = user.notes;
        });
      }
    });
    super.initState();
  }

  update() {
    if (this.mounted) {
      setState(() => {});
    }
  }

  @override
  void dispose() {
    getIt<UserModel>().removeListener(update);
    super.dispose();
  }

  final _noteController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final enteredNote = _noteController.text;
    if (enteredNote.isEmpty) return;

    getIt<UserModel>().addNewNote( enteredNote, _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Todo'),
              controller: _noteController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => {},
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Choosen!'
                        : DateFormat.yMMMd().format(_selectedDate)),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Add Note',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: ((_noteController.text.length == 0) ||
                      (_selectedDate == null))
                  ? null
                  : _submitData,
            )
          ],
        ),
      ),
    );
  }
}
