import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../../data.dart';
import '../entities/requests/sign_in_request.dart';
import '../entities/requests/sign_up_request.dart';

class RemoteUserProvider {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference<Map<String, dynamic>> _usersCollection = FirebaseFirestore.instance.collection('users');

  RemoteUserProvider({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<UserEntity?> get user {
    return _firebaseAuth.authStateChanges().flatMap((User? firebaseUser) async* {
      if(firebaseUser == null) {
        yield null;
      } else {
        yield await _usersCollection
          .doc(firebaseUser.uid)
          .get()
          .then((value) => UserEntity.fromJson(value.data()!));
      }
    });
  }

  Future<void> signIn(SignInRequest request) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: request.email, password: request.password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserEntity> signUp(SignUpRequest request) async {
    try {
      final UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: request.myUser.email,
        password: request.password
      );
      final String? uid = user.user?.uid;
      final UserEntity newUser = request.myUser;
      if (uid != null) {
        return request.myUser.copyWith(userId: uid);
      }

      return newUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> setUserData(UserEntity user) async {
    try {
      await _usersCollection
        .doc(user.userId)
        .set(user.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  } 
}
