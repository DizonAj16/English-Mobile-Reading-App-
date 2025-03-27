import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/theme_toggle.dart';
import '../../core/services/auth_service.dart';
import '../profile page/profile_page.dart';
import '../dashboard/dashboard_page.dart';
import '../quiz/task_page.dart';
import '../progress/progress_page.dart';
import '../badges/badge_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Pages for bottom navigation
  final List<Widget> _pages = [
    DashboardPage(), // Home
    TaskPage(), // Tasks/Activities
    ProgressPage(), // Assessment
    BadgePage(), // Progress & Unlocking
  ];

  // Titles for each tab
  final List<String> _titles = [
    "Dashboard",
    "Tasks & Activities",
    "Assessment",
    "Badges",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex], // Dynamically update the title
          style: GoogleFonts.poppins(),
        ),
        actions: [
          ThemeToggle(), // Theme toggle button
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Ensures it doesn't expand unnecessarily
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500), // Smooth transition duration
                          pageBuilder: (context, animation, secondaryAnimation) => StudentProfilePage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation), // Smooth zoom effect
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'studentAvatar',
                      child: CircleAvatar(
                        radius: 40, // Increase the radius
                        backgroundColor: Colors.grey[300], // Optional: Background color
                        child: ClipOval(
                          child: Image.asset(
                            "assets/placeholders/student-placeholder.png",
                            width: 90, // Adjust width to fit properly inside CircleAvatar
                            height: 90, // Adjust height to match
                            fit: BoxFit.cover, // Ensures the image scales well
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Reduced space to fit better
                  Text(
                    user?.name ?? "Loading...", // Display fetched user name
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // Prevents overflow
                  ),
                  Text(
                    "Grade 5 Student",
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // Prevents overflow
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text("Achievements"),
              onTap: () {
                // Navigate to Achievements Page
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Reading History"),
              onTap: () {
                // Navigate to Reading History Page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                // Navigate to Settings Page
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help & Support"),
              onTap: () {
                // Navigate to Help & Support Page
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About the App"),
              onTap: () {
                // Navigate to About Page
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                // Navigate to Feedback Page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                // Show confirmation dialog before logout
                bool confirmLogout = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text("Logout", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirmLogout == true) {
                  // Call the logout function from AuthService (it handles loading & navigation)
                  await Provider.of<AuthService>(context, listen: false).logout(context);
                }
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // Show selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks/Activities"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Assessment"),
          BottomNavigationBarItem(icon: Icon(Icons.lock_open), label: "Progress & Unlocking"),
        ],
      ),
    );
  }
}