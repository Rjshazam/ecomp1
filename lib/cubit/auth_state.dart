import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}
class AuthIntialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthcodeSentState extends AuthState{}

class AuthCodeVerifiedState extends AuthState{}

class  AuthLoggedinState extends AuthState {
  final User firebaseUser;

  AuthLoggedinState(this.firebaseUser);
}
class AuthLoggedOutState extends AuthState{}
class AuthErrorState extends AuthState{
  final String error;

  AuthErrorState(this.error);

}