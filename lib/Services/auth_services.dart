import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  AuthService._();
  static AuthService authService = AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //todo CREATE ACCOUNT (SIGN UP)
  Future<String> createUserWithEmailAndPassword(String email,String password) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      //todo show current user email in homePage
      // controller.showCurrentUser(email, '');
      return "success";
    }catch(e) {
      return e.toString();
    }
  }

  //todo LOG IN (SIGN IN)
  Future<String> signInWithEmailAndPassword(String email,String password) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      //todo show current user email in homePage
      // controller.showCurrentUser(email, '');
      return "success";
    }catch(e){
      print('-----------------> Error is here');
      return e.toString();
    }
  }

  //todo LOG IN (SIGN IN) Anonymously
  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      // await FirebaseAuth.instance.signInAnonymously();
      // Handle successful login
      print('--- User signed in anonymously: ${userCredential.user!.email}');
      // controller.showCurrentUser('Anonymous', '');
    } on FirebaseAuthException catch (e) {
      // Handle errors
      print('Failed to sign in anonymously: ${e.message}');
    }
  }

  //todo SIGN OUT
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //todo GET CURRENT USER
  User? getCurrentUser(){
    User? user = _firebaseAuth.currentUser;
    if(user != null){
      // log("email : ${user.email!}");
      // controller.showCurrentUser(user.email ?? 'Anonymous', user.photoURL ?? '');
    }
    return user;
  }
}