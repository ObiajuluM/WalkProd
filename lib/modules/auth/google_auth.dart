import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String?> signInWithGoogle() async {
  // .then everything
  // showDialog(context: context, builder: (context) => const IdkLoading());
  try {
    // begin interactive process
    final user = GoogleSignIn();

    // sign in with google
    final gUser = await user.signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    /// sign in with firbase for user log
    // create a new user credential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);

    //
    // print(gAuth.accessToken);
    return gAuth.accessToken;
  } catch (e) {
    log(e.toString());
    // throw Exception("Google Sign In failed: $e");
  }
}
