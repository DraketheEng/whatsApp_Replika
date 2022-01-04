import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  User? isSignIn = FirebaseAuth.instance.currentUser;

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  UserCredential result =
      await FirebaseAuth.instance.signInWithCredential(credential);

  if (result.user != null) {
    User? user = result.user;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(result.user?.uid)
        .get();

    if (!documentSnapshot.exists) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.idToken)
          .set({"username": user?.displayName, "email": user?.email});
    }
  }

  return result;
}
