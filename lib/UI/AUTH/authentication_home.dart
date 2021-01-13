
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                width: _screenSize.width,
                child: RaisedButton(
                  splashColor: Theme.of(context).accentColor,
                  onPressed: () {
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  color: Theme.of(context).accentColor,
                  child: Text('Sign in',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}