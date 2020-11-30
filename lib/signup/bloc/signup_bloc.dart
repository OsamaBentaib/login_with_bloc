import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/repository/signup_user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  SignupBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  SignupState get initialState => SignupInitial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupButtonPressed) {
      yield SignupInitial();

      try {
        final user = await userRepository.authenticate(
          username: event.username,
          password1: event.password1,
          password2: event.password2,
          email: event.email,
        );

        authenticationBloc.add(Registred(user: user));
        yield SignupInitial();
      } catch (error) {
        yield SignupFaliure(error: error.toString());
      }
    }
  }
}
