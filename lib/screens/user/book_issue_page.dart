import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/book_model.dart';
import '../../models/issue_model.dart';
import '../../services/book_services.dart';
import '../../services/issue_services.dart';


class BookIssuePage extends StatefulWidget {
  @override
  _BookIssuePageState createState() => _BookIssuePageState();
}

class _BookIssuePageState extends State<BookIssuePage> {
  final _formKey = GlobalKey<FormState>();
  final _issueDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _issuerNameController = TextEditingController();

  Book? _selectedBook;
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    _books = await BookService().getAllBooks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Book'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<Book>(
                decoration: InputDecoration(
                  labelText: 'Select Book',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                items: _books.map((Book book) {
                  return DropdownMenuItem<Book>(
                    value: book,
                    child: Text('${book.bookNo} - ${book.title}'),
                  );
                }).toList(),
                onChanged: (Book? book) {
                  setState(() {
                    _selectedBook = book;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a book';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              if (_selectedBook != null) ...[
                Text('Book No: ${_selectedBook!.bookNo}'),
                Text('Title: ${_selectedBook!.title}'),
                Text('Author(s): ${_selectedBook!.authors}'),
              ],
              SizedBox(height: 16),
              TextFormField(
                controller: _issueDateController,
                decoration: InputDecoration(
                  labelText: 'Issue Date',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter issue date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _returnDateController,
                decoration: InputDecoration(
                  labelText: 'Return Date',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter return date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _issuerNameController,
                decoration: InputDecoration(
                  labelText: 'Issuer Name',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter issuer name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // text color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _selectedBook != null) {
                      final bookIssue = BookIssue(
                        bookNo: _selectedBook!.bookNo,
                        title: _selectedBook!.title,
                        authors: _selectedBook!.authors,
                        issueDate: _issueDateController.text,
                        returnDate: _returnDateController.text,
                        issuerName: _issuerNameController.text,
                      );

                      bool success = await BookIssueService().addBookIssue(bookIssue);

                      if (success) {
                        // Navigate back or show a success message
                        Navigator.pop(context);
                      } else {
                        // Show an error message if the book issue was not added successfully
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error issuing book')),
                        );
                      }
                    }
                  },
                  child: Text('Issue Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
