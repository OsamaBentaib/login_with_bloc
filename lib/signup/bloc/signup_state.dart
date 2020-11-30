part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupFaliure extends SignupState {
  final String error;

  const SignupFaliure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' SignupFaliure { error: $error }';
}
