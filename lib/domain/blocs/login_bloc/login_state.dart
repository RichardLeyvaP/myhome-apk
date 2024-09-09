import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/login_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginEmpty extends LoginState {
  final String message;

  const LoginEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class LoginSuccess extends LoginState {
  final Login user; // Cambiamos el tipo de `token` a `Login`

  const LoginSuccess(this.user); // Recibe el objeto `Login`

  //const LoginSuccess(this.token);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
