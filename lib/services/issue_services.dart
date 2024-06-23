import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/issue_model.dart';

class BookIssueService {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  final CollectionReference _bookIssueCollection =
  FirebaseFirestore.instance.collection('book_issues');

  // Add a new book issue to Firestore
  Future<bool> addBookIssue(BookIssue bookIssue) async {
    try {
      await _bookIssueCollection.add(bookIssue.toMap());
      return true;
    } catch (e) {
      print('Error adding book issue: $e');
      return false;
    }
  }

  // Update a book issue in Firestore
  Future<bool> updateBookIssue(BookIssue bookIssue) async {
    try {
      await _bookIssueCollection.doc(bookIssue.bid).update(bookIssue.toMap());
      return true;
    } catch (e) {
      print('Error updating book issue: $e');
      return false;
    }
  }

  // Delete a book issue from Firestore
  Future<bool> deleteBookIssue(String id) async {
    try {
      await _bookIssueCollection.doc(id).delete();
      return true;
    } catch (e) {
      print('Error deleting book issue: $e');
      return false;
    }
  }

  // Fetch a book issue by its ID from Firestore
  Future<BookIssue?> getBookIssueById(String id) async {
    try {
      DocumentSnapshot doc = await _bookIssueCollection.doc(id).get();
      if (doc.exists) {
        return BookIssue.fromMap(doc.data() as Map<String, dynamic>)..bookNo = doc.id;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching book issue by ID: $e');
      return null;
    }
  }

  // Fetch all book issues from Firestore
  Future<List<BookIssue>> getAllBookIssues() async {
    try {
      QuerySnapshot querySnapshot = await _bookIssueCollection.get();
      return querySnapshot.docs.map((doc) {
        BookIssue bookIssue = BookIssue.fromMap(doc.data() as Map<String, dynamic>);
        bookIssue.bookNo = doc.id;
        return bookIssue;
      }).toList();
    } catch (e) {
      print('Error fetching all book issues: $e');
      return [];
    }
  }
}
