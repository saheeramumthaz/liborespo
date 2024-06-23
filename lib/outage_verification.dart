import 'package:flutter/material.dart';

class DamagedBookPage extends StatefulWidget {
  @override
  _DamagedBookPageState createState() => _DamagedBookPageState();
}

class _DamagedBookPageState extends State<DamagedBookPage> {
  TextEditingController _bookNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Report Damaged Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _bookNoController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                labelText: 'Enter Damaged Book No.',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String damagedBookNo = _bookNoController.text.trim();
                // Here you can perform any action with the damaged book number, such as sending it to a database or processing it further.
                print('Damaged Book No.: $damagedBookNo');
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
                'Report Damaged Book',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Readex Pro',
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bookNoController.dispose();
    super.dispose();
  }
}
