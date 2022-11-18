import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/shared/providers/providers.dart';
import 'package:mkndn/src/shared/state/inmemory_media_manager.dart';
import 'package:mkndn/src/shared/state/inmemory_state_manager.dart';

import 'splash/bloc/splash_screen_bloc.dart';
import 'playback/bloc/bloc.dart';
import 'router.dart';
import 'views/views.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settings = ValueNotifier(ThemeSettings(
    sourceColor: const Color(0xff6750A4), // Replace this color
    themeMode: ThemeMode.system,
  ));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashScreenBloc>(
      create: (context) => SplashScreenBloc(),
      child: BlocProvider<PlaybackBloc>(
        create: (context) => PlaybackBloc(),
        child: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => ThemeProvider(
              lightDynamic: lightDynamic,
              darkDynamic: darkDynamic,
              settings: settings,
              child: NotificationListener<ThemeSettingChange>(
                onNotification: (notification) {
                  settings.value = notification.settings;
                  return true;
                },
                child: ValueListenableBuilder<ThemeSettings>(
                  valueListenable: settings,
                  builder: (context, value, _) {
                    // Create theme instance
                    final theme = ThemeProvider.of(context);
                    return InmemoryStateManager(
                      child: InMemoryMediaManager(
                        child: MaterialApp.router(
                          debugShowCheckedModeBanner: false,
                          title: 'Flutter Demo',
                          // Add theme
                          theme: theme.light(settings.value.sourceColor),
                          // Add dark theme
                          darkTheme: theme.dark(settings.value.sourceColor),
                          // Add theme mode
                          themeMode: theme.themeMode(),
                          routeInformationParser:
                              appRouter.routeInformationParser,
                          routeInformationProvider:
                              appRouter.routeInformationProvider,
                          routerDelegate: appRouter.routerDelegate,
                          builder: (context, child) {
                            return PlayPauseListener(child: child!);
                          },
                        ),
                      ),
                    );
                  },
                ),
              )),
        ),
      ),
    );
  }
}
