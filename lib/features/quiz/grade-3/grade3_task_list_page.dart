import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task1_level_c1_page.dart';
import 'task2_level_c2_page.dart';

class Grade3TaskListPage extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = [
    { "title": "Task 1 - Level C-1", "page": Task1LevelC1Page() },
    { "title": "Task 2 - Level C-2", "page": Task2LevelC2Page() },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade 3 Tasks", style: GoogleFonts.poppins()),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  task["title"]!,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => task["page"] as Widget),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}