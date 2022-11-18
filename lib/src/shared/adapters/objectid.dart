import 'package:hive/hive.dart';
import 'package:objectid/objectid.dart';

class ObjectIdAdapter extends TypeAdapter<ObjectId> {
  @override
  int get typeId => 12;

  @override
  ObjectId read(BinaryReader reader) {
    return ObjectId.fromHexString(reader.readString());
  }

  @override
  void write(BinaryWriter writer, ObjectId obj) =>
      writer.writeString(obj.hexString);
}
