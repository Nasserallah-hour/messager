
// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:messager/Components/ChatController.dart';
import 'package:messager/Model/message.dart';
import 'package:messager/Screens/Message_Screen/message_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '../../constants.dart';

class login_page extends StatefulWidget {
  const login_page({ Key? key }) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
 TextEditingController roomnumber =TextEditingController()  ;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   return Scaffold(
     body:  Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children:  [
         
           Text("Connect to a room"),
           Container(
             padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
             width: width/2,
             child: TextField(
               controller:roomnumber,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter room number',
                    ),
),
           ),
            ElevatedButton(
             onPressed:  () { 
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  messagescreen(room: roomnumber.text,)),
  );
              },
           child: Text("Enter Room"),)

           
         ],),
     )
     
   );
   
  }



  
}

