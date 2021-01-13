import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparklestar/BLOCS/auth_bloc/auth.dart';
import 'package:sparklestar/BLOCS/signin_bloc.dart/signin.dart';

class SignIn extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationUnAuthenticated) {
        print(state.toString());
        return _Form();
      }
      if (state is AuthenticationFailure) {
        print(state.toString());

        return _Form();
      }
      if (state is AuthenticationAuthenticated) {
        print(state.toString());

        Navigator.popUntil(
            context, ModalRoute.withName(Navigator.defaultRouteName));
      }
      print('Auth state ${state.toString()}');
      return _progressIndicator();
    });
  }

  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Form extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _SigninForm(),
      ),
    );
  }
}

class _SigninForm extends StatefulWidget {
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<_SigninForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailTextcontroller = TextEditingController();
  final _passwordTextController = TextEditingController();

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    // ignore: close_sinks
    final _signinBloc = BlocProvider.of<SigninBloc>(context);

    _signinBtnPressed() {
      if (_key.currentState.validate()) {
        _signinBloc.add(SigninBtnPressed(
            email: _emailTextcontroller.text.trim(),
            password: _passwordTextController.text.trim()));
      }
    }

    return BlocListener<SigninBloc, SigninState>(listener: (context, state) {
      if (state is SigninFailure) {
        return _showErr(context, state.error);
      }
    }, child: BlocBuilder<SigninBloc, SigninState>(builder: (context, state) {
      if (state is SigninLoading) {
        _showProgressIndicator();
      }
      if (state is SigninFailure) {
        print(state.toString());
      }
      if (state is SigninInitial) {
        print(state.toString());
      }

      return Form(
        key: _key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text('Sign in',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextcontroller,
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    //margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _passwordTextController,
                        obscureText: true,
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password is required';
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: SizedBox(
                      width: _screenSize.width,
                      child: RaisedButton(
                        elevation: 4.0,
                        splashColor: Colors.black,
                        onPressed: _signinBtnPressed,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }

  _showErr(BuildContext context, String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ));
  }

  Widget _showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
