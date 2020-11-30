import 'dart:async';
import 'package:bloc_login/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:bloc_login/model/signup_api_model.dart';
import 'package:bloc_login/api_connection/signup_api_connection.dart';
import 'package:bloc_login/dao/user_dao.dart';

class SignupUserRepository {
  final userDao = UserDao();

  Future<User> authenticate ({
    @required String username,
    @required String password1,
    @required String password2,
    @required String email,
  }) async {
    UserSignUp userSignup = UserSignUp(
      username: username,
      password1: password1,
      password2: password2,
      email: email,
    );
    Token token = await getToken(userSignup);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken ({
    @required User user
    }) async {
    // write token with the user to the database
      await userDao.createUser(user);
  }

  Future <void> delteToken({
    @required int id
  }) async {
    await userDao.deleteUser(id);
  }

  Future <bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}