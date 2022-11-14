import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myartist/src/shared/enums/state.dart';

import 'folder_picker.dart';

class FolderConfig extends StatelessWidget {
  const FolderConfig({super.key});

  Future<void> _loadFolderPrefs() async {
    List<String> folderContents = await _prefs.getStringList(widget.mode.text);
    _folders = folderContents
        .map<Folder>((e) => Folder.fromJson(jsonDecode(e)))
        .toList();
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

  Future<FolderInfo> _getData() async {
    Directory? rootDir = await _rootDir;
    return FolderInfo(_edited, rootDir, _folders);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double headerHeight = constraints.maxWidth > 500 ? 25 : 50;
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          primary: false,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => GoRouter.of(context).go('/settings'),
            ),
            title: const Text('Folder Setup'),
            toolbarHeight: kToolbarHeight * 2,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight + headerHeight),
              child: Column(
                children: const [
                  TabBar(
                    tabs: [
                      Tab(
                        text: 'Include',
                        icon: Icon(Icons.add_circle_rounded),
                      ),
                      Tab(
                        text: 'Exclude',
                        icon: Icon(Icons.remove_circle_rounded),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              FolderPicker(
                mode: FolderMode.included,
              ),
              FolderPicker(
                mode: FolderMode.excluded,
              ),
            ],
          ),
        ),
      );
    });
  }
}
