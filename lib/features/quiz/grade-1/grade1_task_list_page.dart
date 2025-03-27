import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task1_decoder_page.dart' as task1;
import 'task2_level_a1_page.dart' as task2;
import 'task3_level_a2_page.dart' as task3;

class Grade1TaskListPage extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = [
    { "title": "Task 1 - Decoders", "page": task1.Task1DecoderPage() },
    { "title": "Task 2 - Level A-1", "page": task2.Task2LevelA1Page() },
    { "title": "Task 3 - Level A-2", "page": task3.Task3LevelA2Page() },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade 1 Tasks", style: GoogleFonts.poppins()),
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