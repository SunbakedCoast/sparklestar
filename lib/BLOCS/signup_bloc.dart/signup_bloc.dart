
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparklestar/BLOCS/auth_bloc/auth.dart';
import 'package:sparklestar/BLOCS/signup_bloc.dart/signup.dart';
import 'package:sparklestar/SRC/REPOSITORIES/user_repository.dart';
import 'package:sparklestar/SRC/SERVICES/authentication_service.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;
  final UsrRepository _usrRepository;

  SignupBloc(AuthenticationBloc authenticationBloc,
  AuthenticationService authenticationService,
  UsrRepository usrRepository) 
  : assert(authenticationBloc != null),
  assert(authenticationService !=null),
  assert(usrRepository != null),
  _authenticationBloc = authenticationBloc,
  _authenticationService = authenticationService, 
  _usrRepository = usrRepository,
  super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if(event is SignupBtnPressed){
      yield* _mapSignupWithBtnPressedtoState(event);
    }
    if(event is SendUserDataWithButtonPressed){
      yield* _mapSendUserDataWithBtnPressed(event);
    }
  }

  Stream<SignupState> _mapSignupWithBtnPressedtoState(
    SignupBtnPressed event) async* {
      yield SignupLoading();
      await _authenticationService.signUp(event.email, event.password);
      final user = _authenticationService.getCurrentUser();
      if(user != null) 
      _authenticationBloc.add(UserLoggedIn());  
      else 
      yield SignupFailure(error: 'Signup Error');
    }

    Stream<SignupState> _mapSendUserDataWithBtnPressed(
      SendUserDataWithButtonPressed event) async* {
        _usrRepository.sendUserData(event.user);
      }
}