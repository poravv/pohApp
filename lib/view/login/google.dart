

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginGoogle{
  // ignore: prefer_typing_uninitialized_variables
  var user;
  bool logueado=false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> login() async {
    logueado=true;
    try {
      _googleSignIn.signIn().then((value) => user);

      if(user==null ){
        logueado=false;
        return;
      }else{
        final googleAuth=await user.authentication;

        final credential =GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

      }


      await _googleSignIn.signIn().then((value) {
        print(value);
      });
    } catch (error) {
      print("error login google--------");
      print(error);

    }
  }

  void logOuth()async {
    await _googleSignIn.disconnect();
  }
}