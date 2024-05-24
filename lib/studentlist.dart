import 'package:flutter/material.dart';
import 'package:infolibra/screens/user/studentregistration.dart';
import 'package:infolibra/services/student_services.dart';
import '../models/student_model.dart';


class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    // Fetch all students from the service
    _students = await StudentService().getStudents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: _students.length,
          itemBuilder: (context, index) {
            final student = _students[index];
            return ListTile(
              title: Text(student.name ?? 'No Name'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${student.email ?? 'N/A'}'),
                  Text('Course: ${student.course ?? 'N/A'}'),
                  Text('Academic Year: ${student.academicYear ?? 'N/A'}'),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                // Navigate to the student registration page
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentRegistrationForm()),
                );
                _fetchStudents(); // Refresh the list after adding a student
              },
              backgroundColor: Colors.teal,
              child: Icon(Icons.add),
            ),
            SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () async {
                // Implement deleting functionality here
                // You can prompt user for confirmation before deleting
                // For example: showDialog(...);
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

