import 'package:applore/Screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner=false;
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body:ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: ListView(
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Hero(
                    child: Image.asset(
                      'images/27358-8-sparkle-transparent-background.png',
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                    tag: 'image',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: TextFormField(
                  obscureText: false,
                  decoration: KTextField.copyWith(hintText: 'Enter your email address'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    email=value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  obscureText: false,
                  decoration: KTextField.copyWith(hintText: 'Enter your password'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value){
                    password=value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Material(
                  elevation: 5,
                  color: Color(0xFF2576FF),
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    child: Text('Login', style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18,
                    )),
                    onPressed: () async{
                      setState(() {
                        showSpinner=true;
                      });
                      await _auth.signInWithEmailAndPassword(email: email, password: password);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen()));
                      setState(() {
                        showSpinner=false;
                      });

                    },
                    minWidth: double.infinity,
                    height: 45,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

