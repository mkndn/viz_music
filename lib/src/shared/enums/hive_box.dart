enum HiveBox {
  songs(key: 'media.songs'),
  artists(key: 'media.artists'),
  albums(key: 'media.albums'),
  playlists(key: 'media.playlists'),
  state(key: 'player.state');

  const HiveBox({required this.key});

  final String key;
}
