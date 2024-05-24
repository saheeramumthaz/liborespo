import 'package:flutter/material.dart';

import 'package:infolibra/book_page.dart';
import 'package:infolibra/book_verification.dart';


import '../../teacherlist.dart';




class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.teal,
            title: Text('Admin Page'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            floating: true,
            snap: true,
            centerTitle: true,

            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                  // Handle logout action here
                  // For example:
                  Navigator.pop(context);

                },
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
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
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the AddBookPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  TeacherListPage()), // Replace AddBookPage with your actual page name
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(800, 50),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'TEACHERS',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Readex Pro',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the AddBookPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookPage()), // Replace AddBookPage with your actual page name
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(800, 50),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'BOOKS',
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
                            MaterialPageRoute(builder: (context) => BookListPage()), // Replace AddBookPage with your actual page name
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(800, 50),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'STOCK VERIFICATION',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Readex Pro',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          print('OUTAGE VERIFICATION button pressed ...');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(800, 50),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'OUTAGE VERIFICATION',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Readex Pro',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

