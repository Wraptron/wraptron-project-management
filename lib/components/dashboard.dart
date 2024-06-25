import 'package:flutter/material.dart';
import 'package:test/components/create_issue.dart';

import 'package:test/components/issues.dart';
import 'package:test/components/login.dart';
import 'package:test/components/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

var selectedIndex = 0;  
var type=1;
class Dashboard extends StatefulWidget {
  @override
 _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {




    
    List<Widget> _widgetOptions = <Widget>[  
   Issues(),  

   StepperPage(type:2),
    //Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
   // Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  

   ProfileDetailScreen()
  ];  
  

void initState(){
  super.initState();
  print('dashbaord');
}



  void _onItemTapped(int index) {  
    setState(() {  
      selectedIndex = index;  
    });  
  }  

static Future logout(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var session_expired = await preferences.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginDemo()));
  }


List title=['Issues','Project','Profile'];
Widget build(BuildContext context) {  
    return Scaffold(  
      // appBar: AppBar(  
      //   title:  Text(title[selectedIndex], style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),),  
      //     backgroundColor: Color(0xFFE7A92D),
      //      automaticallyImplyLeading: false,
      // ),  

appBar:

 AppBar(
        title: Text(title[selectedIndex],style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
        
        
        
        
        ),
          backgroundColor: Color(0xFFE7A92D),
          automaticallyImplyLeading: false,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Handle the menu selection
              switch (result) {
                case 'logout':
                logout(context);
                  break;
                // case 'Option 2':
                //   print('Option 2 selected');
                //   break;
                // case 'Option 3':
                //   print('Option 3 selected');
                //   break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
              
            ],
          ),
        ],
      ),










      body: Center(  
        child: _widgetOptions.elementAt(selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: 'Issues',  
            
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.search),  
            label: 'Project',  
            backgroundColor: Colors.yellow  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            label:'Profile',  
            
          ),  
        ],  
         
        currentIndex: selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),  
       floatingActionButton: FloatingActionButton(
        onPressed: () {


          setState(() {
            type=1;
          });
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StepperPage(type:1)),
            );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    
    );  
}}
