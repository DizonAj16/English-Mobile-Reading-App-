import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_service.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(user?.name ?? "Loading..."),
          SizedBox(height: 20),
          _buildStatsSection(context),
          SizedBox(height: 20),
          _buildTaskSection(),
          SizedBox(height: 20),
          _buildAssessmentSection(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👋 Hi $userName,", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Reading Level: Beginner", style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/placeholders/student-placeholder.png'),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4; // Adjust grid columns based on screen width
    final childAspectRatio = screenWidth < 600 ? 1.5 : 1.8; // Adjust aspect ratio for better spacing

    return SizedBox(
      height: crossAxisCount == 2 ? 270 : 200, // Adjust height based on grid layout
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildStatCard("📚 Total Reading Time", "1h 20m", Colors.blue),
          _buildStatCard("🎯 Level Progress", "Level A", Colors.green),
          _buildStatCard("🏆 Rank", "N/A", Colors.orange),
          _buildStatCard("🏆 Badge", "Iron", const Color.fromARGB(255, 0, 255, 38)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: EdgeInsets.all(16), // Increased padding for spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("📖 Tasks & Activities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _buildDashboardCard("Reading Activity", "Start reading and record voice", Icons.menu_book, Colors.blue),
        _buildDashboardCard("Exercise", "Complete your exercises", Icons.edit, Colors.green),
      ],
    );
  }

  Widget _buildAssessmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("📝 Assessment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _buildDashboardCard("Reading Test", "Record voice and measure progress", Icons.mic, Colors.orange),
        _buildDashboardCard("Comprehension Quiz", "Answer questions to proceed", Icons.quiz, Colors.red),
      ],
    );
  }

  Widget _buildDashboardCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}