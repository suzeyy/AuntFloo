import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future <User?> signUpUserWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      print('Firebase Auth Exception $e');
    }
    catch(e){
      print('Something went wrong.');
    }
    return null;
  }

  ///This function is to login user with email and password
  Future<User?> loginInWithEmailAndPassword(String email, String password) async{
    print('email $email and password $password');
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      print('Firebase Auth Exception $e');
    }
    catch(e){
      print('Something went wrong. $e');
    }
    return null;
  }
  void signout() async{
    try{
      await _auth.signOut();
    }catch(e){
      print('Error while signout');
    }

  }

}