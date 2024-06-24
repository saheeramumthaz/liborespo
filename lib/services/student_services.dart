import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/student_model.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'students';

  Future<bool> registerStudent(Student student) async {




    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: student.email.toString(), password: student.password.toString());
     var id = userResponse.user!.uid;


     FirebaseFirestore.instance.collection('login').doc(id).set({

       'uid':id,
       'role':student.role,
       'email':student.email
     });


     final studentModel=Student(

       uid:id,
       academicYear: student.academicYear,
       name: student.name,
       email: student.email,
       password: student.password,
       phoneNumber: student.phoneNumber,
       course: student.course,
       gender: student.gender,
       role: student.role,
       status: student.status,
       createdAt: student.createdAt



     );


      await _firestore.collection(_collectionPath).doc(id).set(studentModel.toJson());
      return true;
    } catch (e) {
      print('Error registering student: $e');
      return false;
    }
  }

  Future<List<Student>> getAllStudents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collectionPath).get();
      List<Student> students = [];
      querySnapshot.docs.forEach((doc) {
        students.add(Student.fromJson(doc.data() as Map<String, dynamic>));
      });
      return students;
    } catch (e) {
      print('Error fetching students: $e');
      return [];
    }
  }

  Future<bool> updateStudent(Student student) async {
    try {
      await _firestore.collection(_collectionPath).doc(student.uid).update(student.toJson());
      return true;
    } catch (e) {
      print('Error updating student: $e');
      return false;
    }
  }

  Future<bool> deleteStudent(String uid) async {
    try {
      await _firestore.collection(_collectionPath).doc(uid).delete();
      return true;
    } catch (e) {
      print('Error deleting student: $e');
      return false;
    }
  }
}
