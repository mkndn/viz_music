import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/enums/repeat_mode.dart';

class RepeatModeAdapter extends TypeAdapter<RepeatMode> {
  @override
  final typeId = 11;

  @override
  void write(BinaryWriter writer, RepeatMode value) =>
      writer.writeString(value.name);

  @override
  RepeatMode read(BinaryReader reader) =>
      RepeatMode.of(reader.readString(), RepeatMode.noRepeat);
}
