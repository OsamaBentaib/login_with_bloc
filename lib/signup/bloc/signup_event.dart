part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupButtonPressed extends SignupEvent {
  final String username;
  final String password1;
  final String password2;
  final String email;

  const SignupButtonPressed({
    @required this.username,
    @required this.password1,
    @required this.password2,
    @required this.email
  });

  @override
  List<Object> get props => [username, password1, password2, email];

  @override
  String toString() => 'SignupButtonPressed { username: $username, password1: $password1, password2: $password2, password: $email }';
}
