import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:subject_app/bloc.dart';
import './models/user_model.dart';
import './data/data_parser.dart';

void main() => runApp(MyApp());

Future<User> _loadUserFromJSON() async {
  String jsonString = await loadUserAsset();
  return userFromJson(jsonString);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static User _user;

  @override
  void initState() {
    super.initState();
    _loadUserFromJSON().then((user) {
      setState(() {
        print(user.name);
        _user = user;
      });
    });
  }

  UserBloc _userBloc = new UserBloc(initialUser: _user);

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userBloc.userObservable,
      builder: (context, snapshot) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'You have pushed the button this many times:1111',
            // ),
            Text(
              '${snapshot.hasData}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }

  Scaffold buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: null,
        // (index) {
        //   if (index == 0) _navbarBloc.add(NavBarItems.Account);
        //   if (index == 1) _navbarBloc.add(NavBarItems.Messages);
        //   if (index == 2) _navbarBloc.add(NavBarItems.Users);
        // },
        currentIndex: 0,
        selectedItemColor: Colors.amberAccent,
        items: [
          BottomNavigationBarItem(
            title: Text('Account'),
            icon: Icon(Icons.account_box),
          ),
          BottomNavigationBarItem(
            title: Text('Users'),
            icon: Icon(Icons.supervised_user_circle),
          ),
          BottomNavigationBarItem(
            title: Text('Messages'),
            icon: Icon(Icons.message),
          ),
        ],
      ),
    );
  }
}
