
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparklestar/BLOCS/auth_bloc/auth.dart';
import 'package:sparklestar/BLOCS/signin_bloc.dart/signin_event.dart';
import 'package:sparklestar/BLOCS/signin_bloc.dart/signin_state.dart';
import 'package:sparklestar/SRC/SERVICES/authentication_service.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState>{
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  SigninBloc(AuthenticationBloc authenticationBloc,
  AuthenticationService authenticationService) 
  : assert(authenticationBloc != null),
  assert(authenticationService != null),
  _authenticationBloc = authenticationBloc,
  _authenticationService = authenticationService, 
  super(SigninInitial());

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
   if(event is SigninBtnPressed){
     yield* _mapSigninBtnPressedtoState(event);
   }
  }

  Stream<SigninState> _mapSigninBtnPressedtoState(
    SigninBtnPressed event) async* {
      yield SigninLoading();
      try {
        await _authenticationService.signIn(event.email, event.password);
        _authenticationBloc.add(UserLoggedIn());  
      } catch(e){
        yield SigninFailure(error: e.message ?? 'an Unknown error has occured');
      }
    }
}