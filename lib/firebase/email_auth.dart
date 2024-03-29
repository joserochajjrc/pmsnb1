import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../models/github_login_request.dart';
import '../models/github_login_response.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class EmailAuth {

  final emailAuth = FirebaseAuth.instance;
  static const String CLIENT_ID = "15b6215cdb2ddf501d02";
  static const String CLIENT_SECRET =
      "cbc86513e9eabaf92d45332bd1ce6f9e3d9c21f9";

  Future<bool> createUserWithEmailAndPassword({required String email, required String password}) async{
    
    try {
      final userCredential = await emailAuth.createUserWithEmailAndPassword(
        email: email, password: password
      );

      userCredential.user!.sendEmailVerification();
      return true;

    } catch(e) {}
    return false;

  }

  Future<String> getUserToken() async {
    String token = '';
    try {
      User? user = emailAuth.currentUser;
      if (user != null) {
        token = await user.getIdToken();
      }
    } catch (e) {}
    return token;
  }

  Future<bool> signInWithEmailAndPassword({required String email, required String password}) async{  
    
    try{
      final userCredential = await emailAuth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user!.emailVerified) return true;
    } on FirebaseAuthException{
      
    } catch(e) {}
  return false;

  }

  Future<bool> sendResetPasswordLink({required String email}) async {
    try {
      final userCredential = await emailAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseException {} catch (e) {}
    return false;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope("https://www.googleapis.com/auth/contacts.readonly");

        await emailAuth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          UserCredential userCredential =
              await emailAuth.signInWithCredential(credential);
        }
      }
    } on FirebaseAuthException {
    } catch (e) {
      print('Error');
    }
  }

  Future<User> signInWithGithub(String code) async {
    final response = await http.post(
      "https://github.com/login/oauth/access_token" as Uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: CLIENT_ID,
        clientSecret: CLIENT_SECRET,
        code: code,
      )),
    );

    GitHubLoginResponse loginResponse =
        GitHubLoginResponse.fromJson(json.decode(response.body));

    final AuthCredential credential =
        GithubAuthProvider.credential(loginResponse.accessToken!);

    final User user = (await emailAuth.signInWithCredential(credential)).user!;
    return user;
  }

   Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    var userData = await FacebookAuth.instance.getUserData();

    var email = userData["email"];
    print(email);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signOut() async {
    try {
      await emailAuth.signOut();
      //await FirebaseAuth.instance.setPersistence(Persistence.NONE);
    } on FirebaseAuthException {
    } catch (e) {}
  }

  getCurrentUser(String email, String pwd) async {
    final user = await emailAuth.currentUser;
    final uid = user?.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    print(uid);
    //print(uemail);
  }

}