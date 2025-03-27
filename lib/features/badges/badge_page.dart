import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgePage extends StatelessWidget {
  final List<Map<String, dynamic>> badges = [
    {
      "grade": "Grade 1",
      "badge": "Beginner Reader",
      "description": "Awarded for completing Grade 1.",
      "icon": Icons.star,
      "color": Colors.blue,
    },
    {
      "grade": "Grade 2",
      "badge": "Intermediate Reader",
      "description": "Awarded for completing Grade 2.",
      "icon": Icons.book,
      "color": Colors.green,
    },
    {
      "grade": "Grade 3",
      "badge": "Advanced Reader",
      "description": "Awarded for completing Grade 3.",
      "icon": Icons.school,
      "color": Colors.orange,
    },
    {
      "grade": "Grade 4",
      "badge": "Expert Reader",
      "description": "Awarded for completing Grade 4.",
      "icon": Icons.explore,
      "color": Colors.purple,
    },
    {
      "grade": "Grade 5",
      "badge": "Master Reader",
      "description": "Awarded for completing Grade 5.",
      "icon": Icons.emoji_events,
      "color": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2, // Display 2 cards per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7, // 3:4 aspect ratio
        children: badges.map((badge) => _buildBadgeCard(badge)).toList(),
      ),
    );
  }

  Widget _buildBadgeCard(Map<String, dynamic> badge) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: badge["color"].withOpacity(0.2),
              child: Icon(badge["icon"], color: badge["color"], size: 60),
            ),
            SizedBox(height: 10),
            Text(
              badge["badge"],
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              badge["grade"],
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              badge["description"],
              style: GoogleFonts.poppins(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
