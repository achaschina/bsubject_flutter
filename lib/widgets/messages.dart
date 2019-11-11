import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../bloc.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List _messages;
  GetIt getIt = GetIt.I;

  @override
  void initState() {
    getIt<UserModel>().userObservable.listen((user) {
      setState(() {
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
    return (_messages != null) ? loadMessages() : Text('loading...');
  }

  Widget loadMessages() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return ListTile(
            title: Text('${message.receiver}:'),
            subtitle: Text('${message.text}'));
      },
    );
  }
}
