import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/teacher_model.dart';
import '../../services/teacher_services.dart';

class TeacherRegisterPage extends StatefulWidget {
  const TeacherRegisterPage({Key? key}) : super(key: key);

  @override
  _TeacherRegisterPageState createState() => _TeacherRegisterPageState();
}

class _TeacherRegisterPageState extends State<TeacherRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool success = true;

  bool _visible = true;
  String Role = 'teacher';

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'admin');
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Image.asset(
                    'assets/img/user.png',
                    alignment: Alignment.center,
                  ),
                  Text(
                    "Let's register",
                    style: themeData.textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is mandatory";
                      }
                      return null;
                    },
                    controller: _nameController,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      prefixIcon: Icon(Icons.person),

                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is mandatory";
                      }
                      return null;
                    },
                    controller: _emailController,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),

                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _visible,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is mandatory";
                      }
                      if (value.length < 6) {
                        return "Password should be at least 6 characters";
                      }
                      return null;
                    },
                    controller: _passwordController,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(


                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                        icon: Icon(
                          _visible ? Icons.visibility : Icons.visibility_off,

                        ),
                      ),

                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number is mandatory";
                      }
                      return null;
                    },
                    controller: _phoneController,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefixIcon: Icon(Icons.phone),

                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

                  SizedBox(height: 20),
                  // DropdownButtonFormField<String>(
                  //   value: _selectedRole,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedRole = value!;
                  //     });
                  //   },
                  //   items: ['teacher', 'student']
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   decoration: InputDecoration(
                  //     hintText: "Select Role",
                  //     prefixIcon: Icon(Icons.person),
                  //   ),
                  // ),

//     Center(
//     child: ElevatedButton(
//     onPressed: () {
//     if (_formKey.currentState!.validate()) {
//
//         TeacherService teacherService = TeacherService();
//         final res = await teacherService.registerTeacher(teacher);
//         if (res) {
//         Navigator.pop(context);
//         } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//         content: Text('Registration failed. Please try again.'),
//         backgroundColor: Colors.red,
//         ),
//         );
//         }
//         }
//         } catch (e) {
//         print('Error registering teacher: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//         content: Text('An unexpected error occurred. Please try again.'),
//         backgroundColor: Colors.red,
//         ),
//         );
//         },
//         }
//
//             SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _registerTeacher,
//                       child: Text("Register"),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Teacher teacher = Teacher(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _nameController.text,
                            phone: _phoneController.text,
                            role: "teacher",
                            status: 3, // Teacher status
                            createdAt: DateTime.now(),
                          );

                          // Call the registerStudent method to save the student data to the database
                          TeacherService()
                              .registerTeacher(teacher)
                              .then((success) {
                            if (success == true) {
                              // If registration is successful, navigate back to the previous page
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                      child: Container(
                        height: 55,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
