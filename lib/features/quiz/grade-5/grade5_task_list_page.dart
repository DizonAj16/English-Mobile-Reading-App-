import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task1_week1_page.dart';
import 'task2_week2_page.dart';
import 'task3_week3_page.dart';
import 'task4_week4_page.dart';
import 'task5_week5_page.dart';

class Grade5TaskListPage extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = [
    { "title": "Task 1 - Week 1", "page": Task1Week1Page() },
    { "title": "Task 2 - Week 2", "page": Task2Week2Page() },
    { "title": "Task 3 - Week 3", "page": Task3Week3Page() },
    { "title": "Task 4 - Week 4", "page": Task4Week4Page() },
    { "title": "Task 5 - Week 5", "page": Task5Week5Page() },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade 5 Tasks", style: GoogleFonts.poppins()),
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