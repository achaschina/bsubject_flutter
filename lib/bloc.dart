import 'main.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import './data/data_parser.dart';
import './models/user_model.dart';

Future<User> _loadUserFromJSON() async {
  String jsonString = await loadUserAsset();
  return userFromJson(jsonString);
}

abstract class UserModel extends ChangeNotifier {
  void changeUserName();

  Observable<User> get userObservable;
}

class UserModelImplementation extends UserModel {
  User initialUser = new User();
  BehaviorSubject<User> subjectUser;

  UserModelImplementation() {
    _loadUserFromJSON().then((user) {
      subjectUser = new BehaviorSubject<User>.seeded(user);
      notifyListeners();
      getIt.signalReady(this);
    });
  }

  @override
  Observable<User> get userObservable => subjectUser.stream;

  @override
  void changeUserName() {
    initialUser.name = 'New Test Name';
    subjectUser.add(initialUser);
    notifyListeners();
  }
}
