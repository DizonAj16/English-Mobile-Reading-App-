import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task1LevelC1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 1 - Level C-1", style: GoogleFonts.poppins()),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Text(
          "Welcome to Task 1 - Level C1!",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}