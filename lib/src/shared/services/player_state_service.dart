import 'package:hive_flutter/hive_flutter.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/services/hive_services.dart';

class PlayerStateService extends HiveService<dynamic> {
  final Box<dynamic> _box;

  PlayerStateService._(this._box);

  factory PlayerStateService.instance() {
    return PlayerStateService._(Hive.box<dynamic>(HiveBox.state.key));
  }

  Box<dynamic> getBox() => _box;
}
