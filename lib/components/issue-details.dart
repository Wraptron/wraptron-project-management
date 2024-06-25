import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:math';


class EmployeeDetailScreen extends StatefulWidget {
  // final String customer_id;

  final name;
  final descripation;
  final status;
  

  EmployeeDetailScreen({
    Key? key,
    @required this.name,
     @required this.descripation,
      @required this.status,
    
  }) : super(key: key);

  // ProfileScreen({required this.customer_id});
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeeDetailScreen> {
 
  var status;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    List header_title = [
     
    ];
    List subTitle = [
      
      
    ];

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


    if(widget.status=='1'){
status='Low';

    }
    else if(widget.status=='2'){
status='High';
    }
    else{
      status='Non Of These';
    }

    return Scaffold(
          appBar: AppBar(  
        title: const Text('Issues Details', style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),),  
          backgroundColor: Color(0xFFE7A92D)
      ),  
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
             
             
            
              Padding(
                  padding: new EdgeInsets.only(
                      left: _width / 20, right: _width / 20),
                  child: Column(children: [
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text('Issues Name:',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          widget.name,
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
                        title: Text('Descripation',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          widget.descripation,
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
                        title: Text('Status',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          status,
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
                   
                   
                  
                  
                   
                   
                  ])),
            
            
             
              
            ],
          ),
        ));

  
  }

  Widget headerChild(String header, int value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),

          new GestureDetector(
              onTap: () {
               
              },
              child: Icon(
                Icons.download,
                color: Colors.black,
                size: 25.0,
              )),

          // new Text(
          //   '$value',
          //   style: new TextStyle(
          //       fontSize: 14.0,
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold),
          // )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color: Colors.black,
                size: 36.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}

