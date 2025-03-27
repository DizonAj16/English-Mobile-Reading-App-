import 'package:deped_reading_app/features/onboarding/get_started_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/home/home_page.dart';
import '../../features/auth/login_page.dart';
import '../../models/user_model.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _user;
  UserModel? get user => _user; // Expose user state

  AuthService() {
    _auth.authStateChanges().listen((User? newUser) async {
      if (newUser != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(newUser.uid).get();
        _user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>, newUser.uid);
      } else {
        _user = null;
      }
      notifyListeners(); // Notify UI of authentication state change
    });
  }

  // Show loading dialog
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Processing..."),
          ],
        ),
      ),
    );
  }

  // Show snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  // Sign Up with Email & Password
  Future<void> signUp(String name, String email, String password, String role, BuildContext context) async {
    try {
      _showLoadingDialog(context); // Show loading

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user details in Firestore
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        role: role,
      );
      await _firestore.collection('users').doc(newUser.uid).set(newUser.toMap());

      _user = newUser;
      notifyListeners(); // Notify UI after signup

      Navigator.pop(context); // Close loading dialog
      _showSnackbar(context, "Successfully Registered!"); // Show snackbar

      // Navigate to LoginPage after signup
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      Navigator.pop(context); // Close loading dialog on error
      _showSnackbar(context, "Registration Failed: ${e.toString()}");
      print("Sign Up Error: $e");
    }
  }

  // Login with Email & Password
  Future<void> login(String email, String password, BuildContext context) async {
    try {
      _showLoadingDialog(context); // Show loading dialog

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      _user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userCredential.user!.uid);
      notifyListeners(); // Notify UI on login

      // Save login state in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pop(context); // Close loading dialog
      _showSnackbar(context, "Login Successful!"); // Show success message

      // Navigate to HomePage after successful login
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading dialog if there's an error

      String errorMessage = "Login Failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      } else if (e.code == 'too-many-requests') {
        errorMessage = "Too many attempts. Please try again later.";
      }

      _showSnackbar(context, errorMessage); // Show error message
    } catch (e) {
      Navigator.pop(context); // Close loading dialog if there's an unexpected error
      _showSnackbar(context, "An unexpected error occurred: ${e.toString()}");
    }
  }

  // Logout
  Future<void> logout(BuildContext context) async {
    try {
      _showLoadingDialog(context); // Show loading dialog

      await Future.delayed(Duration(milliseconds: 2500)); // Ensure dialog appears
      await _auth.signOut(); // Perform logout

      _user = null;
      notifyListeners(); // Notify UI on logout

      // Clear login state in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      if (Navigator.canPop(context)) {
        Navigator.pop(context); // Close loading dialog
      }
      _showSnackbar(context, "Logged out successfully!"); // Show snackbar

      // Navigate to GetStartedPage after logout
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStartedPage()));
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context); // Close loading dialog on error
      }
      _showSnackbar(context, "Logout Failed: ${e.toString()}");
      print("Logout Error: $e");
    }
  }

  // Get Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}