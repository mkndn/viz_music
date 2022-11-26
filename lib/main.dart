import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/adapters/duration.dart';
import 'package:mkndn/src/shared/adapters/repeat_mode.dart';
import 'package:mkndn/src/shared/adapters/song_queue.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

import 'src/shared/app.dart';

Future setDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(const Size(400, 400));
  await DesktopWindow.setWindowSize(const Size(1300, 900));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive
    ..init(Directory.current.path)
    ..registerAdapter(DurationAdapter())
    ..registerAdapter(RepeatModeAdapter())
    ..registerAdapter(SongQueueAdapter());

  await Hive.openBox<Song>(HiveBox.songs.key);
  await Hive.openBox<dynamic>(HiveBox.state.key);

  if (UniversalPlatform.isDesktop) {
    //setDesktopWindow();
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(1000, 800),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(MyApp());
}
