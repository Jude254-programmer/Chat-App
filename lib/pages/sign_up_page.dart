import 'package:bonjour/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bonjour/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  bool _obsecureText = true;
  bool _isLoading = false;
  String? _errorMessage;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  // Validate form inputs
  bool _validateInputs() {
    // Reset error message
    setState(() {
      _errorMessage = null;
    });

    // Check if any field is empty
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required';
      });
      return false;
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(emailController.text)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address';
      });
      return false;
    }

    // Password length validation
    if (passwordController.text.length < 6) {
      setState(() {
        _errorMessage = 'Password must be at least 6 characters';
      });
      return false;
    }

    // Username validation - only allow alphanumeric characters and underscores
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(usernameController.text)) {
      setState(() {
        _errorMessage = 'Username can only contain letters, numbers, and underscores';
      });
      return false;
    }

    return true;
  }

  // Sign up with Firebase
  Future<void> _signUp() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
        username: usernameController.text.trim(),
      );

      // Show success message first
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully! Please sign in.'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login page after the user is notified
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF81D4FA),
                  Color(0xFF0288D1),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 25),
              child: Text(
                "Hello!\nCreate Account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 60.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Error message display
                      if (_errorMessage != null)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          width: double.infinity,
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0288D1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: Text(
                            'Username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0288D1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: _obsecureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obsecureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0288D1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: _isLoading ? null : _signUp,
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF81D4FA),
                                Color(0xFF0288D1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: _isLoading
                                ? CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.tertiary)
                                : Text(
                              "SIGN UP",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 250),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Color(0xFF0288D1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
