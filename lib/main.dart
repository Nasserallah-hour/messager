import 'package:flutter/material.dart';

import 'Screens/Login_Screen/Login_Page.dart';



void main() {
 
  runApp(const MyApp());
    
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blueGrey,
      ),
    
      home:  const login_page(),
         
        
      
    );
  }
}