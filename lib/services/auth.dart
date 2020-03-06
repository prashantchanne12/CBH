import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/services/Database.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String uid;

  AuthServices({this.uid});

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future userRegistrationwithEmailPasssword(
    String email,
    String password,
    String name,
    String selectedStream,
    String selectedClass,
    String interest,
  ) async {
    try {
      var now = DateTime.now();
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      await DatabaseServices(uid: user.uid).updateUserData(
          name,
          email,
          'https://cutewallpaper.org/21/hd-profile-pic/HD-Profile-Icon-Clip-Art-Vector-Pictures-Vector-Images-Design.jpg',
          DateFormat('dd-mm-yyyy').format(now),
          selectedStream,
          selectedClass,
          interest);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  getAnonymousUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isAnonymous;
  }

  Future userLoginWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
