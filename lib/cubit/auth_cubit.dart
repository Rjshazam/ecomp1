import 'package:ecomp/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthIntialState()){
    User? curruntuser = _auth.currentUser;
    if(curruntuser != null){
      emit(AuthLoggedinState(curruntuser));
    }
    else{
      emit(AuthLoggedOutState());
    }
  }

  String? _verificationId;

  void sendOTP(String phonenumber)async{
    emit(AuthLoadingState());
    await  _auth.verifyPhoneNumber(
      phoneNumber: phonenumber, 
      verificationCompleted: (PhoneAuthCredential){
        signwithphone(PhoneAuthCredential);
      }, 
      verificationFailed: (error){
        emit(AuthErrorState(error.message.toString()));
      }, 
      codeSent: (verificationId,forceResendingToken){
        _verificationId = verificationId;
      }, 
      codeAutoRetrievalTimeout: (verificationId){
        emit(AuthcodeSentState());
      }
      );
  }

  void verifyOTP(String otp)async{
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
    signwithphone(credential);
  }

  void signwithphone(PhoneAuthCredential credential)async{
    try {
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      if(userCredential.user != null) {
        emit( AuthLoggedinState(userCredential.user!) );
      }
    } on FirebaseAuthException catch(ex) {
      emit( AuthErrorState(ex.message.toString()) );
    }
  }
  void logout() async{
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }


  }