import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/features/artists/view/artist_list.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/state/inmemory_media_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../features/albums/albums.dart';
import '../features/artists/artists.dart';
import '../features/home/home.dart';
import '../features/playlists/playlists.dart';
import '../features/playlists/view/view.dart';
import '../features/settings/settings.dart';
import '../features/settings/view/view.dart';
import '../features/songs/view/song_list_screen.dart';
import 'views/views.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

const List<NavigationDestination> destinations = [
  NavigationDestination(
    label: 'Home',
    icon: Icon(Icons.home), // Modify this line
    route: '/',
  ),
  NavigationDestination(
    label: 'Songs',
    icon: Icon(Icons.music_note_outlined), // Modify this line
    route: '/songs',
  ),
  NavigationDestination(
    label: 'Albums',
    icon: Icon(Icons.album_rounded), // Modify this line
    route: '/albums',
  ),
  NavigationDestination(
    label: 'Artists',
    icon: Icon(Icons.people), // Modify this line
    route: '/artists',
  ),
  NavigationDestination(
    label: 'Playlists',
    icon: Icon(Icons.playlist_add_circle), // Modify this line
    route: '/playlists',
  ),
  NavigationDestination(
    label: 'Settings',
    icon: Icon(Icons.settings),
    route: '/settings',
  ),
];

class NavigationDestination {
  const NavigationDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

final appRouter = GoRouter(
  routes: [
    // HomeScreen
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 0,
          child: DragToMoveArea(
            child: HomeScreen(
                mediaContent: InMemoryMediaManager.of(context).content),
          ),
        ),
      ),
    ),

    //Songs screen
    GoRoute(
      path: '/songs',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 1,
          child: SongListScreen(
            mediaContent:
                InMemoryMediaManager.of(context, aspect: HiveBox.songs).content,
          ),
        ),
      ),
    ),

    //Albums screen
    GoRoute(
      path: '/albums',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 2,
          child: AlbumsScreen(
            content:
                InMemoryMediaManager.of(context, aspect: HiveBox.songs).content,
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: ':aid',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RootLayout(
              key: _scaffoldKey,
              currentIndex: 2,
              child: AlbumScreen(
                info: InMemoryMediaManager.of(context, aspect: HiveBox.songs)
                    .content,
                title: state.params['aid']!,
              ),
            ),
          ),
        )
      ],
    ),

    // ArtistHomeScreen
    GoRoute(
      path: '/artists',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 3,
          child: ArtistList(
            mediaContent:
                InMemoryMediaManager.of(context, aspect: HiveBox.artists)
                    .content,
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: ':aid',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RootLayout(
              key: _scaffoldKey,
              currentIndex: 3,
              child: ArtistScreen(
                  info: InMemoryMediaManager.of(context, aspect: HiveBox.albums)
                      .content,
                  name: state.params['aid']!),
            ),
          ),
          // builder: (context, state) => ArtistScreen(
          //   id: state.params['aid']!,
          // ),
        ),
      ],
    ),

    // PlaylistHomeScreen
    GoRoute(
      path: '/playlists',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 4,
          child: PlaylistsScreen(
            playlists:
                InMemoryMediaManager.of(context, aspect: HiveBox.playlists)
                    .content
                    .playlists,
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: ':pid',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RootLayout(
              key: _scaffoldKey,
              currentIndex: 4,
              child: PlaylistScreen(
                mediaContent:
                    InMemoryMediaManager.of(context, aspect: HiveBox.songs)
                        .content,
                title: state.params['pid']!,
              ),
            ),
          ),
        ),
      ],
    ),

    // Settings Screen
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 5,
          child: UserPreferences(),
        ),
      ),
      routes: [
        GoRoute(
          path: 'folders',
          pageBuilder: (context, state) => MaterialPage<void>(
            child: FolderConfig(),
          ),
        )
      ],
    ),

    for (final route in destinations.skip(3))
      GoRoute(
        path: route.route,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: _pageKey,
          child: RootLayout(
            key: _scaffoldKey,
            currentIndex: destinations.indexOf(route),
            child: const SizedBox(),
          ),
        ),
      ),
  ],
);
