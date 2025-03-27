import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_service.dart';

class StudentProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Student Profile", style: GoogleFonts.poppins()),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Edit Profile"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Hero(
              tag: 'studentAvatar',
              child: CircleAvatar(
                radius: 60, // Larger profile image
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Image.asset(
                    "assets/placeholders/student-placeholder.png",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              user?.name ?? "Loading...",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Grade 5 - Section A", // Updated to include section
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Student Information
            _buildProfileInfo("Learner Reference Number (LRN)", "123456789012", Icons.perm_identity, Colors.blue),
            _buildProfileInfo("Email", user?.email ?? "N/A", Icons.email, Colors.green),
            _buildProfileInfo("School", "Santa Maria Elementary School", Icons.school, Colors.orange),
            _buildProfileInfo("Age", "10 years old", Icons.cake, Colors.purple),
            _buildProfileInfo("Address", "123 Brgy. San Jose, Zamboanga City", Icons.home, Colors.red),
            _buildProfileInfo("Guardian Name", "Maria Dela Cruz", Icons.person, Colors.teal),
            _buildProfileInfo("Guardian Contact", "+63 912 345 6789", Icons.phone, Colors.brown),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          subtitle: Text(value, style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700])),
        ),
      ),
    );
  }
}