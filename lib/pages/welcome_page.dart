import 'package:bonjour/pages/login_page.dart';
import 'package:bonjour/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF0288D1),
              Color(0xFF81D4FA),
              Color(0xFF283957),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.chat,
                    size: 100,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  Text(
                    "VIBE TALK",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  Text(
                    "Where conversations come alive!",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage(),
                              fullscreenDialog: true));
                    },
                    child: Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                          child: Text(
                        "SIGN IN",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                              fullscreenDialog: true));
                    },
                    child: Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                          child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Text(
                    "Continue With",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 18),
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 100)),
                      // facebook
                      Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/ft.webp'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // google
                      Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/xt.webp'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // google
                      Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/google.webp'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
