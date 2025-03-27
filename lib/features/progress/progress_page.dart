import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressPage extends StatelessWidget {
  final List<Map<String, dynamic>> levels = [
    {
      "level": "Grade 1",
      "audio": "Recording 1.mp3",
      "quizScore": "85%",
    },
    {
      "level": "Grade 2",
      "audio": "Recording 2.mp3",
      "quizScore": "90%",
    },
    {
      "level": "Grade 3",
      "audio": "Recording 3.mp3",
      "quizScore": "88%",
    },
    {
      "level": "Grade 4",
      "audio": "Recording 4.mp3",
      "quizScore": "92%",
    },
    {
      "level": "Grade 5",
      "audio": "Recording 5.mp3",
      "quizScore": "95%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overall Progress",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildOverallProgressCard(),
          SizedBox(height: 20),
          Text(
            "Level Progress",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: levels.length,
              itemBuilder: (context, index) {
                return _buildLevelCard(levels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallProgressCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressRow(
              icon: Icons.star,
              label: "Total Quiz Average",
              value: "90%",
              color: Colors.orange,
            ),
            SizedBox(height: 10),
            _buildProgressRow(
              icon: Icons.audiotrack,
              label: "Total Audio Recordings",
              value: "5",
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            _buildProgressRow(
              icon: Icons.emoji_events,
              label: "Achievements",
              value: "3 Badges Earned",
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLevelCard(Map<String, dynamic> level) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              level["level"],
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Icon(Icons.audiotrack, color: Colors.blue),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Audio: ${level["audio"]}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.withOpacity(0.2),
                  child: Icon(Icons.quiz, color: Colors.green),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Quiz Score: ${level["quizScore"]}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
