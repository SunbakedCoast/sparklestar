import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparklestar/BLOCS/auth_bloc/auth.dart';
import 'package:sparklestar/BLOCS/signup_bloc.dart/signup.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';

class SignUp extends StatelessWidget {
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
        backgroundColor: Theme.of(context).backgroundColor,
        body: _SignupForm()
      ),
    );
  }
}

class _SignupForm extends StatefulWidget {
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextcontroller = TextEditingController();
  final _passwordTextController = TextEditingController();

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    // ignore: close_sinks
    final _signupBloc = BlocProvider.of<SignupBloc>(context);

    _signupBtnPressed() {
      if (_key.currentState.validate()) {
        _signupBloc.add(SignupBtnPressed(
            email: _emailTextcontroller.text.trim(),
            password: _passwordTextController.text.trim()));
        _signupBloc.add(SendUserDataWithButtonPressed(
            user: Usr(
          name: _nameTextController.text.trim(),
          email: _emailTextcontroller.text.trim(),
        )));
      }
    }

    return BlocListener<SignupBloc, SignupState>(listener: (context, state) {
      if (state is SignupFailure) {
        return _showErr(context, state.error);
      }
    }, child: BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      if (state is SignupLoading) {
        return _showProgressIndicator();
      }
      if (state is SignupFailure) {
        print(state.toString());
      }
      if (state is SignupInitial) {
        print(state.toString());
      }
      return Center(
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: TextFormField(
                    //autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: _nameTextController,
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Username is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
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
                        return 'Email is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: TextFormField(
                    //autocorrect: false,
                    obscureText: true,
                    controller: _passwordTextController,
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Password 6+ characters',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    validator: (value) {
                      if (value.length < 6) {
                        return 'Password must be greater than 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: SizedBox(
                    width: _screenSize.width,
                    child: RaisedButton(
                      elevation: 4.0,
                      splashColor: Colors.white,
                      onPressed:
                          state is SignupLoading ? () {} : _signupBtnPressed,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
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
