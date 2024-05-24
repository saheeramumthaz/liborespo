import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot?> loginUser(String? email, String password) async {
    try {
      UserCredential userData = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());

      DocumentSnapshot userSnapshot =
      await _firestore.collection('login').doc(userData.user!.uid).get();

      String role = userSnapshot['role'];

      DocumentSnapshot? userDoc;



      var token = await userData.user!.getIdToken();





      if(role=='student'){
        userDoc = await _firestore
            .collection('students')
            .doc(userData.user!.uid)
            .get();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setString('token', token!);
        _pref.setString('name', userDoc['name']);
        _pref.setString('email', userDoc['email']);
        _pref.setString('phone', userDoc['phoneNumber']);
        _pref.setString('role', userDoc['role']);
        _pref.setString('course', userDoc['course']);
        _pref.setString('gender', userDoc['gender']);
        _pref.setString('academicYear', userDoc['academicYear']);

      }
      else if(role=='teacher'){
        userDoc = await _firestore
            .collection('teachers')
            .doc(userData.user!.uid)
            .get();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setString('token', token!);
        _pref.setString('name', userDoc['name']);
        _pref.setString('email', userDoc['email']);
        _pref.setString('phone', userDoc['phone']);
        _pref.setString('role', userDoc['role']);



      }if(role=='admin'){
        print(role);
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setString('token', token!);
        _pref.setString('name',"Admin");
        _pref.setString('email',userSnapshot['email']);
        _pref.setString('phone',"9895663498");
        _pref.setString('role', userSnapshot['role']);

      }



   if(role =='admin'){
     return userSnapshot;
   }

      return userDoc;
    } catch (e) {
      // Handle authentication errors
      print("Error logging in: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.clear();
    await _auth.signOut();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _token = pref.getString('token');
    return _token != null;
  }
}
