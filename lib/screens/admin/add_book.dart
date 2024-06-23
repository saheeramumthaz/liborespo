import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../book_page.dart';
import '../../models/book_model.dart';
import '../../services/book_services.dart';

class BookAddingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Books',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.teal,
        child: BookAddingForm(),
      ),
    );
  }
}

class BookAddingForm extends StatefulWidget {
  @override
  _BookAddingFormState createState() => _BookAddingFormState();
}

class _BookAddingFormState extends State<BookAddingForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorsController = TextEditingController();
  final _pagesController = TextEditingController();
  final _costController = TextEditingController();
  final _publisherYearController = TextEditingController();
  final _printedYearController = TextEditingController();
  final _purchasedYearController = TextEditingController();
  final _isvnCodeController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFormField('Title:', _titleController),
            _buildFormField('Authors:', _authorsController),
            _buildFormField('No of Pages:', _pagesController,
                keyboardType: TextInputType.number),
            _buildFormField('Cost:', _costController,
                keyboardType: TextInputType.number),
            _buildFormField('Publisher Year:', _publisherYearController,
                keyboardType: TextInputType.number),
            _buildFormField('Printed Year:', _printedYearController,
                keyboardType: TextInputType.number),
            _buildFormField('Purchased Year:', _purchasedYearController,
                keyboardType: TextInputType.number),
            _buildFormField('ISBN Code:', _isvnCodeController),

            _buildFormField("Quantity", quantityController,keyboardType: TextInputType.number),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Generate a unique book number using UUID
                    String bookNo = Uuid().v4();

                    // Check if the book already exists
                    bool bookExists = await BookService().bookExists(bookNo, _isvnCodeController.text);
                    if (bookExists) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Book with this number or ISVN code already exists'),
                      ));
                      return;
                    }

                    final book = Book(
                      isAvailable: true,
                      bid: bookNo,
                      bookNo: bookNo,
                      title: _titleController.text,
                      authors: _authorsController.text,
                      pages: int.tryParse(_pagesController.text) ?? 0,
                      cost: double.tryParse(_costController.text) ?? 0.0,
                      publisherYear: int.tryParse(_publisherYearController.text) ?? 0,
                      printedYear: int.tryParse(_printedYearController.text) ?? 0,
                      purchasedYear: int.tryParse(_purchasedYearController.text) ?? 0,
                      isvnCode: _isvnCodeController.text,
                    );

                    await BookService().addBook(book);

                    // Navigate to the book list page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BookPage()),
                    );
                  }
                },
                child: Text('Add Book'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String labelText, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              labelText,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter $labelText';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
