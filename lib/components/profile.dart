

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/components/issue-details.dart';
import 'package:test/services/firebase.dart';

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:uuid/uuid.dart';

class ProfileDetailScreen extends StatefulWidget {
  // final String customer_id;

  

  ProfileDetailScreen({
    Key? key,
   
  }) : super(key: key);

  // ProfileScreen({required this.customer_id});
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<ProfileDetailScreen> {
   List<String> _dropdownItems = [];
  
  @override
  void initState() {
    super.initState();
    _fetchDropdownItems();
  }


   Future<void> _fetchDropdownItems() async {
    final userSnapshot = await FirebaseFirestore.instance.collection('project').get();
    setState(() {
      _dropdownItems = userSnapshot.docs.map((doc){
      
      print(doc['project_name'].toString());
      return doc['project_name'].toString();
       
    }).toList();
    });
  }
  AppBar _actionBar() => AppBar(
        backgroundColor: Color(0xFF336699),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Profile',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle menu item selection
              
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'option_1',
                child: Text('Logout'),
              ),
              // PopupMenuItem<String>(
              //   value: 'option_2',
              //   child: Text('Option 2'),
              // ),
              // PopupMenuItem<String>(
              //   value: 'option_3',
              //   child: Text('Option 3'),
              // ),
            ],
          ),
        ],
      );

  

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    List header_title = [
      'Joining Date:',
      'DoB:',
      'Mobile:',
      'Age:',
      'Gender:',
      'Nationality:',
      'Address:',
      'City:',
      'State:',
      'Zip code:',
      'Finger Print:'
    ];
    List subTitle = [
     
    ];
 //String _value = 'Select Project';
    Widget detailsScreen() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Existing ListView.separated
          ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: header_title.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 25.0),
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(header_title[index],
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 1.0),
                    Text(
                      subTitle[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 1.0),
                  ],
                ),
              );
            },
          ),
        ],
      );
    }

    return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
            radius: 80,
            child: ClipOval(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images.png',
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 160,
                        height: 160,
                        color: Colors.grey[200], // Background color in case of error
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 80,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 100,
                    right: 20,
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
              SizedBox(height: 10),
              Text(
                'WRAP003',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Test Customer',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Company Details',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),

 


             Padding(
      padding: const EdgeInsets.all(35.0),
      child: DropdownButtonFormField<String>(
       // value: _value,
         items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
      
      
        // items: <DropdownMenuItem<String>>[
        //   DropdownMenuItem(
        //     child: Text('Select Project'),
        //     value: 'Select Project',
        //   ),
        //   DropdownMenuItem(
        //     child: Text('Web Application'),
        //     value: 'Web Application',
        //   ),
        //   DropdownMenuItem(
        //     child: Text('Mobile Development'),
        //     value: 'Mobile Development',
        //   ),
        // ],
        onChanged: (value) {
        //  setState(() => _value = value!);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Adjust vertical and horizontal padding here
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    ),
             
              Padding(
                  padding: new EdgeInsets.only(
                      left: _width / 20, right: _width / 20),
                  child: Column(children: [
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text('Company Name:',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          'Test Customer',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      // Add a divider here
                      color: Colors.black, // Customize divider color
                      thickness: 1, // Customize divider thickness
                      height: 10, // Customize divider height
                    ),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text('Company Address',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '34 kumaran nager first floor chennai',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),

     Divider(
                      // Add a divider here
                      color: Colors.black, // Customize divider color
                      thickness: 1, // Customize divider thickness
                      height: 10, // Customize divider height
                    ),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text('Pincode',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '5362001',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),







                    Divider(
                      // Add a divider here
                      color: Colors.black, // Customize divider color
                      thickness: 1, // Customize divider thickness
                      height: 10, // Customize divider height
                    ),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text('Mobile',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '+91 1234567890',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      // Add a divider here
                      color: Colors.black, // Customize divider color
                      thickness: 1, // Customize divider thickness
                      height: 10, // Customize divider height
                    ),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text('Email',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          'test@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                   
                  
                   SizedBox(height: 20),
                  
                  
                   
                  ])),
            
            ],
          ),
        );

    
  }

}