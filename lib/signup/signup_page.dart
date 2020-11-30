import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/repository/signup_user_repository.dart';

import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/signup/bloc/signup_bloc.dart';
import 'package:bloc_login/signup/signup_form.dart';

class SignupPage extends StatelessWidget {
  final SignupUserRepository userRepository;

  SignupPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup | Home Hub'),
      ),
      body: BlocProvider(
        create: (context) {
          return SignupBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: SignupForm(),
      ),
    );
  }
}