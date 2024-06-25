import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/services/firebase.dart';
import'package:test/components/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



 late SharedPreferences prefs;

 



void initState(){
//   SharedPreferences.getInstance().then((sharedPrefs) {

//       prefs = sharedPrefs;
//  var token = prefs.getString('token');
// if (token != null && token.isNotEmpty) {


// print('init state');
//   var token=prefs.getStringList('token');

//   if(token=='Authenticate'){
//      Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Dashboard()),
//             );

//   }

//  }



//  });


  // SharedPreferences prefs = await SharedPreferences.getInstance();



//getListString();



  super.initState();
 
}














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          



            Padding(
               padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Center(



                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: _emailController,
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
 controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
              SizedBox(
              height: 50,
            ),
            
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                 if(signin( _emailController.text, _passwordController.text,context)=='user authenticate'){

                  
    
 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
                 }
                },
                 style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Change this color to your desired background color
  ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}