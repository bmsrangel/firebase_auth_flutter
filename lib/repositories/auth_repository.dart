import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> googleLogIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  Future<FirebaseUser> emailPassLogIn(String email, String pass) async {
    try {
      final AuthResult authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return authResult?.user;
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> emailPassSignIn(String email, String pass) async {
    final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    return authResult?.user;
  }

  Future<FirebaseUser> checkLoggedUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future logoff() async {
    await this._auth.signOut();
  }
}
