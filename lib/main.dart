import 'package:bloc_login/welcom.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/repository/login_user_repository.dart';
import 'package:bloc_login/repository/signup_user_repository.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/splash/splash.dart';
import 'package:bloc_login/home/home.dart';
import 'package:bloc_login/common/common.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print (transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final loginuserRepository = LoginUserRepository();
  final signupuserRepository = SignupUserRepository();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(
          loginuserRepository: loginuserRepository,
          signupuserRepository: signupuserRepository
        )..add(AppStarted());
      },
      child: App(loginuserRepository: loginuserRepository, signupuserRepository: signupuserRepository,),
    )
  );
}

class App extends StatelessWidget {
  final LoginUserRepository loginuserRepository;
  final SignupUserRepository signupuserRepository;

  App({Key key, @required this.signupuserRepository, @required this.loginuserRepository}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return WelcomScreen(loginuserRepository: loginuserRepository, signupuserRepository: signupuserRepository,);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}