import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _bookCollection = FirebaseFirestore.instance.collection('books');

  // Add a new book to Firestore
  Future<String?> addBook(Book book) async {
    try {
      DocumentReference docRef = await _bookCollection.add(book.toJson());
      // Set the bid after the document is created
      await docRef.update({'bid': docRef.id});
      return docRef.id;
    } catch (e) {
      print('Error adding book: $e');
      return null;
    }
  }



  // Delete a book from Firestore
  Future<bool> deleteBook(String bid) async {
    try {
      await _bookCollection.doc(bid).delete();
      return true;
    } catch (e) {
      print('Error deleting book: $e');
      return false;
    }
  }

  // Fetch a book by its ID from Firestore
  Future<Book?> getBookById(String bid) async {
    try {
      DocumentSnapshot docSnapshot = await _bookCollection.doc(bid).get();
      if (docSnapshot.exists) {
        return Book.fromJson(docSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching book by ID: $e');
      return null;
    }
  }

  // Fetch all books from Firestore
  Future<List<Book>> getAllBooks() async {
    try {
      QuerySnapshot querySnapshot = await _bookCollection.get();
      return querySnapshot.docs.map((doc) {
        Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
        book.bid = doc.id;
        return book;
      }).toList();
    } catch (e) {
      print('Error fetching all books: $e');
      return [];
    }
  }
}
