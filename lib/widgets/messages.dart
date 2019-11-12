import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../service.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String _username;
  List _messages;
  GetIt getIt = GetIt.I;

  @override
  void initState() {
    getIt<UserModel>().userObservable.listen((user) {
      setState(() {
        _username = user.name;
        _messages = user.messages;
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

  @override
  Widget build(BuildContext context) {
    return (_messages != null)
        ? Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'Messages for: ${_username}',
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
              loadMessages()
            ],
          )
        : Text('loading...');
  }

  Widget loadMessages() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return ListTile(
              title: Text('${message.receiver}:'),
              subtitle: Text('${message.text}'));
        },
      ),
    );
  }
}
