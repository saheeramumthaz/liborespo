import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference bookCollection = FirebaseFirestore.instance.collection('books');

  Future<void> addBook(Book book) async {
    try {
      await bookCollection.add(book.toJson());
    } catch (e) {
      print("Error adding book: $e");
      // Handle the error accordingly
    }
  }

  Future<bool> bookExists(String bookNo, String isvnCode) async {
    try {
      final querySnapshot = await bookCollection
          .where('bookNo', isEqualTo: bookNo)
          .where('isvnCode', isEqualTo: isvnCode)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking if book exists: $e");
      // Handle the error accordingly
      return false;
    }
  }



  // Delete a book from Firestore
  Future<bool> deleteBook(String bid) async {
    try {
      await bookCollection.doc(bid).delete();
      return true;
    } catch (e) {
      print('Error deleting book: $e');
      return false;
    }
  }

  // Fetch a book by its ID from Firestore
  Future<Book?> getBookById(String bid) async {
    try {
      DocumentSnapshot docSnapshot = await bookCollection.doc(bid).get();
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
      QuerySnapshot querySnapshot = await bookCollection.get();
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
