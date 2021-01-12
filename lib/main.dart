import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparklestar/BLOCS/signin_bloc.dart/signin.dart';
import 'package:sparklestar/SRC/SERVICES/services.dart';
import 'package:sparklestar/pages.dart';

import 'BLOCS/auth_bloc/auth.dart';
import 'BLOCS/signup_bloc.dart/signup.dart';
import 'SRC/REPOSITORIES/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthenticationService>(
          create: (context) => FirebaseAuthenticationService()),
      RepositoryProvider<UsrRepository>(
          create: (context) => FireStoreUsrRepo()),
      RepositoryProvider<ItemRepository>(
        create: (context) => ItemRepo(),
      )
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (context) {
          final _authService =
              RepositoryProvider.of<AuthenticationService>(context);
          return AuthenticationBloc(_authService)..add(AppLoaded());
        }),
        BlocProvider<SigninBloc>(create: (context) {
          // ignore: close_sinks
          final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
          final _authService =
              RepositoryProvider.of<AuthenticationService>(context);
          return SigninBloc(_authBloc, _authService);
        }),
        BlocProvider<SignupBloc>(create: (context) {
          // ignore: close_sinks
          final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
          final _authService =
              RepositoryProvider.of<AuthenticationService>(context);
          final _userRepository = RepositoryProvider.of<UsrRepository>(context);
          return SignupBloc(_authBloc, _authService, _userRepository);
        }),
      ],
      child: Sparkle(),
    ),
  ));
}

class Sparkle extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sparkle',
        home: SafeArea(child:
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
          if (state is AuthenticationLoading)return SplashScreen();
          if (state is AuthenticationAuthenticated) return Home();
          if (state is AuthenticationFailure) print(state.toString());
          if (state is AuthenticationUnAuthenticated)
            return AuthenticationHome();
          print('State: ${state.toString()}');
          return Container();
        })));
  }
}
