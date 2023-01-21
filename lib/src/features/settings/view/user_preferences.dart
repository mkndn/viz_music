import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/splash/bloc/splash_screen_bloc.dart';
import 'package:mkndn/src/shared/state/inmemory_media_manager.dart';

import '../../../shared/views/clickable.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SplashScreenBloc>(context);
    final InMemoryMediaManagerState state = InMemoryMediaManager.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Clickable(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Include/Exclude Folders'),
                    SizedBox(
                      width: 50,
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ),
                onTap: () => GoRouter.of(context).go('/settings/folders'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Text('Reset Settings'),
                  const SizedBox(width: 50),
                  IconButton(
                    onPressed: () {
                      state.resetSettings();
                    },
                    icon: const Icon(Icons.settings_backup_restore),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Text('Clear app data'),
                  const SizedBox(width: 50),
                  IconButton(
                    onPressed: () {
                      state.resetAppData();
                    },
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
