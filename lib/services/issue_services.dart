import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/issue_model.dart';


class BookIssueService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new book issue record
  Future<bool> addBookIssue(BookIssue bookIssue) async {
    try {
      await _firestore.collection('bookIssues').add(bookIssue.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Read a book issue record by its ID
  Future<BookIssue?> getBookIssueById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('bookIssues').doc(id).get();
      if (doc.exists) {
        return BookIssue(
          bookNo: doc['bookNo'],
          title: doc['title'],
          authors: doc['authors'],
          issueDate: doc['issueDate'],
          returnDate: doc['returnDate'],
          issuerName: doc['issuerName'],
          issuedTo: doc['issuedTo'],
          issuerId: doc['issuerId'],
        );
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Read all book issue records
  Future<List<BookIssue>> getAllBookIssues() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('bookIssues').get();
      return snapshot.docs.map((doc) {
        return BookIssue(
          bookNo: doc['bookNo'],
          title: doc['title'],
          authors: doc['authors'],
          issueDate: doc['issueDate'],
          returnDate: doc['returnDate'],
          issuerName: doc['issuerName'],
          issuedTo: doc['issuedTo'],
          issuerId: doc['issuerId'],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Update a book issue record by its ID
  Future<bool> updateBookIssue(String id, BookIssue bookIssue) async {
    try {
      await _firestore.collection('bookIssues').doc(id).update(bookIssue.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Delete a book issue record by its ID
  Future<bool> deleteBookIssue(String id) async {
    try {
      await _firestore.collection('bookIssues').doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
