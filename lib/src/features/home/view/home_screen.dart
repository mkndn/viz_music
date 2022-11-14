import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myartist/src/features/home/view/home_screen_desktop.dart';
import 'package:myartist/src/features/home/view/home_screen_mobile.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/state/inmemory_media_manager.dart';
import 'package:myartist/src/shared/extensions.dart';
import 'package:myartist/src/shared/splash/bloc/splash_screen.dart';
import 'package:myartist/src/shared/splash/bloc/splash_screen_bloc.dart';
import 'package:myartist/src/shared/state/inmemory_state_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.mediaContent, super.key});

  final MediaContent mediaContent;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> loadState(
    InmemoryStateManagerState appState,
    InMemoryMediaManagerState mediaState,
    Function bloc,
  ) async {
    if (!widget.mediaContent.hasContent) {
      bloc().add(const SplashScreenEvent.showSplashScreen());
      await mediaState.init().whenComplete(
            (() => {
                  appState.updateState(updatedState: true),
                  bloc().add(const SplashScreenEvent.naviagteToHomeScreen()),
                }),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadState(
        InmemoryStateManager.of(context),
        InMemoryMediaManager.of(context),
        () => BlocProvider.of<SplashScreenBloc>(context),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SplashScreenBloc>(context);
    final appState = InmemoryStateManager.of(context);

    return BlocBuilder<SplashScreenBloc, SplashScreenState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.splashState == SplashState.load)
            return SplashScreen();
          else if (state.splashState == SplashState.close &&
              appState.isStateLoaded) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // Add conditional mobile layout
                if (constraints.isMobile) {
                  return MobileHomeScreen(mediaContent: widget.mediaContent);
                }
                return DesktopHomeScreen(mediaContent: widget.mediaContent);
              },
            );
          } else {
            return const Text('App is idle');
          }
        });
  }
}
