import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import './models/user_model.dart';
import './state.dart';

enum NavBarItems { Account, Messages, Users }

class UserBloc {
  // @override
  // ApplicationState get initialState => ShowMessages();

  // @override
  // Stream<ApplicationState> mapEventToState(NavBarItems event) async* {
  //   // switch (event) {
  //   //   case NavBarItems.Users:
  //   //     yield ShowUsers();
  //   //     break;
  //   //   case NavBarItems.Messages:
  //   //     yield ShowMessages();
  //   //     break;
  //   //   default:
  //   //     yield ShowAccount();
  //   //     break;
  //   // }
  // }


  User initialUser;
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
