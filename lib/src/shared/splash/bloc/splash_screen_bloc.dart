import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';
part 'splash_screen_bloc.freezed.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenState.initial()) {
    on<SplashScreenEvent>(
      (event, emit) => event.map(
        showSplashScreen: (event) => _showSplashScreen(event, emit),
        naviagteToHomeScreen: (event) => _navigateToHomeScreen(event, emit),
      ),
    );
  }

  void _showSplashScreen(
      ShowSplashScreen event, Emitter<SplashScreenState> emit) {
    emit(
      state.copyWith(
        splashState: SplashState.load,
      ),
    );
  }

  void _navigateToHomeScreen(
      NavigateToHomeScreen event, Emitter<SplashScreenState> emit) {
    emit(
      state.copyWith(
        splashState: SplashState.close,
      ),
    );
  }
}
