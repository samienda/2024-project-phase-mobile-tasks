import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthIntialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated();

  @override
  List<Object?> get props => [];
}




class UnAuthenticated extends AuthState {
  const UnAuthenticated();

  @override
  List<Object?> get props => [];
}



