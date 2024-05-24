
import 'package:flutter/material.dart';

class Book {
  String? bid;
  final String bookNo;
  final String title;
  final String authors;
  final int pages;
  final double cost;
  final int publisherYear;
  final int printedYear;
  final int purchasedYear;
  final String isvnCode;

  Book({
    this.bid,
    required this.bookNo,
    required this.title,
    required this.authors,
    required this.pages,
    required this.cost,
    required this.publisherYear,
    required this.printedYear,
    required this.purchasedYear,
    required this.isvnCode,
  });
}

class BookDetailsPage extends StatelessWidget {
  final Book book;

  BookDetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bid: ${book.bid}'),
            Text('Book No: ${book.bookNo}'),
            Text('Title: ${book.title}'),
            Text('Authors: ${book.authors}'),
            Text('Pages: ${book.pages}'),
            Text('Cost: \$${book.cost}'),
            Text('Publisher Year: ${book.publisherYear}'),
            Text('Printed Year: ${book.printedYear}'),
            Text('Purchased Year: ${book.purchasedYear}'),
            Text('ISVN Code: ${book.isvnCode}'),
          ],
        ),
      ),
    );
  }
}
