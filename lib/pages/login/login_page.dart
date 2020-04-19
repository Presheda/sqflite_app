import 'package:flutter/material.dart';
import 'package:sqfliteapp/data/database_helper.dart';
import 'package:sqfliteapp/models/user.dart';
import 'package:sqfliteapp/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract{

  BuildContext _ctx;
  bool _isLoading;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState(){
    _presenter = LoginPagePresenter(this);
  }

  void _submit(){
    final form = formKey.currentState;
    if(form.validate()){
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text){
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: Text("Login"),
      color: Colors.green,
    );

    var loginForm = Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Sqflite App Login", textScaleFactor: 2.0),
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(labelText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
            ],
          ),
        ),
        loginBtn
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginFailure(String error) {
    // TODO: implement onLoginFailure
    _showSnackBar(error);
    setState(() {
      _isLoading = false;

    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;

    });
    var db = DatabaseHelper();
    await db.savedUser(user);
    Navigator.of(_ctx).pushNamed("/home");
  }
}
