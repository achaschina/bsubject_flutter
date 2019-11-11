import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../bloc.dart';

import '../models/user_model.dart';

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  GetIt getIt = GetIt.I;
  User _user;

  @override
  void initState() {
    getIt<UserModel>().userObservable.listen((user) {
      setState(() {
        _user = user;
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
    Widget userWidget = (_user != null) ? buildUserCard() : Text('loading...');
    return userWidget;
  }

  Widget buildUserCard() {
    return Container(
        child: Card(
      margin: EdgeInsets.all(15),
      elevation: 6,
      child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/ava.png'),
            radius: 30,
          ),
          title: Container(
            child: Text(
              '${_user.name}',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          subtitle: Text('Email: ${_user.email}')),
    ));
  }
}
