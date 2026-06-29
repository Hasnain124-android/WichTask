import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wichtask/presentation/homepage.dart';

import 'loginpage.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
          () {
            checkUserSession();
      },
    );

  }

  void checkUserSession()async{
    if(auth.currentUser == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginpage()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF6710CA),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    MediaQuery.sizeOf(context).width * 0.1,
                  ),
                ),
                padding: EdgeInsets.all(
                  MediaQuery.sizeOf(context).width * 0.06,
                ),
                width: MediaQuery.of(context).size.width * 0.43,
                height: MediaQuery.of(context).size.width * 0.43,

                child: SvgPicture.asset(
                  'assets/icons/splash.svg',
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
              ),

              SizedBox(height: MediaQuery.sizeOf(context).width * 0.1),
              Text(
                "WICHTASK",
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width * 0.12,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: MediaQuery.sizeOf(context).width * 0.1),
              Text(
                "Plan Your Tasks",
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width * 0.05,
                  color: Colors.white,
                ),
              ),

              Text(
                "Achieve More",
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width * 0.05,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
