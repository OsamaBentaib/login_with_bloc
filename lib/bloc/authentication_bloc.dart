import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_login/repository/signup_user_repository.dart';
import 'package:bloc_login/repository/login_user_repository.dart';
import 'package:bloc_login/model/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUserRepository loginuserRepository;
  final SignupUserRepository signupuserRepository;

  AuthenticationBloc({@required this.loginuserRepository, @required this.signupuserRepository})
      : assert(LoginUserRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUnintialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {

      final bool hasloginToken = await loginuserRepository.hasToken();
      final bool hassignupToken = await signupuserRepository.hasToken();
      if (hasloginToken) {
        yield AuthenticationAuthenticated();
      } else if(hassignupToken) {
         yield AuthenticationAuthenticated();
      }else{ 
        yield AuthenticationUnauthenticated();
      }
     }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await loginuserRepository.persistToken(
        user: event.user
      );
      yield AuthenticationAuthenticated();
    }
    if (event is Registred) {
      yield AuthenticationLoading();
      await signupuserRepository.persistToken(
        user: event.user
      );
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      
      await loginuserRepository.delteToken(id: 0);
      await signupuserRepository.delteToken(id: 0);

      yield AuthenticationUnauthenticated();
    }
  }
}
