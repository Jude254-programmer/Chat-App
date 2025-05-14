import 'package:bonjour/pages/home_page.dart'; // You'll need to create this page
import 'package:bonjour/pages/sign_up_page.dart';
import 'package:bonjour/services/auth_service.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _obsecureText = true;
  bool _isLoading = false;
  String? _errorMessage;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Validate form inputs
  bool _validateInputs() {
    setState(() {
      _errorMessage = null;
    });

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Email/username and password are required';
      });
      return false;
    }

    return true;
  }

  // Handle forgot password
  Future<void> _forgotPassword() async {
    // Show a dialog to get the user's email
    final TextEditingController resetEmailController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Password'),
        content: TextField(
          controller: resetEmailController,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email address',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (resetEmailController.text.isNotEmpty) {
                try {
                  await _authService.resetPassword(resetEmailController.text.trim());
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password reset email sent!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
            child: Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }

  // Sign in with Firebase
  Future<void> _signIn() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signIn(
        emailOrUsername: emailController.text.trim(),
        password: passwordController.text,
      );

      // Navigate to home page on successful login
      if (mounted) {
        // Replace with your actual home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF81D4FA),
                  Color(0xFF0288D1),
                ],
              )),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 25),
            child: Text(
              "Hello\nSign In!",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.tertiary),
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
                    bottomRight: Radius.circular(40))),
            child: Padding(
              padding:
              const EdgeInsets.only(left: 18.0, right: 18.0, top: 70.0),
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
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: Text(
                            'Email/Username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0288D1),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: _obsecureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon:Icon(_obsecureText? Icons.visibility_off:Icons.visibility,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: (){
                              setState(() {
                                _obsecureText=!_obsecureText;
                              });
                            },
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0288D1),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _forgotPassword,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: _isLoading ? null : _signIn,
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
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(color: Theme.of(context).colorScheme.tertiary)
                              : Text(
                            "SIGN IN",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 300,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.inversePrimary),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage(),fullscreenDialog: true));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color:
                                  Color(0xFF0288D1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}