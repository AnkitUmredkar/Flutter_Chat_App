import 'package:chatting_app/Components/my_textField.dart';
import 'package:chatting_app/Services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Global/global.dart';
import '../Model/user_model.dart';

class GoogleAuthService{
  GoogleAuthService._();
  static GoogleAuthService googleAuthService = GoogleAuthService._();
  //global sign in object
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try{
      GoogleSignInAccount? account = await googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      //todo show current user name and image in homePage
      AuthService.authService.getCurrentUser();
      print(userCredential.user!.email!);
      print(userCredential.user!.photoURL!);
      print(userCredential.user!.phoneNumber!);
    }catch(e){
      // showToast('Google SignIn Failed!');
      print(e.toString());
    }
  }

  Future<void> signOutFromGoogle() async {
    await googleSignIn.signOut();
  }
}
