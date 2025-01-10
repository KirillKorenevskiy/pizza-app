import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../../data.dart';

class MyUserProvider {
  final FirebaseAuth _firebaseAuth;
	final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection('users');

  MyUserProvider({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((User? firebaseUser) async* {
      if(firebaseUser == null) {
        yield MyUser.empty;
      } else {
        yield await usersCollection
          .doc(firebaseUser.uid)
          .get()
          .then((value) => UserMapper.fromEntity(MyUserEntity.fromJson(value.data()!)));
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

  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email, 
        password: password
      );
      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
        .doc(myUser.userId)
        .set(UserMapper.toEntity(myUser).toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  } 
}