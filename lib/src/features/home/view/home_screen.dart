import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/features/home/view/home_screen_desktop.dart';
import 'package:mkndn/src/features/home/view/home_screen_mobile.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/state/inmemory_media_manager.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/splash/bloc/splash_screen.dart';
import 'package:mkndn/src/shared/splash/bloc/splash_screen_bloc.dart';
import 'package:mkndn/src/shared/state/inmemory_state_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.mediaContent, super.key});

  final MediaContent mediaContent;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFolderIntact = false;

  Future<void> loadState(
    InmemoryStateManagerState appState,
    InMemoryMediaManagerState mediaState,
    Function bloc,
  ) async {
    isFolderIntact = await mediaState.areFolderConfigIntact();
    if (isFolderIntact) {
      bloc().add(const SplashScreenEvent.showSplashScreen());
      if (!widget.mediaContent.hasContent) {
        await mediaState.init().whenComplete(() => {
              Timer(
                Duration(seconds: 2),
                () => {
                  appState.updateState(updatedState: true),
                  bloc().add(const SplashScreenEvent.naviagteToHomeScreen()),
                },
              ),
            });
      } else {
        appState.updateState(updatedState: true);
        bloc().add(const SplashScreenEvent.naviagteToHomeScreen());
      }
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
              appState.isStateLoaded &&
              isFolderIntact) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // Add conditional mobile layout
                if (constraints.isMobile) {
                  return MobileHomeScreen(mediaContent: widget.mediaContent);
                }
                return DesktopHomeScreen(mediaContent: widget.mediaContent);
              },
            );
          } else if (!isFolderIntact) {
            return LayoutBuilder(builder: (context, constraints) {
              return Container(
                alignment: Alignment.center,
                child: const Text(
                    'Songs no longer available. Please check your folder configuration'),
              );
            });
          } else {
            return LayoutBuilder(builder: (context, constraints) {
              return Container(
                alignment: Alignment.center,
                child: const Text('App is idle'),
              );
            });
          }
        });
  }
}
