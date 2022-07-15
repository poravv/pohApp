

import 'package:google_sign_in/google_sign_in.dart';

class LoginGoogle{
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) {
        print(value);
      });
    } catch (error) {
      print("error login google--------");
      print(error);

    }
  }
}