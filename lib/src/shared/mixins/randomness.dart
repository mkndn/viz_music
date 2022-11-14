import 'dart:math';

mixin Randomness {
  String randomId(int upperLimit) {
    return Random().nextInt(upperLimit).toString();
  }

  String randomStringId(int upperLimit) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(upperLimit,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }
}
