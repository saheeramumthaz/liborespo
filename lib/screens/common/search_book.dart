// book_search_page.dart

import 'package:flutter/material.dart';
import '../../book_detail_page.dart';
import '../../models/book_model.dart'; // Ensure this path is correct
import '../../services/book_services.dart'; // Ensure this path is correct


class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Book> _allBooks = [];
  List<Book> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
    _searchController.addListener(() {
      _performSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchBooks() async {
    try {
      final books = await BookService().getAllBooks();
      setState(() {
        _allBooks = books;
        _searchResults = books; // Initially show all books
      });
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = _allBooks;
      });
    } else {
      setState(() {
        _searchResults = _allBooks.where((book) {
          final titleLower = book.title?.toLowerCase() ?? ''; // Null check and lowercase conversion
          final authorLower = book.authors?.toLowerCase() ?? ''; // Null check and lowercase conversion
          final searchLower = query.toLowerCase();
          return titleLower.contains(searchLower) || authorLower.contains(searchLower);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.teal,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/img/searchbook.png', // Path to your book image
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Books',
                hintText: 'Enter book title or author',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.white, // Set border color
                    width: 1.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          _searchResults.isEmpty
              ? Expanded(
            child: Center(
              child: Text(
                'No results found',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final book = _searchResults[index];
                return ListTile(
                  title: Text(book.title ?? 'Unknown Title'), // Handle potential null value
                  subtitle: Text(book.authors ?? 'Unknown Author'), // Handle potential null value
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

