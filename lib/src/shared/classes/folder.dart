import 'package:freezed_annotation/freezed_annotation.dart';
part 'folder.freezed.dart';
part 'folder.g.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    @Default('') String path,
    @Default(false) bool hasContent,
  }) = _Folder;

  factory Folder.initial() => Folder();

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
}
