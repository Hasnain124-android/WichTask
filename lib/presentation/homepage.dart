import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wichtask/presentation/loginpage.dart';

class Homepage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Homepage();
}
class _Homepage extends State<Homepage>{
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  void logOut() async{
    setState(() {
      isLoading = true;
    });
    try{
      await auth.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginpage()));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      setState(() {
        isLoading = false;
      });
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Center(child: CircularProgressIndicator()) : Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child:ElevatedButton(
              onPressed: (){
                logOut();
              },
              child: Text("Logout")),
        ),
      ),
    );
  }

}