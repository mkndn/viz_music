typedef Supplier<T> = T Function();
typedef Func<T, R> = R Function(T);
typedef BiFunc<X, Y, R> = R Function(X, Y);
typedef Consumer<T> = void Function(T);
typedef BiConsumer<T, U> = void Function(T, U);

T? castOrNull<T>(dynamic x) => x is T ? x : null;
T castOrFallback<T>(dynamic x, T fallback) => x is T ? x : fallback;
