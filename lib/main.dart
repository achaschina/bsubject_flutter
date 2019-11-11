import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import './bloc.dart';
import './widgets/messages.dart';
import './widgets/notes.dart';
import './widgets/user_card.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<UserModel>(UserModelImplementation(),
      signalsReady: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  _bottomNavigationTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  update() => setState(() => {});

  @override
  void dispose() {
    getIt<UserModel>().removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Manager App'),
      ),
      body: streamBuilder(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _bottomNavigationTap,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amberAccent,
        items: [
          BottomNavigationBarItem(
            title: Text('Account'),
            icon: Icon(Icons.account_box),
          ),
          BottomNavigationBarItem(
            title: Text('Notes'),
            icon: Icon(Icons.note_add),
          ),
          BottomNavigationBarItem(
            title: Text('Messages'),
            icon: Icon(Icons.message),
          ),
        ],
      ),
    );
  }

  Widget streamBuilder() {
    return StreamBuilder(
      stream: getIt.ready,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Select lot');
          case ConnectionState.waiting:
            return Text('Awaiting bids...');
          case ConnectionState.active:
            return (snapshot.data != null)
                ? switchPage(snapshot.data)
                : Text('Cant load User from backend');
          case ConnectionState.done:
            return Text('\$${snapshot.data} (closed)');
        }
      },
    );
  }

  Widget switchPage(data) {
    switch (_currentIndex) {
      case 0:
        return UserCard();
        break;
      case 1:
        return Notes();
        break;
      case 2:
        return Messages();
        break;
    }
  }
}
