enum FolderMode {
  included('Folders.included'),
  excluded('Folders.excluded');

  final String text;

  const FolderMode(this.text);
}

enum SongListDisplayState { display, sortedBy, sortMode }

enum PlayerStateKey {
  queue,
  progress,
  isMuted,
  isPlaying,
  volume,
  previousVolume,
  isFullPlayerOn,
  repeatMode,
}
