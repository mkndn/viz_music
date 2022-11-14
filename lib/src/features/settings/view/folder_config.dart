import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myartist/src/shared/enums/state.dart';

import 'folder_picker.dart';

class FolderConfig extends StatelessWidget {
  const FolderConfig({super.key});

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
            title: const Text('FOLDERS CONFIGURATION'),
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
              SingleChildScrollView(
                child: FolderPicker(
                  mode: FolderMode.included,
                ),
              ),
              SingleChildScrollView(
                child: FolderPicker(
                  mode: FolderMode.excluded,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
