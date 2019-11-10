import 'package:rxdart/rxdart.dart';

import './models/user_model.dart';

enum NavBarItems { Account, Messages, Users }

class UserBloc {

  User initialUser = new User();
  BehaviorSubject<User> _subjectUser;

  UserBloc({initialUser}) {
    _subjectUser = new BehaviorSubject<User>.seeded(initialUser); //initializes the subject with element already
  }

  Observable<User> get userObservable => _subjectUser.stream;

  void changeUserName() {
    initialUser.name = 'New Test Name';
    print(initialUser);
    _subjectUser.add(initialUser);
  }

  // void decrement() {
  //   initialCount--;
  //   _subjectCounter.add(initialCount);
  // }

  void dispose() {
    _subjectUser.close();
  }
}
