import 'package:flutter/material.dart';
import 'package:mkndn/src/shared/animations/expand_icon.dart';

class SearchBar extends StatelessWidget {
  final bool isSearching;
  SearchBar({required this.isSearching});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        EspandIconAnimation(
          animate: !isSearching,
          axisAlignment: 1.0,
          child: Text('All Songs'),
        ),
        EspandIconAnimation(
          animate: isSearching,
          axisAlignment: -1.0,
          child: _Search(),
        ),
      ],
    );
  }
}

class _Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search for...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(.4),
        ),
      ),
    );
  }
}
