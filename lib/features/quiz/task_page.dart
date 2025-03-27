import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'grade-1/grade1_task_list_page.dart';
import 'grade-2/grade2_task_list_page.dart';
import 'grade-3/grade3_task_list_page.dart';
import 'grade-4/grade4_task_list_page.dart';
import 'grade-5/grade5_task_list_page.dart';

class TaskPage extends StatelessWidget {
  final List<Map<String, dynamic>> grades = [
    {"grade": "Grade 1", "image": "assets/placeholders/grade1.png"},
    {"grade": "Grade 2", "image": "assets/placeholders/grade2.png"},
    {"grade": "Grade 3", "image": "assets/placeholders/grade3.png"},
    {"grade": "Grade 4", "image": "assets/placeholders/grade4.png"},
    {"grade": "Grade 5", "image": "assets/placeholders/grade5.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select your Grade Level",
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: grades.length,
              itemBuilder: (context, index) {
                return _buildGradeCard(context, grades[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeCard(BuildContext context, Map<String, dynamic> grade) {
    final gradeName = grade["grade"] ?? "Unknown Grade";
    final gradeImage = grade["image"] ?? "assets/placeholders/default.png";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          if (gradeName == "Grade 1") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Grade1TaskListPage()),
            );
          } else if (gradeName == "Grade 2") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Grade2TaskListPage()),
            );
          } else if (gradeName == "Grade 3") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Grade3TaskListPage()),
            );
          } else if (gradeName == "Grade 4") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Grade4TaskListPage()),
            );
          } else if (gradeName == "Grade 5") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Grade5TaskListPage()),
            );
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(gradeImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
