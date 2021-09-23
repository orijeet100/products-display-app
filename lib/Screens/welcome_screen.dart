import 'package:applore/Screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Hero(
                    child: Image.asset(
                      'images/27358-8-sparkle-transparent-background.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    tag: 'image',
                  ),
                  const Expanded(
                    child: Text(
                      'App Lore',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Righteous',
                        fontSize: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  child: Text('Login', style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple[900],
                    fontSize: 18,
                  )),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                  minWidth: double.infinity,
                  height: 45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  child: Text('Register', style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple[900],
                    fontSize: 18,
                  )),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                  },
                  minWidth: double.infinity,
                  height: 45,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
