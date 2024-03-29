import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/typedefs.dart';
import '../extensions.dart';
import 'image_clipper.dart';

class SideBar extends StatelessWidget {
  const SideBar({required this.playlists, super.key});

  final MapOfStringList playlists;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => GoRouter.of(context).go('/'),
          ),
          const ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Artists'),
            onTap: () => GoRouter.of(context).go('/artists'),
          ),
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text('Playlists'),
            onTap: () => GoRouter.of(context).go('/playlists'),
          ),
          for (String playlistTitle in playlists.keys)
            ListTile(
              title: Text(playlistTitle),
              onTap: () =>
                  GoRouter.of(context).go('/playlists/${playlistTitle}'),
            ),
        ],
      ),
    );
  }
}

class PlaylistNav extends StatelessWidget {
  const PlaylistNav({required this.playlists, super.key});

  final MapOfStringList playlists;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    return Container(
      color: colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Playlists',
              style: context.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              controller: ScrollController(),
              children: [
                for (String playlistTitle in playlists.keys)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: _PlaylistNavItem(
                      playlistTitle: playlistTitle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaylistNavItem extends StatefulWidget {
  const _PlaylistNavItem({
    required this.playlistTitle,
    this.image,
  });

  final Uint8List? image;
  final String playlistTitle;

  @override
  State<_PlaylistNavItem> createState() => _PlaylistNavItemState();
}

class _PlaylistNavItemState extends State<_PlaylistNavItem> {
  bool _isSelected = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: widget.playlistTitle)
      ..addListener(() {
        setState(() => _isSelected = _focusNode.hasPrimaryFocus);
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.image != null ? ClippedImage(widget.image!) : null,
      title: Text(
        widget.playlistTitle,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: context.labelSmall!.copyWith(
          fontStyle: _isSelected ? FontStyle.italic : null,
          decoration: _isSelected ? TextDecoration.underline : null,
        ),
      ),
      onTap: () =>
          GoRouter.of(context).go('/playlists/${widget.playlistTitle}'),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
      selected: _isSelected,
      focusNode: _focusNode,
    );
  }
}
