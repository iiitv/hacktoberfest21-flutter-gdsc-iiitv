import 'package:flutter/material.dart';
import 'screens/home_page.dart';



void main() => runApp(MaterialApp(
      title: "Avengers",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    ));
