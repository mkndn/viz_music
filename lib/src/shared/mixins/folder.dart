import 'dart:convert';

import 'package:mkndn/src/shared/classes/folder.dart';
import 'package:mkndn/src/shared/typedefs.dart';

mixin FolderMixin {
  List<String> serialiseFolders(List<Folder> folders) =>
      folders.map((e) => jsonEncode(e.toJson())).toList();

  List<Folder> deSerialiseFolders(List<String> foldeContents) =>
      foldeContents.map((e) => Folder.fromJson(jsonDecode(e))).toList();

  List<String> updateFolder(List<String> foldeContents, String path,
      Func<Folder, Folder> updateConsumer) {
    List<Folder> deserialised = deSerialiseFolders(foldeContents);
    int changeIndex =
        deserialised.indexWhere((element) => element.path == path);
    Folder updated = updateConsumer(deserialised.elementAt(changeIndex));
    deserialised.setAll(changeIndex, [updated]);
    return serialiseFolders(deserialised);
  }

  bool areFoldersIntact(
      List<String> foldeContents, Func<String, bool> checkFunc) {
    return deSerialiseFolders(foldeContents)
        .where((matched) => matched.hasContent)
        .where((element) => checkFunc(element.path))
        .isNotEmpty;
  }
}
