import 'package:colocexam/models/user.dart';
import 'package:colocexam/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* login email && password */

  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result =  await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(ex){
      print(ex);
      return null;

    }
  }

  /* login without email && password (announymously) */

  Future loginAnonymously() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(ex){
      print(ex.toString());
      return null;
    }

  }

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  /* register email && password */

  Future registerWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('user_'+user.email.substring(0,5), user.email, '06XXXXXXXX');

      return _userFromFirebaseUser(user);
    }catch(ex){
      print(ex);
      return null;

    }
  }

  /* logout */

  Future logout() async {
    try{
      return await _auth.signOut();
    }
    catch(ex){
      print(ex);
      return null;
    }
  }

}