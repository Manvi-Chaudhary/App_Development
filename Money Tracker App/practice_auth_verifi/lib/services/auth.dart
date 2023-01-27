import 'package:firebase_auth/firebase_auth.dart';
import 'package:practiceauthverifi/usermodel.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //custom made TheUser
  TheUser? _customuser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  //stream(flutter listen to changes snd by firebase auth and update ui according to that)
  /*1. the function is return a stream of User
    2. 'get' keyword is to declare as a getter, if we say .user for any object, 
    it will return the below syntax 
    3. authStateChanged is to notify about changes to the user's sign-in state
    4. method map() is to reassign for every FirebaseUser in _auth.authStateChange 
    it will change to _userFromFirebaseUser which is our User*/
  Stream<TheUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => user != null ? _customuser(user) : null);
  }

  //sign in anonym
  Future SigninAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  //sign in email password
  Future signinpass(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign up email password
  Future signuppass(email, password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //default database creation
      DatabaseService(uid: user!.uid, did: 'first').field("Person 1", 0, false);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //send 'reset password' email
  Future resetpass(email) async {
    try {
      final result = await _auth.sendPasswordResetEmail(email: email);
      return result;
    } catch (e) {
      return (e.toString());
    }
  }

  //sign out
  Future Signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
