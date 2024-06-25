import "package:flutter/material.dart";
import 'dart:io';
import 'package:test/services/firebase.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import'package:test/components/dashboard.dart';

//import 'package:flutter_widgets/const/_const.dart';
List<IssuesInfo> issuesdetails = [];


String test='ggggg';

class StepperPage extends StatefulWidget {
final type;



StepperPage({
    Key? key,
    @required this.type,
  
    
  }) : super(key: key);

  @override
  _StepperState createState() => _StepperState();
}

class _StepperState extends State<StepperPage> {
  var _index = 0;
  final _formKey = GlobalKey();
  final List <IssuesInfo> _friendsList = [];

  
XFile? Issuesimage;
List all_obj=[];
  
   final TextEditingController issuesTitle = TextEditingController();
   final TextEditingController descripation = TextEditingController();

       Widget _textfieldBtn(int index) {
        print(issuesdetails);
    bool isLast = index == issuesdetails.length - 1;


    return InkWell(
      onTap: () => setState(
        () => isLast ? issuesdetails.add(IssuesInfo(issues: TextEditingController(), Issuesimage: Issuesimage)) :issuesdetails.removeAt(index),
      ),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isLast ? Colors.green : Colors.red,
        ),
        child: Icon(
          isLast ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  void initState() {
    super.initState();
  
issuesdetails.add(IssuesInfo(issues: TextEditingController(), Issuesimage: Issuesimage));
   
  //  _controller.text = widget.initialValue ?? '';
  }
 PlatformFile? _platformFile;
    File? _file;

List submitdata = [];

  save(){

print('saved-successfully');
  


// for(int i=0; i<issuesdetails.length;i++){
//   String image=all_obj
//       .where((element) => element['index'] == i)
//       .map((element) => element['image'])
//       .first;

if(pickedFile==null){
  issues(issuesTitle.text, descripation.text,_value,context);

}
else{
      
uploadfile(issuesTitle.text, descripation.text,context,pickedFile,_value);
}

              


      


//       //  submitdata .add({
//       //   'issues': issuesdetails[i].issues.text,
//       //   'image':image==null?null:image,
      
//       // });
// }





// issuesdetails.map((info) {
//       submitdata .add({
//         'issues': info.issues.text,
//         'image': info.Issuesimage,
      
//       });
//     }).toList();
    print(submitdata);




  
  }
  File? pickedFile;
  void captureImage() async {

    //int index=widget.index;

   
       var pickedFiles = await ImagePicker().pickImage(source: ImageSource.camera);
       pickedFile=File(pickedFiles!.path);
      
   //uploadImageToFirebase(File(pickedFile!.path),pickedFile!.path);

   
      //widget.files=image;
      all_obj.add({'image':File(pickedFile!.path)});


    // if (issuesdetails.isNotEmpty) {
 // issuesdetails[0].Issuesimage = image;

//  // issuesdetails[1]["Issuesimage"]=image; 
// } else {
//   print('The issuesdetails list is either null or empty.');
// }


     
      setState(() {
        _platformFile = PlatformFile(
          name: 'captured_image.jpg',
          size: File(pickedFiles.path).lengthSync(),
          path:  pickedFiles.path,
        );
        _file = File(pickedFiles.path);
      });
    
  }
String _value = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.type==1?
        
        
        
        
        AppBar(  
        title: const Text('Create issues', style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),),  
          backgroundColor: Color(0xFFE7A92D),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
             setState(() {  
      selectedIndex = 0;  
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
    });  
          },
        ),
        ):null,

        
        body:SingleChildScrollView(child:
         Column(
          
            children: <Widget>[
                SizedBox(height: 25,),
                 Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),

             child: TextFormField(
                controller: issuesTitle,
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: widget.type==1?'Issues Title':'Project Titile',
                    ),
              )),
              SizedBox(height: 10,),
                 Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
            
