part of 'splash_screen_bloc.dart';

enum SplashState { idle, close, load }

@Freezed()
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState(
          {@Default(SplashState.idle) SplashState splashState}) =
      _SplashScreenState;

  factory SplashScreenState.initial() => const SplashScreenState();
}
