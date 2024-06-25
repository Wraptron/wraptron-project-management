import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/components/issue-details.dart';
import 'package:test/services/firebase.dart';



class Issues extends StatefulWidget {
  @override
  _IssuesState createState() =>  _IssuesState();
}



class _IssuesState extends State< Issues> {
  String search='';



  
void initState(){
  super.initState();
 
}
  @override
  Widget build(BuildContext context) {
    final title = 'SimpleContactList';
TextEditingController searchController = TextEditingController();
    return Column(children: [
      SizedBox(height: 30),

SizedBox(
            height: 45,
            width: 360,
            child: TextField(
           
               onChanged: (value) {
    // Call setState to update the UI with the filtered results
    setState(() {
search=value;

    });
  },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff1f1f1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search Issues",
              
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.black,
              ),
            ),
          ),

           SizedBox(height: 20),

FutureBuilder(
          future: issues_list(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Extract emails from document snapshots
              List data_object = [];
               List filteredUsers = [];


              if(search!=''){
                print('search-field');
  filteredUsers =  snapshot.data!.where((user) {
      return user['issue_title'].toString().toLowerCase().startsWith(search.toLowerCase());
    }).toList();
    filteredUsers.forEach((doc) {
     
                data_object.add({'title':doc['issue_title'],'descripation':doc['issues_descripation'],'status':doc['status']}); 
              });

              }
              else{
              snapshot.data!.forEach((doc) {


                print('document list');
             
                data_object.add({'title':doc['issue_title'],'descripation':doc['issues_descripation'],'status':doc['status']}); 
              });
              }

              return Expanded(child:Container(
  height: MediaQuery.of(context).size.height, // Set the height to fill the available space
  child: 
              
               ListView.builder(
                itemCount: data_object.length,
                itemBuilder: (context, index) {
                  var issue_status;
                  String descripation=data_object[index]['descripation'];
                  String status=data_object[index]['status'];


                  if(status=='1'){
issue_status='Low';
                  }

                  else if(status=='2'){
issue_status='High';
                  }


                   String query = searchController.text.toLowerCase();
                   print(query);
                    
                       return 
                     
                       
                       Column(
          children: <Widget>[
            ListTile(
              leading:
              
               CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:AssetImage('assets/logo.png')
                
            //    NetworkImage(
            //   'https://firebasestorage.googleapis.com/v0/b/wraptron-auth.appspot.com/o/image1%2F7141386d-5c30-4f6a-80dc-eba70115dc07.jpg?alt=media&token=9d2bd598-2e03-4f80-bbe9-7209ecf1ae0c',
            // ),
              ),
              title: Text(
                data_object[index]['title'],
              ),
              subtitle: Text(descripation) ,
              trailing:

              Column(children: [

if(issue_status!=null)...[

                 Text(issue_status,  style: TextStyle(color: Colors.green,fontSize: 13),
                 
                 
                 )],

                  GestureDetector(
                        onTap: (){
                          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                             
                       EmployeeDetailScreen(name: data_object[index]['title'],descripation: descripation,status:data_object[index]['status'])));

                        },
                        
                        child:
              
              
              
               Icon(Icons.keyboard_arrow_right)),
              
              
              
              ],),
              
            
              onTap: () {
                Text('Another data');
              },
            ),
            new Divider(
              height: 1.0,
              indent: 1.0,
            )
          ]);

                     
                  
                  
                  //  ListTile(
                  //   title: Text(emails[index]),
                  // );
                },
              )));
            }
          },
        )
    
    ],);
    
    
    
    
    
    
   
  }
     
}