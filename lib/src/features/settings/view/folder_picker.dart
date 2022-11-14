import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myartist/src/shared/classes/folder.dart';
import 'package:myartist/src/shared/enums/state.dart';
import 'package:path_provider/path_provider.dart';

import '../../../shared/providers/preferences.dart';
import '../../../shared/views/outlined_card.dart';

class FolderInfo {
  bool edited;
  Directory? rootDir;
  List<Folder> folders;
  FolderInfo(this.edited, this.rootDir, this.folders);
}

class FolderPicker extends StatefulWidget {
  const FolderPicker(
      {required this.mode,
      required this.data,
      required this.rootDir,
      required this.folders,
      super.key});

  final FolderMode mode;
  final Future<FolderInfo> data;
  final Future<Directory?> rootDir;
  final List<Folder> folders;

  @override
  State<FolderPicker> createState() => _FolderPickerState();
}

class _FolderPickerState extends State<FolderPicker> {
  final Preferences _prefs = Preferences();

  Future<void> _savePrefs() async {
    List<String> folderContents =
        widget.folders.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(widget.mode.text, folderContents);
  }

  Future<void> _selectDir(Directory? dir) async {
    Directory rootDir = dir ?? await getTemporaryDirectory();
    String? path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select folder',
      initialDirectory: rootDir.path,
    );
    if (path != null && path.isNotEmpty) {
      widget.folders.add(Folder(path: path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        primary: false,
        child: FutureBuilder<FolderInfo>(
          future: widget.data,
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
                  SizedBox(
                    height: snapshot.data != null
                        ? snapshot.data!.folders.length * 200
                        : 100,
                    child: OutlinedCard(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(15),
                        itemCount: snapshot.data?.folders.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(snapshot.data?.folders[index].path ?? ''),
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
