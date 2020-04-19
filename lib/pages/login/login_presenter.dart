import 'package:sqfliteapp/data/rest_data.dart';
import 'package:sqfliteapp/models/user.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User user);
  void onLoginFailure(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;

  RestData api = RestData();

  LoginPagePresenter(this._view);

  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((User user) => _view.onLoginSuccess(user))
        .catchError((error) => _view.onLoginFailure(error));
  }
}
