import 'package:bloc_login/login/login_page.dart';
import 'package:bloc_login/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc_login/repository/login_user_repository.dart';
import 'package:bloc_login/repository/signup_user_repository.dart';


class WelcomScreen extends StatelessWidget {
  final LoginUserRepository loginuserRepository;
  final SignupUserRepository signupuserRepository;

  WelcomScreen({Key key, @required this.loginuserRepository, @required this.signupuserRepository})
      : assert(loginuserRepository != null || signupuserRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage(
                        userRepository: loginuserRepository,
                      );
                    },
                  ),
                );
            },
            child: Text("Login"),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupPage(
                        userRepository: signupuserRepository,
                      );
                    },
                  ),
                );
            },
            child: Text("SignUp"),
          ),
        ],
      ),
    );
  }
}