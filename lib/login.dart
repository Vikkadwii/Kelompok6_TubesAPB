import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'registerScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'pages/percentagePage.dart';
import 'pages/profilePage.dart';
import 'pages/moodPage2.dart';
import 'pages/homePage.dart';
import 'navigasi.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void saveLoginToFirebase(String email, String password) async {
    try {
      await firestore.collection("login").add({
        'email': email,
        'password': password,
      });
      print('Login data saved to Firestore');
    } catch (e) {
      print('Failed to save login data: $e');
    }
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final _secureStorage = FlutterSecureStorage();
    User? user;
    try {
      await _secureStorage.write(key: 'email', value: email);
      await _secureStorage.write(key: 'password', value: password);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Found For That Email");
      }
    }

    return user;
  }

  bool hide = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // Mengambil email dari secure storage dan mengesetnya pada _emailController
    _secureStorage.read(key: 'email').then((value) {
      if (value != null) {
        _emailController.text = value;
      }
    });

    // Mengambil password dari secure storage dan mengesetnya pada _passwordController
    _secureStorage.read(key: 'password').then((value) {
      if (value != null) {
        _passwordController.text = value;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 134, 134),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 400),
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 223, 168, 168),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.only(top: 200, left: 50, right: 50),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0.1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: hide,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        icon: hide
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forget?"),
                    ),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 244, 134, 134),
                      padding: EdgeInsets.symmetric(horizontal: 100),
                    ),
                    onPressed: () async {
                      User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      print(user);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationScreen(),
                          ),
                        );
                      }
                      saveLoginToFirebase(
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text("Register?"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 80,
              left: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    "Login access to your account",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  var email;
  Home({this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Home Screen"),
      ),
    );
  }
}
