// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:application/services/firebase_auth/user_model.dart';
import 'package:application/services/storage/storage.dart';
import 'package:application/services/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  FirebaseAuthService(this._auth);

  // Sign up
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then(
        (_) async {
          final AuthUserModel userModel = AuthUserModel(
            email: email,
            password: password
          );

          final String userModelString = jsonEncode(userModel.toJson());

          StorageService.setString(
            key: "useremailpass", 
            value: userModelString
          );
          
        }
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) Utils.showSnackBar(context, e.message!);
      return false;
    } catch (e) {
      if (context.mounted) Utils.showSnackBar(context, e.toString());
      return false;
    }
  }

  // EMAIL LOGIN
  Future<bool> loginWithEmail({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then(
        (UserCredential userCredential) async {
          final AuthUserModel userModel = AuthUserModel(
            email: email,
            password: password
          );

          final String userModelString = jsonEncode(userModel.toJson());

          StorageService.setString(
            key: "useremailpass", 
            value: userModelString
          );
        }
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (context?.mounted == true) Utils.showSnackBar(context!, e.message!); 
      return false;
    } catch (e) {
      if (context?.mounted == true) Utils.showSnackBar(context!, e.toString()); 
      return false;
    }
  }
  
  // SIGN OUT
  Future<bool> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) Utils.showSnackBar(context, e.message!);
      return false;
    } catch (e) {
      if (context.mounted) Utils.showSnackBar(context, e.toString()); 
      return false;
    }
  }

  // DELETE ACCOUNT
  Future<bool> deleteAccount() async {
    try {
      String? cred = await StorageService.getString(key: 'useremailpass');

      AuthUserModel credential = AuthUserModel.fromJson(jsonDecode(cred??""));

      AuthCredential authCredential = EmailAuthProvider.credential(
        email: credential.email ?? "", password: credential.password ?? ""
      );

      await _auth.currentUser?.reauthenticateWithCredential(authCredential)
        .then(
          (value) async {
            await value.user?.delete();      
          }
      );
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}