import 'package:bonjour/pages/login_page.dart';
import 'package:flutter/material.dart';

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
              )),
          child: Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 25),
            child: Text(
              "Hello!\nCreate Account",
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
              const EdgeInsets.only(left: 18.0, right: 18.0, top: 60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      controller: emailController,
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
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                      height: 50,
                    ),
                    Container(
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
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 250,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 15
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(),fullscreenDialog: true));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color:
                                  Color(0xFF0288D1),
                                  fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),
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
