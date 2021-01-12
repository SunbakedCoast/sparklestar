
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparklestar/BLOCS/auth_bloc/auth.dart';
import 'package:sparklestar/SRC/SERVICES/services.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
  : assert(authenticationService != null),
  _authenticationService = authenticationService,
  super(AuthenticationInitial());


  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if(event is AppLoaded){
      yield* _mapAppLoadedtoState ();
    }
    if(event is UserLoggedIn){
      yield* _mapUserLoggedIntoState();
    }
    if(event is UserLoggedOut){
      yield* _mapUserLoggedOuttoState();
    }
  }

  Stream<AuthenticationState> _mapAppLoadedtoState() async* {
    yield AuthenticationLoading();
    await Future.delayed(Duration(seconds: 3));

    final _currentUser = await _authenticationService.getCurrentUser();
    try{
      if(_currentUser != null){
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnAuthenticated();
      }
    } catch(e){
      yield AuthenticationFailure(
        errorMessage: e.toString() ?? 'An unknown error occured');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedIntoState() async* {
    yield AuthenticationAuthenticated();
  }

  Stream<AuthenticationState> _mapUserLoggedOuttoState() async* {
    yield AuthenticationLoading();
    await _authenticationService.signOut();
    yield AuthenticationUnAuthenticated();
  }
  
  }