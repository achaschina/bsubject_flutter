import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:subject_app/models/user_model.dart';
import '../service.dart';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  User _user;
  String email;
  bool _autoValidate = false;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GetIt getIt = GetIt.I;

  @override
  void initState() {
    getIt<UserModel>().userObservable.listen((user) {
      if (this.mounted) {
        setState(() {
          _user = user;
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

  void saveUser() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      final username = _usernameController.text;
      final email = _emailController.text;

      getIt<UserModel>().updateUser(username, email);

      Navigator.of(context).pop();
    } else {
      setState(() => _autoValidate = true);
    }

    // if (username.isEmpty || email.isEmpty) return;

    // print('edit');
  }

  String _validateUsername(String value) {
    return (value.isEmpty) ? "Enter username" : null;
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Enter email address";
    }
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'Email is not valid';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                validator: _validateUsername,
                decoration: const InputDecoration(labelText: 'Username'),
                controller: _usernameController,
                textInputAction: TextInputAction.done,
              ),
              TextFormField(
                validator: _validateEmail,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                textInputAction: TextInputAction.done,
                onSaved: (String value) {
                  email = value;
                },
                // onSubmitted: (_) => {},
              ),
              SizedBox(
                height: 45,
              ),
              RaisedButton(
                child: Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: saveUser,
              )
            ],
          ),
        ),
      ),
    );
  }
}
