import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mkndn/src/shared/classes/classes.dart';
import 'package:mkndn/src/shared/enums/state.dart';
import 'package:path_provider/path_provider.dart';

import '../../../shared/providers/preferences.dart';
import '../../../shared/views/outlined_card.dart';

class FolderInfo {
  Directory? rootDir;
  List<Folder> folders;
  FolderInfo(this.rootDir, this.folders);
}

class FolderPicker extends StatefulWidget {
  const FolderPicker({required this.mode, super.key});

  final FolderMode mode;

  @override
  State<FolderPicker> createState() => _FolderPickerState();
}

class _FolderPickerState extends State<FolderPicker> {
  final Preferences _prefs = Preferences();
  late Future<List<Folder>> _folders;
  late Future<Directory?> _rootDir;
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    height = 200.0;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadFolderPrefs();
      _prepareStorage();
    });
  }

  Future<void> _loadFolderPrefs() async {
    setState(() {
      _folders =
          _prefs.getStringList(widget.mode.text).then((folderConfigContent) {
        return folderConfigContent.map((element) {
          return Folder.fromJson(jsonDecode(element));
        }).toList();
      }).then((value) {
        if (value.isNotEmpty) {
          height = determineScrollHeight(
              value.length, MediaQuery.of(context).size.height * 0.5);
        }
        return value;
      });
    });
  }

  Future<void> _savePrefs(List<Folder> folders) async {
    List<String> folderContent =
        folders.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(widget.mode.text, folderContent);
  }

  Future<void> _prepareStorage() async {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      _rootDir = getDownloadsDirectory();
    } else if (Platform.isAndroid || Platform.isIOS) {
      _rootDir = getExternalStorageDirectory();
    } else {
      _rootDir = getTemporaryDirectory();
    }
  }

  Future<void> _selectDir(Directory? dir) async {
    Directory rootDir = dir ?? await getTemporaryDirectory();
    String? path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select folder',
      initialDirectory: rootDir.path,
    );
    setState(() {
      if (path != null && path.isNotEmpty) {
        _folders = _folders.then((value) {
          List<Folder> newList = List.from(value);
          newList.add(Folder(path: path));
          _savePrefs(newList);
          return newList;
        }).then((value) {
          if (value.isNotEmpty) {
            height = determineScrollHeight(
                value.length, MediaQuery.of(context).size.height * 0.5);
          }
          return value;
        });
      }
    });
  }

  Future<void> _removeDir(String? path) async {
    if (path != null && path.isNotEmpty) {
      setState(() {
        _folders = _folders.then((value) {
          List<Folder> newList = List.from(value);
          newList.removeWhere((element) => element.path == path);
          _savePrefs(newList);
          return newList;
        }).then((value) {
          if (value.isNotEmpty) {
            height = determineScrollHeight(
                value.length, MediaQuery.of(context).size.height * 0.5);
          }
          return value;
        });
      });
    }
  }

  Future<FolderInfo> _getData() async {
    List<Folder> folders = await _folders;
    Directory? rootDir = await _rootDir;
    return FolderInfo(rootDir, folders);
  }

  double determineScrollHeight(int foldersCount, double maxHeight) {
    if (foldersCount * 200.0 > maxHeight) {
      return maxHeight - 50;
    }
    return foldersCount * 200.0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: FutureBuilder<FolderInfo>(
          future: _getData(),
          builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: OutlinedButton.icon(
                          label: const Text('Choose'),
                          icon: const Icon(Icons.folder_outlined),
                          onPressed: () => _selectDir(snapshot.data?.rootDir),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedCard(
                        child: Container(
                          height: height,
                          width: constraints.maxWidth * 0.95,
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(15),
                            itemCount: snapshot.data != null
                                ? snapshot.data!.folders.length
                                : 0,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        snapshot.data?.folders[index].path ??
                                            ''),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  IconButton(
                                    onPressed: () => _removeDir(
                                        snapshot.data?.folders[index].path),
                                    icon: Icon(Icons.remove_circle_outline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