child:TextFormField(
                       controller: descripation,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration( 
                         border: OutlineInputBorder(),
                         hintText: "Short Descripation",
                         focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black)
                         )
                      ),
                       
                   )),

 SizedBox(height: 15,),


 if(widget.type==1)...[
   Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),

             child: 
 DropdownButtonFormField<String>(
        value: _value,
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem(
            child: Text('Select Priority'),
            value: '0',
          ),
          DropdownMenuItem(
            child: Text('Low'),
            value: '1',
          ),
          DropdownMenuItem(
            child: Text('High'),
            value: '2',
          ),
        ],
        onChanged: (value) {
          setState(() => _value = value!);
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
      )),




SizedBox(height: 10,),






GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.camera),
                                      title: Text('Capture Image'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        captureImage();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.folder),
                                      title: Text('Select File'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      //  selectFile();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              color: Colors.blue.shade400,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'select image',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        _platformFile != null
                            ? Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(0, 1),
                                            blurRadius: 3,
                                            spreadRadius: 2,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              _file!,
                                              width: 70,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _platformFile!.name,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '${(_platformFile!.size / 1024).ceil()} KB',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                // Container(
                                                //   height: 5,
                                                //   clipBehavior: Clip.hardEdge,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.circular(5),
                                                //     color: Colors.blue.shade50,
                                                //   ),
                                                //   child: LinearProgressIndicator(
                                                //     value:
                                                //         0.5, // Change this value as needed
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              )
                            : Container()],
                      

 Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
               save();
                },
                 style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Change this color to your desired background color
  ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
SizedBox(height: 10,),
            
            ],
        
        )));
  }
}
class IssuesInfo {
  final TextEditingController issues;
  final  XFile? Issuesimage;
 

  IssuesInfo(
      {required this.issues,
      required this.Issuesimage,
     });
}











class DynamicTextfield extends StatefulWidget {
   final TextEditingController? controller;
   final  index;
   XFile? files;
  // final String? initialValue;
  // final void Function(String) onChanged;

   DynamicTextfield({
    super.key,
     this.controller,
     this.index,
     this.files
    // required this.onChanged,
  });

  @override
  State createState() => _DynamicTextfieldState();
}

class _DynamicTextfieldState extends State<DynamicTextfield> {
  
   PlatformFile? _platformFile;
    File? _file;

  @override
  void initState() {
    super.initState();

    

   
  //  _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
  
    super.dispose();
  }

void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.single;
      setState(() {
        _platformFile = file;
        _file = File(file.path!);
      });
    }
  }




   void captureImage() async {

    //int index=widget.index;

   
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      print('capture image');
   // uploadImageToFirebase(File(pickedFile!.path),pickedFile!.path);

    if (  widget.files != null) {
      //widget.files=image;
     // all_obj.add({'image':File(pickedFile!.path),'index':widget.index});


    // if (issuesdetails.isNotEmpty) {
 // issuesdetails[0].Issuesimage = image;

//  // issuesdetails[1]["Issuesimage"]=image; 
// } else {
//   print('The issuesdetails list is either null or empty.');
// }


     
      setState(() {
        _platformFile = PlatformFile(
          name: 'captured_image.jpg',
          size: File(  widget.files!.path).lengthSync(),
          path:   widget.files!.path,
        );
        _file = File(  widget.files!.path);
      });
    }
  }
List<IssuesInfo> issuesdetails = [];

  @override
  Widget build(BuildContext context) {

    
    return 
    
     Column(children: [
    
    GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.camera),
                                      title: Text('Capture Image'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        captureImage();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.folder),
                                      title: Text('Select File'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        selectFile();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              color: Colors.blue.shade400,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'select image',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        _platformFile != null
                            ? Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(0, 1),
                                            blurRadius: 3,
                                            spreadRadius: 2,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              _file!,
                                              width: 70,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _platformFile!.name,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '${(_platformFile!.size / 1024).ceil()} KB',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                // Container(
                                                //   height: 5,
                                                //   clipBehavior: Clip.hardEdge,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.circular(5),
                                                //     color: Colors.blue.shade50,
                                                //   ),
                                                //   child: LinearProgressIndicator(
                                                //     value:
                                                //         0.5, // Change this value as needed
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              )
                            : Container(),
                      
                             SizedBox(height: 20),
    
     TextFormField(
      controller: widget.controller,
     // onChanged: widget.onChanged,
      decoration: const InputDecoration(hintText: "Add Issues"),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    )]);

  }
}