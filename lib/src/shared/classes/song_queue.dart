import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mkndn/src/shared/mixins/media_util.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/playback/bloc/playback_bloc.dart';

part 'song_queue.freezed.dart';
part 'song_queue.g.dart';

@freezed
class SongQueue with _$SongQueue, MediaUtilMixin {
  const SongQueue._();

  const factory SongQueue({
    required List<Song> songs,
    String? currentPlayingTitle,
    SongWithProgress? songWithProgress,
  }) = _SongQueue;

  factory SongQueue.initial() => SongQueue(songs: List.empty());

  factory SongQueue.load(List<Song> songs) => SongQueue(songs: songs);

  factory SongQueue.fromJson(Map<String, dynamic> json) =>
      _$SongQueueFromJson(json);

  @override
  bool operator ==(other) {
    return (other is SongQueue) &&
        listEquals(this.songs, other.songs) &&
        this.songWithProgress == other.songWithProgress;
  }

  SongQueue addSong(Song song) {
    this.songs.add(song);
    return this;
  }

  Song get currentSong => valueOrDefault(
      () => this.getSongByTitle(this.currentPlayingTitle!), getFirstSong());

  Song getSongByTitle(String songTitle) => valueOrDefault(
      () => songs.firstWhereOrNull((e) => e.title == songTitle), this.songs[0]);

  bool get isEmpty => songs.isEmpty || currentPlayingTitle == null;

  bool get isNotEmpty => !isEmpty;

  int get currentPlayingIndex => indexWhereOrDefault(
      () => this.songs.indexWhere((song) => song.title == currentPlayingTitle),
      0);

  bool get isFirstSong => currentPlayingIndex == 0;

  Song? getNext(int repeatMode) {
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

  Song getFirstSong() {
    return this.songs[0];
  }

  Song getLastSong() {
    return this.songs[this.songs.length - 1];
  }

  bool get isLastSong =>
      indexWhereOrDefault(
          () => this
              .songs
              .indexWhere((element) => element.title == currentPlayingTitle),
          0) ==
      this.songs.length - 1;

  Song getPreviousSong() {
    int indexInQueue = currentPlayingIndex;
    return isFirstSong
        ? this.songs[indexInQueue]
        : this.songs[indexInQueue - 1];
  }

  Song getNextSong() {
    int indexInQueue = currentPlayingIndex;
    return isLastSong ? this.songs[indexInQueue] : this.songs[indexInQueue + 1];
  }
}
