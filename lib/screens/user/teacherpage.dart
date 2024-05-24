import 'package:infolibra/screens/common/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:infolibra/screens/user/studentregistration.dart';

import '../../studentlist.dart';
import '../common/search_book.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  void clearUserProfile() {
    // Implement your logic here to clear the user's profile
    // This could involve clearing data stored locally or making API calls to clear data on the server
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            backgroundColor: Colors.teal,
            title: Text('Teacher Page'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Perform action based on value
                  if (value == 'logout') {
                    clearUserProfile();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    ); // Implement logout functionality
                  } else if (value == 'edit_profile') {
                    // Implement edit profile functionality
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'edit_profile',
                    child: Text('Edit Profile'),
                  ),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ],
              ),
            ],
            floating: true,
            pinned: true,
            snap: false,
            // You can adjust these values according to your design
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/img/upicture.png',
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentListPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Change the button color here
                      minimumSize: Size(800, 50),
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'STUDENTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Readex Pro',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookSearchPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Change the button color here
                      minimumSize: Size(800, 50),
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Search books',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Readex Pro',
                      ),
                    ),
                  ),
                ],
              ),
            ])),
          ),
        ],
      ),
    );
  }
}
