import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wichtask/presentation/loginpage.dart';

class Forgetpasswordpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Forgetpasswordpage();
}

class _Forgetpasswordpage extends State<Forgetpasswordpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  void resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await auth.sendPasswordResetEmail(email: email.text);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Reset Link Has Been Sent! Check Your Mail")));
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
                top: MediaQuery.sizeOf(context).width * 0.14,
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
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Enter Your Password And We'll Send You A Reset Link",
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width * 0.05,
                        color: Colors.grey[500],
                      ),
                    ),

                    Image.asset(
                      'assets/images/forgetpassword.png',
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).width * 0.8,
                    ),

                    //SizedBox(height: MediaQuery.sizeOf(context).width * 0.01),

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
                            controller: email,
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
                                resetPassword();
                              },
                              child: Text(
                                "Send Reset Link",
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
                                style: TextStyle(color: Colors.black, fontSize:
                                MediaQuery.sizeOf(context).width *
                                    0.04,),
                                children: [
                                  TextSpan(text: "Back To"),
                                  TextSpan(
                                    text: " Login",
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
                                                Loginpage(),
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
