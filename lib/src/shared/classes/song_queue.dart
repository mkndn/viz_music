import 'package:collection/collection.dart';
import 'package:mkndn/src/shared/mixins/media_util.dart';
import 'package:mkndn/src/shared/models/models.dart';
import 'package:objectid/objectid.dart';

class SongQueue with MediaUtilMixin {
  List<Song> songs;
  ObjectId? currentPlayingId;

  SongQueue._({required this.songs, required this.currentPlayingId});

  factory SongQueue.instance() =>
      SongQueue._(songs: List.empty(), currentPlayingId: null);

  factory SongQueue.init(List<Song> songs, ObjectId currentPlayingId) =>
      SongQueue._(songs: songs, currentPlayingId: currentPlayingId);

  Song get currentSong => valueOrDefault(
      () => songs.firstWhereOrNull((e) => e.id == currentPlayingId),
      getFirstSong());

  Song getSongById(ObjectId songId) => valueOrDefault(
      () => songs.firstWhereOrNull((e) => e.id == songId), getFirstSong());

  bool get isEmpty => songs.isEmpty || currentPlayingId == null;

  bool get isNotEmpty => !isEmpty;

  int get currentPlayingIndex => indexWhereOrDefault(
      () => this.songs.indexWhere((element) => element.id == currentPlayingId),
      0);

  bool get isFirstSong => currentPlayingIndex == 0;

  Song getFirstSong() {
    Song song = this.songs[0];
    this.currentPlayingId = song.id;
    return song;
  }

  Song getLastSong() {
    Song song = this.songs[this.songs.length - 1];
    this.currentPlayingId = song.id;
    return song;
  }

  bool get isLastSong =>
      indexWhereOrDefault(
          () => this
              .songs
              .indexWhere((element) => element.id == currentPlayingId),
          0) ==
      this.songs.length - 1;

  Song getPreviousSong() {
    int indexInQueue = currentPlayingIndex;
    Song previousSong =
        isFirstSong ? this.songs[indexInQueue] : this.songs[indexInQueue - 1];
    this.currentPlayingId = previousSong.id;
    return previousSong;
  }

  Song getNextSong() {
    int indexInQueue = currentPlayingIndex;
    Song nextSong =
        isFirstSong ? this.songs[indexInQueue] : this.songs[indexInQueue + 1];
    this.currentPlayingId = nextSong.id;
    return nextSong;
  }
}
