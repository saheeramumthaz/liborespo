import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infolibra/screens/user/teacherregistration.dart';
import 'package:infolibra/services/teacher_services.dart';
import '../../../models/teacher_model.dart';

class TeacherListPage extends StatefulWidget {
  @override
  _TeacherListPageState createState() => _TeacherListPageState();
}

class _TeacherListPageState extends State<TeacherListPage> {
  List<Teacher> _selectedTeachers = [];
  List<Teacher> _teachers = [];
  bool _isDeleteMode = false;

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  Future<void> _fetchTeachers() async {
    final teacherDocs = await FirebaseFirestore.instance.collection('teachers').get();
    final teachers = teacherDocs.docs.map((doc) {
      Teacher teacher = Teacher.fromJson(doc.data() as Map<String, dynamic>);
      teacher.uid = doc.id;
      return teacher;
    }).toList();
    setState(() {
      _teachers = teachers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Teachers'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: _teachers.length,
          itemBuilder: (context, index) {
            final teacher = _teachers[index];
            final isSelected = _selectedTeachers.contains(teacher);
            return ListTile(
              tileColor: Colors.green,
              title: Text(teacher.name ?? 'No Name'),
              subtitle: Text(teacher.email ?? 'No Email'),
              trailing: _isDeleteMode
                  ? Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedTeachers.add(teacher);
                    } else {
                      _selectedTeachers.remove(teacher);
                    }
                  });
                },
              )
                  : null,
              onTap: _isDeleteMode
                  ? () {
                setState(() {
                  if (isSelected) {
                    _selectedTeachers.remove(teacher);
                  } else {
                    _selectedTeachers.add(teacher);
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
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeacherRegisterPage()), // Replace with your AddTeacherPage
                );
                _fetchTeachers(); // Refresh the list after adding a teacher
              },
              backgroundColor: Colors.teal,
              child: Icon(Icons.add),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isDeleteMode = !_isDeleteMode;
                  if (!_isDeleteMode) {
                    _selectedTeachers.clear();
                  }
                });
              },
              backgroundColor: Colors.teal,
              child: Icon(Icons.delete),
            ),
            if (_isDeleteMode) ...[
              SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () async {
                  for (var teacher in _selectedTeachers) {
                    await TeacherService().deleteTeacher(teacher.uid!);
                  }
                  setState(() {
                    _selectedTeachers.clear();
                    _isDeleteMode = false;
                  });
                  _fetchTeachers(); // Refresh the list after deleting teachers
                },
                backgroundColor: Colors.red,
                child: Icon(Icons.check),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
