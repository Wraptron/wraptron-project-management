

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import'package:test/components/dashboard.dart';
import 'package:uuid/uuid.dart';


 void createUserInFirestore(String userId, String email, String password) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'password': password,
        // Add any other user-related data as needed
      });
      print('User created successfully!');
    } catch (e) {
      print('Error creating user: $e');
    }
  }



  Future<List<DocumentSnapshot>> issues_list() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('issues')
         
          .get();
      
      // Return the list of documents
      return userSnapshot.docs;
      
    } catch (e) {
      print('Error signing in: $e');
      // Return an empty list if there's an error
      return [];
    }
  }





  
  Future<List<DocumentSnapshot>> list_project() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('project')
         
          .get();
      
      // Return the list of documents
      return userSnapshot.docs;
      
    } catch (e) {
      print('Error signing in: $e');
      // Return an empty list if there's an error
      return [];
    }
  }






uploadfile(title,descripation,context,image,status) async{
//   print('fff');
//   print(_image);

//   try{

//       File file = File(_image);

//     // Check if the file exists
//     if (!file.existsSync()) {
//       print('Error: File does not exist at path:');
//       return;
//     }
//      print('fffs');
// var firebaseStorageRef = FirebaseStorage.instance.ref().child('/image1/${DateTime.now()}.png');
//    //   var uploadTask = firebaseStorageRef.putFile(_image);
//      // var snapshot = await uploadTask.whenComplete(() {});
//        UploadTask uploadtask= firebaseStorageRef.putFile(file);
//        print('File uploaded successfully.');
// TaskSnapshot snapshot=await uploadtask;
 
//     // Get the download URL of the uploaded file
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//        //String downloadUrl = await firebaseStorageRef.getDownloadURL();
//        print('File uploaded successfully. Download URL: $downloadUrl');
//        issues(downloadUrl, issue);
//        return downloadUrl;
//   }
//   catch(e){
//   print('Error signing in: $e');
//   }
 String userId = Uuid().v4();
try {
     
      print('User created successfully!');
      uploadImageToFirebase(image,userId,context,title,descripation,status);

   

            //  issues_list();
    } catch (e) {
      print('Error creating user: $e');


      
    }









  
}

// Future<String?> getImageDownloadURL(String filename) async {

//   try {
//     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('image1').doc('9056edc1-75d0-408f-a5d8-1a4198bbdd3e.jpg').get();
//     if (documentSnapshot.exists) {
//       print('${filename}.jpg');
//       return documentSnapshot['downloadURL'];
//     } else {
//       print('Document does not exist.');
//       return null;
//     }
//   } catch (e) {
//     print('Error retrieving image metadata: $e');
//     return null;
//   }
// }


// Future<List<String>> fetchImages() async {

//   print('image all');
//   FirebaseStorage storage = FirebaseStorage.instance.ref().child('image1/${imageName.toString()}.jpg');;
//   List<String> imageUrls = [];

//   // Reference to the Firebase Storage bucket directory where your images are stored
 

//   // List all items in the directory
//   ListResult result = await ref.listAll();
// print(result);
//   // Iterate through the items and get download URLs for images
//   result.items.forEach((Reference itemRef) async {
//     String imageUrl = await itemRef.getDownloadURL();
//     imageUrls.add(imageUrl);
//   });
// print(imageUrls);
//   return imageUrls;
// }
Future<String?> uploadImageToFirebase(File imageFile,imageName,context,title,descripation,status) async {
  try {

    print('download save');
    // Create a reference to the location you want to upload to in Firebase Storage
    Reference storageReference = FirebaseStorage.instance.ref().child('image1/${imageName.toString()}.jpg');
    
    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(imageFile);
    
    // Wait for the upload to complete and return the download URL
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadURL = await taskSnapshot.ref.getDownloadURL();



     await FirebaseFirestore.instance.collection('issues').doc(imageName).set({
        'issue_title': title,
        'issues_descripation': descripation,
         'user_id': imageName,
         'image':downloadURL,
         'status':status
        // Add any other user-related data as needed
      });
issues_list();
       ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('issues created successfully!'),
                  duration: Duration(seconds: 2), // Adjust as needed
                ),
              );

    print(downloadURL);
    
    return downloadURL;
  } catch (e) {
    print('error1${e.toString()}');
    return null;
  }
}



issues(title,descripation,status,context) async{

try{
  String userId = Uuid().v4();
  print('rrrrr');
   await FirebaseFirestore.instance.collection('issues').doc(userId).set({
        'issue_title': title,
        'issues_descripation': descripation,
         'user_id': userId,
           'status': status
        
      });
      issues_list();
        ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('issues created successfully!'),
                  duration: Duration(seconds: 2), // Adjust as needed
                ),
              );

}
catch(e){
  print('Error signing as: $e');
}
}


  signin(String email, String password,context) async{
 try {
 final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password) 
        .limit(1)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token','Authenticate');

    print(prefs.getString('token'));
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
 return 'user authenticate';

    }
    else{
return 'invalid user';
    }


 }
 catch (e) {
    print('Error signing in: $e');
  }

  }