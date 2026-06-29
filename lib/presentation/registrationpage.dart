import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wichtask/presentation/loginpage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passCode = TextEditingController();
  final TextEditingController rePassCode = TextEditingController();
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isNotVisible = true;

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    passCode.dispose();
    rePassCode.dispose();
    super.dispose();
  }

  void createAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await auth.createUserWithEmailAndPassword(
          email: email.text,
          password: passCode.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
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
                      "Create Account",
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width * 0.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Register To Get Started",
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width * 0.05,
                        color: Colors.grey[500],
                      ),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.1),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.sizeOf(context).width * 0.04,
                            ),
                          ),
                          TextFormField(
                            controller: fullName,
                            decoration: InputDecoration(
                              hintText: "Enter Your Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.04,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please name";
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.1,
                          ),

                          Text(
                            "Email",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.sizeOf(context).width * 0.04,
                            ),
                          ),
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.04,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Email";
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.1,
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
                              hintText: "Create Password",
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
                                return "Please enter Password";
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.1,
                          ),

                          Text(
                            "Confirm Password",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.sizeOf(context).width * 0.04,
                            ),
                          ),
                          TextFormField(
                            obscureText: isNotVisible,
                            controller: rePassCode,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
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
                              if (value == null ||
                                  value.isEmpty ||
                                  value != passCode.text) {
                                rePassCode.clear();
                                return "Password Does Not Match";
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.1,
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
                                createAccount();
                              },
                              child: Text(
                                "Sign Up",
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
                                  TextSpan(text: "Already Have An Account? "),
                                  TextSpan(
                                    text: " LogIn",
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
                                            builder: (context) => Loginpage(),
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
