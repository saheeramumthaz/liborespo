import 'package:flutter/material.dart';

import '../../models/book_model.dart';


class UpdateBookPage extends StatefulWidget {
  final Book book;

  UpdateBookPage({required this.book});

  @override
  _UpdateBookPageState createState() => _UpdateBookPageState();
}

class _UpdateBookPageState extends State<UpdateBookPage> {
  late TextEditingController _titleController;
  late TextEditingController _authorsController;
  late TextEditingController _pagesController;
  late TextEditingController _costController;
  late TextEditingController _publisherYearController;
  late TextEditingController _printedYearController;
  late TextEditingController _purchasedYearController;
  late TextEditingController _isvnCodeController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorsController = TextEditingController(text: widget.book.authors);
    _pagesController = TextEditingController(text: widget.book.pages.toString());
    _costController = TextEditingController(text: widget.book.cost.toString());
    _publisherYearController = TextEditingController(text: widget.book.publisherYear.toString());
    _printedYearController = TextEditingController(text: widget.book.printedYear.toString());
    _purchasedYearController = TextEditingController(text: widget.book.purchasedYear.toString());
    _isvnCodeController = TextEditingController(text: widget.book.isvnCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormField('Title:', _titleController),
            _buildFormField('Authors:', _authorsController),
            _buildFormField('No of Pages:', _pagesController, keyboardType: TextInputType.number),
            _buildFormField('Cost:', _costController, keyboardType: TextInputType.number),
            _buildFormField('Publisher Year:', _publisherYearController, keyboardType: TextInputType.number),
            _buildFormField('Printed Year:', _printedYearController, keyboardType: TextInputType.number),
            _buildFormField('Purchased Year:', _purchasedYearController, keyboardType: TextInputType.number),
            _buildFormField('ISVN Code:', _isvnCodeController),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Update book details
                  final updatedBook = Book(
                    bookNo: widget.book.bookNo,
                    title: _titleController.text,
                    authors: _authorsController.text,
                    pages: int.parse(_pagesController.text),
                    cost: double.parse(_costController.text),
                    publisherYear: int.parse(_publisherYearController.text),
                    printedYear: int.parse(_printedYearController.text),
                    purchasedYear: int.parse(_purchasedYearController.text),
                    isvnCode: _isvnCodeController.text,
                  );
                  // TODO: Implement update logic here
                  // For demonstration, I'm just printing the updated details
                  print('Updated Book Details: ${updatedBook.title}, ${updatedBook.authors}, ${updatedBook.pages}, ${updatedBook.cost}, ${updatedBook.publisherYear}, ${updatedBook.printedYear}, ${updatedBook.purchasedYear}, ${updatedBook.isvnCode}');
                  // Navigate back after updating
                  Navigator.pop(context);
                },
                child: Text('Update Book'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String labelText, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(labelText),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}