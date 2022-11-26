import 'package:flutter/material.dart';
import 'package:mkndn/src/shared/typedefs.dart';

class StreamLoader<T> extends StatelessWidget {
  const StreamLoader(
      {required this.streamSupplier,
      required this.childLoader,
      this.items = const [],
      super.key});

  final Func<List<T>, Widget> childLoader;
  final Supplier<Stream<T>> streamSupplier;
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: streamSupplier(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              items.add(snapshot.data!);
              return childLoader(items);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }
}
