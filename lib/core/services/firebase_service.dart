import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static Future<void> init() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Initialize Google Sign-In (v7.1.1 API mandatory initialization)
    await GoogleSignIn.instance.initialize();
  }

  static Future<({User? user, String? idToken})> signInWithGoogle() async {
    try {
      // Trigger authentication. This opens the system account picker/Credential Manager.
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn.instance.authenticate();
      if (googleUser == null) {
        return (user: null, idToken: null);
      }

      // Request authorization for scopes to obtain the idToken.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception("Missing ID Token");
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      
      // Get the Firebase ID Token (JWT) instead of the Google ID Token
      final String? firebaseIdToken = await userCredential.user?.getIdToken();

      return (user: userCredential.user, idToken: firebaseIdToken);
    } catch (e) {
      rethrow;
    }
  }
}
