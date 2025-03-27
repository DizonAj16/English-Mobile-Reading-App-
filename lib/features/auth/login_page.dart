import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/theme_toggle.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void navigateToRegisterPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(),
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
  bool _obscureText = true; // Show/Hide password toggle

  final _formKey = GlobalKey<FormState>(); // Form validation key

  void login() async {
    if (!_formKey.currentState!.validate())
      return; // Validate form before submitting

    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.login(
        emailController.text.trim(), passwordController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: GoogleFonts.poppins()),
        actions: [
          ThemeToggle(), // Dark Mode Toggle
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logos/deped-logo-1.png',
                      height: 200), // Fun login animation
                  SizedBox(height: 20),
                  Text(
                    "Welcome Back!",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Login to continue your learning journey.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 30),

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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!value.contains('@')) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Password Field with Show/Hide Icon
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon:
                          Icon(Icons.lock, color: Colors.deepPurpleAccent),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),

                  // Login Button
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Login",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white)),
                  ),
                  SizedBox(height: 15),

                  // Sign Up Redirect
                  GestureDetector(
                    onTap: () => navigateToRegisterPage(context),
                    child: Text(
                      "Don't have an account? Sign Up",
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
      ),
    );
  }
}
