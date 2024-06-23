import 'package:flutter/material.dart';
import '../../models/issue_model.dart';
import '../../services/issue_services.dart';


class ReturnBookPage extends StatefulWidget {
  final BookIssue bookIssue;

  ReturnBookPage({required this.bookIssue});

  @override
  _ReturnBookPageState createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _returnDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _returnDateController.text = widget.bookIssue.returnDate;
  }

  @override
  void dispose() {
    _returnDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Book'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Book No: ${widget.bookIssue.bookNo}'),
              Text('Title: ${widget.bookIssue.title}'),
              Text('Author(s): ${widget.bookIssue.authors}'),
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
                readOnly: true,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // text color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () async {
                    bool success = await BookIssueService().deleteBookIssue(widget.bookIssue.bid!);

                    if (success) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error returning book')),
                      );
                    }
                  },
                  child: Text('Return Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
