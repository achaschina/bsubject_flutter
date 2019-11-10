import 'package:flutter/material.dart';
import './models/user_model.dart';
import './data/data_parser.dart';



abstract class ApplicationState {
}

abstract class UserState {
  // final String title = 'Account';
  // User user = getUser();

  static User getUser() {
    loadUserAsset().then((userJSON) {
      return userFromJson(userJSON);
    });
  }
  // final Color bgColor = Colors.blue;
  // final int itemIndex = 0;
}

class ShowMessages extends ApplicationState {
  final String title = 'Messages';
  final Color bgColor = Colors.indigo;
  final int itemIndex = 1;
  final User user = UserState.getUser();
}

class ShowUsers extends ApplicationState {
  final String title = 'Users';
  final Color bgColor = Colors.lime;
  final int itemIndex = 2;
}