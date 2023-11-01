// // // ignore_for_file: must_be_immutable

// // part of 'auth_cubit.dart';

// // @immutable
// // abstract class AuthState {}

// // class AuthInitialState extends AuthState {}

// // class RegisterLoadingState extends AuthState {}

// // class RegisterSuccessState extends AuthState {}

// // class FailedToRegistergState extends AuthState {
// //   String message;
// //   FailedToRegistergState({required this.message});
// // }

// // class LoginLoadingState extends AuthState {}

// // class LoginSuccessState extends AuthState {}

// // class FailedToLoginState extends AuthState {
// //   final String message;
// //   FailedToLoginState({required this.message});
// // }

// abstract class AuthStates {}

// class AuthInitialState extends AuthStates {}

// class RegisterLoadingState extends AuthStates {}

// class RegisterSuccessState extends AuthStates {}

// class FailedToRegisterState extends AuthStates {
//   final String message;
//   FailedToRegisterState({required this.message});
// }

// class ChangeValueSuccessState extends AuthStates {}

// class LoginLoadingState extends AuthStates {}

// class LoginSuccessState extends AuthStates {}

// class FailedToLoginState extends AuthStates {
//   final String message;
//   FailedToLoginState({required this.message});
// }
abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class FailedToRegisterState extends AuthStates {
  final String message;
  FailedToRegisterState({required this.message});
}

class ChangeValueSuccessState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class FailedToLoginState extends AuthStates {
  final String message;
  FailedToLoginState({required this.message});
}
