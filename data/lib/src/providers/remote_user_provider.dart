import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../../data.dart';

class RemoteUserProvider {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection('users');

  RemoteUserProvider({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<UserEntity?> get user {
    return _firebaseAuth.authStateChanges().flatMap((User? firebaseUser) async* {
      if(firebaseUser == null) {
        yield null;
      } else {
        yield await usersCollection
          .doc(firebaseUser.uid)
          .get()
          .then((value) => UserEntity.fromJson(value.data()!));
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserEntity> signUp(UserEntity entity, String password) async {
    try {
      final UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: entity.email,
        password: password
      );
      final String? uid = user.user?.uid;
      if (uid != null) {
        entity.userId = uid;
      }

      return entity;
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
      await usersCollection
        .doc(user.userId)
        .set(user.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  } 
}
