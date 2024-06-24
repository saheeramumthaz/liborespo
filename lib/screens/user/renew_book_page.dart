// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../models/issue_model.dart';
// import '../../services/issue_services.dart';
//
// class RenewBookPage extends StatefulWidget {
//   final BookIssue bookIssue;
//
//   RenewBookPage({required this.bookIssue});
//
//   @override
//   _RenewBookPageState createState() => _RenewBookPageState();
// }
// class _RenewBookPageState extends State<RenewBookPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _returnDateController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _returnDateController.text = widget.bookIssue.returnDate;
//   }
//
//   @override
//   void dispose() {
//     _returnDateController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Renew Book'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Book No: ${widget.bookIssue.bookNo}'),
//               Text('Title: ${widget.bookIssue.title}'),
//               Text('Author(s): ${widget.bookIssue.authors}'),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _returnDateController,
//                 decoration: InputDecoration(
//                   labelText: 'Return Date',
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter return date';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                   ),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       widget.bookIssue.returnDate = _returnDateController.text;
//                       bool success = await BookIssueService().updateBookIssue(widget.bookIssue);
//
//                       if (success) {
//                         Navigator.pop(context);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Error renewing book')),
//                         );
//                       }
//                     }
//                   },
//                   child: Text('Renew Book'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
