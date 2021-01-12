
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparklestar/pages.dart';

class AuthenticationHome extends StatefulWidget{
  _AuthenticationHomeState createState() => _AuthenticationHomeState();
}

class _AuthenticationHomeState extends State<AuthenticationHome>{
  Widget build(BuildContext context){
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
           Container(
              width: _screenSize.width,
              child: RaisedButton(
                splashColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                color: Theme.of(context).accentColor,
                child: Text('Sign up',
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: _screenSize.width ,
              //padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text(
                  'Sign in',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}