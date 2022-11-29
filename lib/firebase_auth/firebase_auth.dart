import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authintication {
  static final FirebaseAuth _auth= FirebaseAuth.instance;

  /// this is code is google sign
  static Future<User?> signinInWithGoogle1() async {

    // The `GoogleAuthProvider` can only be used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount != null) {
        final GoogleSignInAuthentication authentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken
        );
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;
      }
    } catch(err) {
      print('google signin err -> $err');
    }
    return user;
  }

  /// this is code is google crome
  static Future<void> signOut() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      await FirebaseAuth.instance.signOut();
      await googleSignIn.disconnect();
    }catch(err) {
      print('google signout err -> $err');
    }
  }

  /// this code is signin email and password
  static Future<User?> signInWithEmail({required String email,required String password }) async{
    print("email -> ${email}");
    print("password -> ${password}");
    User ? user;
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email:email,password:password );

      user = userCredential.user;
    } on FirebaseException catch (e) {
      print(e);
    }

    return user;
  }
}