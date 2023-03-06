import 'package:app/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<String?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => (user != null) ? user.uid : null);
  }

  Future signinanon() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  //signing in
  Future signup(email, username, password) async {
    try {
      UserCredential res;
      res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Dataservice(uid: res.user!.uid).cred(email, username, password);

      return (res.user!.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signout() async {
    await _auth.signOut();
  }

  //signing in
  Future signin(username, password) async {
    try {
      UserCredential res;

      String? email = await Dataservice(uid: "").getemail(username, password);
      if (email == null) {
        return null;
      } else {
        res = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        return (res.user!.uid);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

//customuser funcion for converting user into
