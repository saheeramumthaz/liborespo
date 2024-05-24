import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/teacher_model.dart';

class TeacherService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'teachers';

  Future<bool> registerTeacher(Teacher teacher) async {
    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: teacher.email.toString(),
          password: teacher.password.toString());
      var id = userResponse.user!.uid;


      FirebaseFirestore.instance.collection('login').doc(id).set({

        'uid': id,
        'role': teacher.role,
        'email': teacher.email
      });
      final teacherModel = Teacher(

          uid: id,

          name: teacher.name,
          email: teacher.email,
          password: teacher.password,
          phone: teacher.phone,

          role: teacher.role,
          status: teacher.status,
          createdAt: teacher.createdAt


      );


      await _firestore.collection(_collectionPath).doc(id).set(
          teacherModel.toJson());
      return true;
    } catch (e) {
      print('Error registering teachers: $e');
      return false;
    }
  }




  // Delete a teacher from Firestore
  Future<bool> deleteTeacher(String uid) async {
    try {
      await _firestore.collection(_collectionPath).doc(uid)
        ..delete();
      return true;
    } catch (e) {
      print('Error deleting teacher: $e');
      return false;
    }
  }
}



