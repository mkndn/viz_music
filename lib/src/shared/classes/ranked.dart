import 'package:hive/hive.dart';
part 'ranked.g.dart';

@HiveType(typeId: 0)
class Ranked extends HiveObject {
  @HiveField(7)
  int listenCount;
  @HiveField(8)
  final DateTime dateAdded;
  @HiveField(9)
  DateTime? dateLastListened;

  Ranked({
    required this.dateAdded,
    this.dateLastListened,
    this.listenCount = 0,
  });
}
