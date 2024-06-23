import 'package:flutter/material.dart';
import 'package:infolibra/services/book_services.dart';
import 'package:infolibra/outage_verification.dart';
import '../models/book_model.dart';


class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late List<Book> _books;
  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    // Load all books from the service
    _books = await BookService().getAllBooks();
    // Initialize the selected list with false for each book
    _selected = List<bool>.filled(_books.length, false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Books'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        child: _books.isEmpty
            ? Center(
          child: Text('No books added yet.'),
        )
            : ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) {
            final book = _books[index];
            return ListTile(
              title: Text('${book.title}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Book No: ${book.bookNo}'),
                  Text('Authors: ${book.authors}'),
                  Text('Pages: ${book.pages}'),
                  Text('Cost: \$${book.cost}'),
                  Text('Publisher Year: ${book.publisherYear}'),
                  Text('Printed Year: ${book.printedYear}'),
                  Text('Purchased Year: ${book.purchasedYear}'),
                  Text('ISVN Code: ${book.isvnCode}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _selected[index],
                    onChanged: (newValue) {
                      setState(() {
                        _selected[index] = newValue!;
                      });
                    },
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
