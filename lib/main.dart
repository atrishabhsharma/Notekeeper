import "package:flutter/material.dart";
import 'package:notekeeper/screens/note_list.dart';


void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Notekeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),  //themedata
      home:Notelist(),
    );
  }
}
