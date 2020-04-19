
import 'package:sqfliteapp/utils/network_util.dart';
import 'package:sqfliteapp/models/user.dart';

class RestData{
  NetworkUtil _networkUtil = NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL +"/";

  Future<User> login(String username, password){
    return Future.value(User(username, password));
  }
}