import 'package:deped_reading_app/features/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/theme_toggle.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String role = "student"; // Default role
  bool _obscurePassword = true; // Password visibility toggle
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>(); // Form validation key

  void signUp() async {
    if (!_formKey.currentState!.validate())
      return; // Validate form before submitting

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signUp(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        role,
        context, // Pass context for navigation and dialogs
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: GoogleFonts.poppins()),
        actions: [
          ThemeToggle(), // Dark Mode Toggle
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logos/deped-logo-1.png',
                    height: 200), // Fun login animation
                SizedBox(height: 20),

                Text(
                  "Create an Account",
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Join and improve your reading skills!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 30),

                // Name Field
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon:
                        Icon(Icons.person, color: Colors.deepPurpleAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter your name" : null,
                ),
                SizedBox(height: 15),

                // Email Field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon:
                        Icon(Icons.email, color: Colors.deepPurpleAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.contains('@') ? null : "Enter a valid email",
                ),
                SizedBox(height: 15),

                // Password Field with Show/Hide Icon
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon:
                        Icon(Icons.lock, color: Colors.deepPurpleAccent),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) =>
                      value!.length < 6 ? "Password too short" : null,
                ),

                SizedBox(height: 15),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock_outline,
                        color: Colors.deepPurpleAccent),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return "Enter password again";
                    if (value != passwordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),

                SizedBox(height: 15),

                // Role Selection Dropdown
                DropdownButtonFormField<String>(
                  value: role,
                  onChanged: (value) => setState(() => role = value!),
                  items: ["student", "teacher"].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Text(role, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Select Role",
                    prefixIcon: Icon(
                      role == "student"
                          ? Icons.school
                          : Icons.person_3, // Changes dynamically
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),

                SizedBox(height: 20),

                // Signup Button
                ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Sign Up",
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 15),

                // Login Redirect
                GestureDetector(
                  onTap: () => navigateToLoginPage(context),
                  child: Text(
                    "Already have an account? Login",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
