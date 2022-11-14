import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myartist/src/shared/adapters/duration.dart';
import 'package:myartist/src/shared/adapters/repeat_mode.dart';
import 'package:myartist/src/shared/classes/album.dart';
import 'package:myartist/src/shared/classes/artist.dart';
import 'package:myartist/src/shared/classes/playlist.dart';
import 'package:myartist/src/shared/classes/ranked.dart';
import 'package:myartist/src/shared/classes/song.dart';
import 'package:myartist/src/shared/enums/hive_box.dart';
import 'package:universal_platform/universal_platform.dart';

import 'src/shared/app.dart';

Future setDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(const Size(400, 400));
  await DesktopWindow.setWindowSize(const Size(1300, 900));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive
    ..init(Directory.current.path)
    ..registerAdapter(RankedAdapter())
    ..registerAdapter(DurationAdapter())
    ..registerAdapter(RepeatModeAdapter())
    ..registerAdapter(PlaylistAdapter())
    ..registerAdapter(ArtistAdapter())
    ..registerAdapter(AlbumAdapter())
    ..registerAdapter(SongAdapter());

  await Hive.openBox<Song>(HiveBox.songs.key);
  await Hive.openBox<Album>(HiveBox.albums.key);
  await Hive.openBox<Artist>(HiveBox.artists.key);
  await Hive.openBox<Playlist>(HiveBox.playlists.key);
  await Hive.openBox<dynamic>(HiveBox.state.key);

  if (UniversalPlatform.isDesktop) {
    setDesktopWindow();
  }

  runApp(MyApp());
}
