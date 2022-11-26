import 'package:mkndn/src/shared/classes/song.dart';

typedef Supplier<T> = T Function();
typedef Func<T, R> = R Function(T);
typedef BiFunc<X, Y, R> = R Function(X, Y);
typedef Consumer<T> = void Function(T);
typedef FutureCallback = Future<void> Function();
typedef BiConsumer<T, U> = void Function(T, U);
typedef MapOfSongList = Map<String, List<Song>>;
typedef MapOfStringList = Map<String, List<String>>;

T? castOrNull<T>(dynamic x) => x is T ? x : null;
T castOrFallback<T>(dynamic x, T fallback) => x is T ? x : fallback;
