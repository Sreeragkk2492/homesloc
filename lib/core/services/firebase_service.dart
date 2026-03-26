import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseService {
  static Future<void> init() async {
    try {
      debugPrint("Starting Firebase initialization...");
      // Initialize Firebase (with timeout)
      await Firebase.initializeApp().timeout(const Duration(seconds: 10));
      debugPrint("Firebase initialized successfully");

      debugPrint("Initializing Google Sign-In...");
      // Initialize Google Sign-In (Explicitly provide clientId to ensure it's picked up)
      await GoogleSignIn.instance
          .initialize(
            clientId: "345101271157-vml469ahgho9tqkprl22213bebhtrm6o.apps.googleusercontent.com",
          )
          .timeout(const Duration(seconds: 10));
      debugPrint("Google Sign-In initialized successfully");
    } catch (e) {
      debugPrint("Firebase/GoogleSignIn initialization error: $e");
      // We don't rethrow here to allow main() to proceed and show the UI
      // even if these background services fail to initialize.
    }
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

  static Future<({User? user, String? idToken})> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final AuthCredential authCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);

      // Get the Firebase ID Token (JWT)
      final String? firebaseIdToken = await userCredential.user?.getIdToken();

      return (user: userCredential.user, idToken: firebaseIdToken);
    } catch (e) {
      rethrow;
    }
  }
}
