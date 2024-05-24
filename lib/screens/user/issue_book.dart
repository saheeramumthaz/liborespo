import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IssueBooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Issue Books', // Set the title here
            style: TextStyle(
              color: Colors.white, // Set text color to white
              fontSize: 20, // Set font size to 20
              fontWeight: FontWeight.bold, // Set font weight to bold
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal, // Optional: Customize app bar color
        ),
        body: Container(
          color: Colors.teal,
          child: IssueBooksForm(),
        ),
      ),
    );
  }
}

class IssueBooksForm extends StatefulWidget {
  @override
  _IssueBooksFormState createState() => _IssueBooksFormState();
}

class _IssueBooksFormState extends State<IssueBooksForm> {
  final _formKey = GlobalKey<FormState>();
  final _bookNoController = TextEditingController();
  final _titleController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _issuedDateController = TextEditingController();
  final _returnDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFormField('Book No:', _bookNoController),
            _buildFormField('Title:', _titleController),
            _buildFormField('Name:', _nameController),
            _buildFormField('Phone Number:', _phoneNumberController),
            _buildDateField('Issued Date:', _issuedDateController),
            _buildDateField('Return Date:', _returnDateController, readOnly: true),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Book issued successfully')),
                    );
                  }
                },
                child: Text('Issue Book'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String labelText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              labelText,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey[800],
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

  Widget _buildDateField(String labelText, TextEditingController controller, {bool readOnly = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              labelText,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey[800],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                  if (labelText == 'Issued Date:') {
                    _calculateReturnDate(selectedDate);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _calculateReturnDate(DateTime issuedDate) {
    DateTime returnDate = issuedDate.add(Duration(days: 30)); // Add one month
    _returnDateController.text = DateFormat('yyyy-MM-dd').format(returnDate);
  }
}

