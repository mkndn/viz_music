import 'dart:io';

import 'package:adaptive_components/adaptive_components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myartist/src/shared/enums/state.dart';
import 'package:path_provider/path_provider.dart';

import '../../../shared/providers/preferences.dart';
import '../../../shared/views/outlined_card.dart';

class FolderInfo {
  bool edited;
  Directory? rootDir;
  List<String> folders;
  FolderInfo(this.edited, this.rootDir, this.folders);
}

class FolderPicker extends StatefulWidget {
  const FolderPicker({required this.mode, super.key});

  final FolderMode mode;

  @override
  State<FolderPicker> createState() => _FolderPickerState();
}

class _FolderPickerState extends State<FolderPicker> {
  final Preferences _prefs = Preferences();
  late Future<List<String>> _folders;
  late Future<Directory?> _rootDir;
  late bool _edited = false;

  @override
  void initState() {
    super.initState();
    _loadFolderPrefs();
    _prepareStorage();
  }

  Future<void> _loadFolderPrefs() async {
    setState(() {
      _folders = _prefs.getStringList(widget.mode.text);
    });
  }

  Future<void> _savePrefs() async {
    final folders = await _folders;
    await _prefs.setStringList(widget.mode.text, folders);

    setState(() {
      _edited = false;
    });
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
      _edited = true;
      if (path != null && path.isNotEmpty) {
        _folders = _folders.then((value) {
          List<String> newList = List.from(value);
          newList.add(path);
          return newList;
        });
      }
    });
  }

  Future<FolderInfo> _getData() async {
    List<String> folders = await _folders;
    Directory? rootDir = await _rootDir;
    return FolderInfo(_edited, rootDir, folders);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => AdaptiveContainer(
        columnSpan: 12,
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
                      const SizedBox(
                        width: 400,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: OutlinedCard(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(15),
                        itemCount: snapshot.data?.folders.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(snapshot.data?.folders[index] ?? ''),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        autofocus: snapshot.data?.edited ?? false,
                        onPressed: snapshot.data?.edited ?? false
                            ? () => _savePrefs()
                            : () {},
                        child: const Text('Save'),
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
