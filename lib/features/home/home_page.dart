import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/theme_toggle.dart';
import '../../core/services/auth_service.dart';
import '../stories/story_list_page.dart';
import '../quiz/quiz_page.dart';
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
    StoryListPage(),
    QuizPage(),
    ProgressPage(),
    BadgePage(),
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
        title: Text("Reading App", style: GoogleFonts.poppins()),
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
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person_2, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?.name ?? "Loading...", // Display fetched user name
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text("Stories"),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.quiz),
              title: Text("Quizzes"),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text("Progress"),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text("Badges"),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
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
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Stories"),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "Quizzes"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Badges"),
        ],
      ),
    );
  }
}