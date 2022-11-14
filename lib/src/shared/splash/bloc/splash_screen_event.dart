part of 'splash_screen_bloc.dart';

@Freezed()
class SplashScreenEvent with _$SplashScreenEvent {
  const factory SplashScreenEvent.showSplashScreen() = ShowSplashScreen;
  const factory SplashScreenEvent.naviagteToHomeScreen() = NavigateToHomeScreen;
}
