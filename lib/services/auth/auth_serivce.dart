import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/services/firestore_serivce/firestore_service.dart';

class AuthSerivce {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService _firestore = FirestoreService();

  User? get currentUser => auth.currentUser;

  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String pass,
    String userName,
  ) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      await _firestore.addUser(userName, email);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String pass,
  ) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
