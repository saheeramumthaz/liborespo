import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infolibra/screens/common/form_validator.dart';
import 'package:infolibra/services/auth_services.dart';
import '../admin/adminpage.dart';
import '../user/studentpage.dart';
import '../user/teacherpage.dart';
import 'forgotpassword.dart';
import 'registerpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool visible = true;
  final _loginKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_loginKey.currentState!.validate()) {
      try {

        AuthService _authservice=AuthService();


        var snap=await _authservice.loginUser(_emailController.text , _passwordController.text);

        if(snap!=null){

          if(snap['role']=='student'){


            Navigator.pushNamedAndRemoveUntil(context, 'student', (route) => false);
          }

         else  if(snap['role']=='admin'){


            Navigator.pushNamedAndRemoveUntil(context, 'admin', (route) => false);
          } else  if(snap['role']=='teacher'){


            Navigator.pushNamedAndRemoveUntil(context, 'teacher', (route) => false);
          }
        }


      } catch (error) {
        print('Error during login: $error');
        setState(() {
          _errorMessage = 'Invalid email or password.';
        });
      }
    }
  }


  Future<String?> _getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData['role'];
      }
      return null;
    } catch (error) {
      print('Error getting user role: $error');
      return null;
    }
  }

  void _navigateToRoleHomePage(String role) {
    switch (role) {
      case 'admin':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
        break;
      case 'teacher':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherPage()),
        );
        break;
      case 'student':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentPage()),
        );
        break;
      default:
        setState(() {
          _errorMessage = 'Unknown user role.';
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _loginKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/user.png',
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is mandatory";
                        }
                        return null;
                      },
                      controller: _emailController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorStyle: TextStyle(color: Colors.orange),
                        hintStyle: themeData.textTheme.subtitle1,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.2,
                          ),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is mandatory";
                        }
                        if (value.length < 6) {
                          return "Password should be at least 6 characters";
                        }
                        return null;
                      },
                      obscureText: visible,
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: themeData.textTheme.subtitle1,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: visible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Center(
                      child: GestureDetector(
                        onTap: _login,
                        child: Container(
                          height: 55,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

