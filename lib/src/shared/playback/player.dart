import 'package:audioplayers/audioplayers.dart';

class Player {
  final List<AudioPlayer> players;
  Player._(this.players);

  factory Player.get() => Player._(
      List.generate(4, (_) => AudioPlayer()..setReleaseMode(ReleaseMode.stop)));

  AudioPlayer get nextPlayer => players.first;
}
