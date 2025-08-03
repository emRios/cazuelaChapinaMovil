import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';
import '../../domain/i_auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final UserModel? user =
          await authRepository.login(event.email, event.password);

      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure('Credenciales incorrectas'));
      }
    } catch (e) {
      emit(LoginFailure('Error inesperado: ${e.toString()}'));
    }
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'login_event.dart';
// import 'login_state.dart';
// import '../../data/services/auth_service.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthService authService;

//   LoginBloc(this.authService) : super(const LoginState()) {
//     on<LoginEmailChanged>((event, emit) {
//       emit(state.copyWith(email: event.email, error: null));
//     });

//     on<LoginPasswordChanged>((event, emit) {
//       emit(state.copyWith(password: event.password, error: null));
//     });

//     on<LoginSubmitted>((event, emit) async {
//       emit(state.copyWith(isLoading: true, error: null));

//       try {
//         final user = await authService.login(state.email, state.password);

//         if (user == null) {
//           emit(state.copyWith(isLoading: false, error: 'Credenciales incorrectas'));
//         } else {
//           emit(state.copyWith(isLoading: false, user: user));
//         }
//       } catch (e) {
//         emit(state.copyWith(isLoading: false, error: 'Error de conexión'));
//       }
//     });
//   }
// }
