import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mkndn/src/shared/converters.dart';
import 'package:mkndn/src/shared/mixins/media_util.dart';
import 'package:mkndn/src/shared/models/song.dart';
import 'package:mkndn/src/shared/playback/bloc/playback_bloc.dart';
import 'package:objectid/objectid.dart';

part 'song_queue.freezed.dart';
part 'song_queue.g.dart';

@freezed
class SongQueue with _$SongQueue, MediaUtilMixin {
  const SongQueue._();

  const factory SongQueue({
    required List<Song> songs,
    @ObjectIdConverter() ObjectId? currentPlayingId,
    SongWithProgress? songWithProgress,
  }) = _SongQueue;

  factory SongQueue.initial() => SongQueue(songs: List.empty());

  factory SongQueue.load(List<Song> songs) => SongQueue(songs: songs);

  factory SongQueue.fromJson(Map<String, dynamic> json) =>
      _$SongQueueFromJson(json);

  SongQueue get currentSong => valueOrDefault(() => this, getFirstSong());

  Song getSongById(ObjectId songId) => valueOrDefault(
      () => songs.firstWhereOrNull((e) => e.id == songId), this.songs[0]);

  bool get isEmpty => songs.isEmpty || currentPlayingId == null;

  bool get isNotEmpty => !isEmpty;

  int get currentPlayingIndex => indexWhereOrDefault(
      () => this.songs.indexWhere((element) => element.id == currentPlayingId),
      0);

  bool get isFirstSong => currentPlayingIndex == 0;

  SongQueue? getNext(int repeatMode) {
    if (repeatMode == 0) {
      if (this.isLastSong) {
        return null;
      } else {
        return this.getNextSong();
      }
    }
    if (repeatMode == 1) {
      return this.currentSong;
    }

    if (this.isLastSong) {
      return this.getFirstSong();
    } else {
      return this.getNextSong();
    }
  }

  SongQueue getFirstSong() {
    Song song = this.songs[0];
    return this.copyWith(
        currentPlayingId: song.id,
        songWithProgress: valueOrDefault(
          () => songWithProgress?.copyWith(song: song),
          SongWithProgress.initial(song),
        ));
  }

  SongQueue getLastSong() {
    Song song = this.songs[this.songs.length - 1];
    return this.copyWith(
        currentPlayingId: song.id,
        songWithProgress: valueOrDefault(
          () => songWithProgress?.copyWith(song: song),
          SongWithProgress.initial(song),
        ));
  }

  bool get isLastSong =>
      indexWhereOrDefault(
          () => this
              .songs
              .indexWhere((element) => element.id == currentPlayingId),
          0) ==
      this.songs.length - 1;

  SongQueue getPreviousSong() {
    int indexInQueue = currentPlayingIndex;
    Song previousSong =
        isFirstSong ? this.songs[indexInQueue] : this.songs[indexInQueue - 1];
    return this.copyWith(
        currentPlayingId: previousSong.id,
        songWithProgress: valueOrDefault(
          () => songWithProgress?.copyWith(song: previousSong),
          SongWithProgress.initial(previousSong),
        ));
  }

  SongQueue getNextSong() {
    int indexInQueue = currentPlayingIndex;
    Song nextSong =
        isFirstSong ? this.songs[indexInQueue] : this.songs[indexInQueue + 1];
    return this.copyWith(
        currentPlayingId: nextSong.id,
        songWithProgress: valueOrDefault(
          () => songWithProgress?.copyWith(song: nextSong),
          SongWithProgress.initial(nextSong),
        ));
  }
}
