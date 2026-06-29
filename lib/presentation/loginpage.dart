import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wichtask/presentation/registrationpage.dart';

import 'forgetpasswordpage.dart';
import 'homepage.dart';

class Loginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController logIn = TextEditingController();
  final TextEditingController passCode = TextEditingController();
  bool isNotVisible = true;
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    logIn.dispose();
    passCode.dispose();
    super.dispose();
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await auth.signInWithEmailAndPassword(
          email: logIn.text,
          password: passCode.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).width * 0.09,
                left: MediaQuery.sizeOf(context).width * 0.05,
                right: MediaQuery.sizeOf(context).width * 0.05,
              ),
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width * 0.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Log In to continue",
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width * 0.05,
                        color: Colors.grey[500],
                      ),
                    ),

                    Image.asset(
                      'assets/images/login.png',
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).width * 0.8,
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.03),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.sizeOf(context).width * 0.04,
                            ),
                          ),
                          TextFormField(
                            controller: logIn,
                            decoration: InputDecoration(
                              hintText: "Enter Your Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.04,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.06,
                          ),

                          Text(
                            "Password",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.sizeOf(context).width * 0.04,
                            ),
                          ),
                          TextFormField(
                            obscureText: isNotVisible,
                            controller: passCode,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.04,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isNotVisible = !isNotVisible;
                                  });
                                },
                                icon: Icon(
                                  color: Theme.of(context).colorScheme.primary,
                                  isNotVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password Required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.02,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Forgetpasswordpage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.05,
                          ),

                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).width * 0.15,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    MediaQuery.sizeOf(context).width * 0.04,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                login();
                              },
                              child: Text(
                                "LogIn",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.sizeOf(context).width * 0.04,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.05,
                          ),

                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "Don't Have An Account? "),
                                  TextSpan(
                                    text: " Register",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width *
                                          0.04,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationPage(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
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
