import 'package:flutter/material.dart';
import 'models/book_model.dart';
import 'services/book_services.dart';
import 'screens/admin/add_book.dart';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List<Book> _selectedBooks = [];
  List<Book> _books = [];
  bool _isDeleteMode = false;

  @override
  void initState() {
    super.initState();
    // Fetch books when the page is initialized
    _fetchBooks();
  }

  // Function to fetch all books from Firestore
  Future<void> _fetchBooks() async {
    final books = await BookService().getAllBooks();
    setState(() {
      _books = books;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) {
            final book = _books[index];
            final isSelected = _selectedBooks.contains(book);
            return ListTile(
              title: Text(book.title ?? ''), // Add null check
              subtitle: Text(book.authors ?? ''), // Add null check
              trailing: _isDeleteMode
                  ? Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedBooks.add(book);
                    } else {
                      _selectedBooks.remove(book);
                    }
                  });
                },
              )
                  : null,
              onTap: _isDeleteMode
                  ? () {
                setState(() {
                  if (isSelected) {
                    _selectedBooks.remove(book);
                  } else {
                    _selectedBooks.add(book);
                  }
                });
              }
                  : null,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                // Navigate to BookAddingPage to add a new book
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookAddingPage()),
                );
                // Refresh the list after adding a book
                _fetchBooks();
              },
              backgroundColor: Colors.teal,
              child: Icon(Icons.add),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  // Toggle delete mode
                  _isDeleteMode = !_isDeleteMode;
                  if (!_isDeleteMode) {
                    _selectedBooks.clear();
                  }
                });
              },
              backgroundColor: Colors.teal,
              child: Icon(Icons.delete),
            ),
            SizedBox(height: 10),
            if (_isDeleteMode)
              FloatingActionButton(
                onPressed: () async {
                  for (var book in _selectedBooks) {
                    // Delete selected books
                    await BookService().deleteBook(book.bid!);
                  }
                  setState(() {
                    _selectedBooks.clear();
                    _isDeleteMode = false;
                  });
                  // Refresh the list after deleting books
                  _fetchBooks();
                },
                backgroundColor: Colors.red,
                child: Icon(Icons.check),
              ),
          ],
        ),
      ),
    );
  }
}
