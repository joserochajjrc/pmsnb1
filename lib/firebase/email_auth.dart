import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {

  final emaiAuth = FirebaseAuth.instance;

  Future<bool> createUserWithEmailAndPassword({required String email, required String password}) async{
    
    try {
      final userCredential = await emaiAuth.createUserWithEmailAndPassword(
        email: email, password: password
      );

      userCredential.user!.sendEmailVerification();
      return true;

    } catch(e) {}
    return false;

  }

  Future<bool> signInWithEmailAndPassword({required String email, required String password}) async{  
    
    try{
      final userCredential = await emaiAuth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user!.emailVerified) return true;
    } on FirebaseAuthException{
      
    } catch(e) {}
  return false;

  }

}